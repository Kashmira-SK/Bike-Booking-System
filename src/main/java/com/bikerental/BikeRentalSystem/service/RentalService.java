package com.bikerental.BikeRentalSystem.service;

import com.bikerental.BikeRentalSystem.model.*;
import com.bikerental.BikeRentalSystem.util.AppConstants;
import com.bikerental.BikeRentalSystem.util.FileHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

@Service
public class RentalService {

    @Autowired
    private BikeService bikeService;

    private final Queue<String> rentalRequestQueue = new LinkedList<>();
    private static final DateTimeFormatter FMT = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public void enqueueRentalRequest(String bikeId) { rentalRequestQueue.add(bikeId); }
    public String dequeueRentalRequest()            { return rentalRequestQueue.poll(); }
    public Queue<String> getRentalRequestQueue()    { return rentalRequestQueue; }

    // ── Cost calculation (single source of truth) ────────────────────────────

    private double calculateCost(Rental rental, double pricePerHour) {
        if (rental.getEndTime() == null || rental.getEndTime().isEmpty()) return 0;
        LocalDateTime start = LocalDateTime.parse(rental.getStartTime(), FMT);
        LocalDateTime end   = LocalDateTime.parse(rental.getEndTime(),   FMT);

        if (AppConstants.RENTAL_HOURLY.equals(rental.getRentalType())) {
            long minutes = ChronoUnit.MINUTES.between(start, end);
            double hours = Math.max(1, Math.ceil(minutes / 60.0));
            return hours * pricePerHour;
        } else {
            long hours = ChronoUnit.HOURS.between(start, end);
            double days = Math.max(1, Math.ceil(hours / 24.0));
            return days * pricePerHour * 20;   // daily discount vs hourly * 24
        }
    }

    // ── Parsing ──────────────────────────────────────────────────────────────

    private Rental parseLine(String line) {
        String[] p = line.split("\\" + AppConstants.SEP, -1);
        if (p.length < 10) return null;
        String id           = p[0];
        String userId       = p[1];
        String bikeId       = p[2];
        String startStation = p[3];
        String endStation   = p[4];
        String startTime    = p[5];
        String endTime      = p[6];
        double cost         = Double.parseDouble(p[7]);
        String status       = p[8];
        String type         = p[9];

        if (AppConstants.RENTAL_HOURLY.equals(type)) {
            return new HourlyRental(id, userId, bikeId, startStation, endStation,
                    startTime, endTime, cost, status);
        } else {
            return new DailyRental(id, userId, bikeId, startStation, endStation,
                    startTime, endTime, cost, status);
        }
    }

    // ── Read ─────────────────────────────────────────────────────────────────

    public List<Rental> readAll() {
        List<Rental> rentals = new ArrayList<>();
        for (String line : FileHelper.readAll(AppConstants.RENTALS_FILE)) {
            Rental r = parseLine(line);
            if (r != null) rentals.add(r);
        }
        return rentals;
    }

    public Rental findById(String id) {
        String line = FileHelper.findById(AppConstants.RENTALS_FILE, id);
        return line != null ? parseLine(line) : null;
    }

    public List<Rental> findByUser(String userId) {
        List<Rental> result = new ArrayList<>();
        for (Rental r : readAll()) {
            if (r.getUserId().equals(userId)) result.add(r);
        }
        return result;
    }

    // ── Write helpers ────────────────────────────────────────────────────────

    private void updateRentalInFile(Rental rental) {
        List<String> lines  = FileHelper.readAll(AppConstants.RENTALS_FILE);
        List<String> result = new ArrayList<>();
        for (String line : lines) {
            String[] p = line.split("\\" + AppConstants.SEP, -1);
            result.add(p[0].equals(rental.getId()) ? rental.toFileString() : line);
        }
        FileHelper.writeAll(AppConstants.RENTALS_FILE, result);
    }

    // ── Business operations ──────────────────────────────────────────────────

    public boolean rentBike(String userId, String bikeId,
                            String startStation, String endStation, String type) {
        // Queue-based request handling (data structure requirement)
        enqueueRentalRequest(bikeId);
        String requestedBikeId = dequeueRentalRequest();
        if (requestedBikeId == null || !requestedBikeId.equals(bikeId)) return false;

        // Validate bike is available
        Bike bike = bikeService.findById(bikeId);
        if (bike == null || !bike.isAvailable()) return false;

        // Create rental
        String id = FileHelper.generateId();
        Rental rental;
        if (AppConstants.RENTAL_HOURLY.equals(type)) {
            rental = new HourlyRental(id, userId, bikeId, startStation, endStation,
                    LocalDateTime.now().format(FMT), "", 0, AppConstants.RENTAL_ACTIVE);
        } else {
            rental = new DailyRental(id, userId, bikeId, startStation, endStation,
                    LocalDateTime.now().format(FMT), "", 0, AppConstants.RENTAL_ACTIVE);
        }

        boolean saved = FileHelper.append(AppConstants.RENTALS_FILE, rental.toFileString());
        if (saved) bikeService.updateStatus(bikeId, AppConstants.BIKE_RENTED);
        return saved;
    }

    public double returnBike(String rentalId) {
        Rental rental = findById(rentalId);
        if (rental == null || !rental.isActive()) return -1;

        // Calculate cost here — single source of truth
        Bike bike = bikeService.findById(rental.getBikeId());
        double pricePerHour = bike != null ? bike.getPricePerHour() : 0;

        rental.setEndTime(LocalDateTime.now().format(FMT));
        rental.setStatus(AppConstants.RENTAL_COMPLETED);
        rental.setCost(calculateCost(rental, pricePerHour));

        updateRentalInFile(rental);
        bikeService.updateStatus(rental.getBikeId(), AppConstants.BIKE_AVAILABLE);
        return rental.getCost();
    }

    public boolean cancel(String rentalId) {
        Rental rental = findById(rentalId);
        if (rental == null || !rental.isActive()) return false;

        rental.setStatus(AppConstants.RENTAL_CANCELLED);
        updateRentalInFile(rental);
        bikeService.updateStatus(rental.getBikeId(), AppConstants.BIKE_AVAILABLE);
        return true;
    }
}