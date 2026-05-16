package com.bikerental.BikeRentalSystem.service;

import com.bikerental.BikeRentalSystem.model.*;
import com.bikerental.BikeRentalSystem.util.AppConstants;
import com.bikerental.BikeRentalSystem.util.FileHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.LinkedList;
import java.util.Queue;

@Service
public class RentalService {
    private final Queue<String> rentalRequestQueue = new LinkedList<>();

    private static final DateTimeFormatter FMT =
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public void enqueueRentalRequest(String bikeId) {
        rentalRequestQueue.add(bikeId);
    }

    public String dequeueRentalRequest() {
        return rentalRequestQueue.poll();
    }

    public Queue<String> getRentalRequestQueue() {
        return rentalRequestQueue;
    }

    @Autowired
    private ExtraService extraService;

    private Rental parseLine(String line) {
        String[] p = line.split("\\" + AppConstants.SEP);
        if (p.length < 12) return null;

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
        String extrasIds    = p[10];
        double extrasCost   = Double.parseDouble(p[11]);

        if (AppConstants.RENTAL_HOURLY.equals(type)) {
            return new HourlyRental(id, userId, bikeId, startStation, endStation,
                    startTime, endTime, cost, status, extrasIds, extrasCost);
        } else {
            return new DailyRental(id, userId, bikeId, startStation, endStation,
                    startTime, endTime, cost, status, extrasIds, extrasCost);
        }
    }

    private double getBikePrice(String bikeId) {
        String line = FileHelper.findById(AppConstants.BIKES_FILE, bikeId);
        if (line == null) return 0;
        String[] p = line.split("\\" + AppConstants.SEP);
        return p.length >= 5 ? Double.parseDouble(p[4]) : 0;   // index 4 = pricePerHour
    }

    private void setBikeStatus(String bikeId, String status) {
        List<String> lines  = FileHelper.readAll(AppConstants.BIKES_FILE);
        List<String> result = new ArrayList<>();
        for (String line : lines) {
            String[] p = line.split("\\" + AppConstants.SEP);
            if (p[0].equals(bikeId) && p.length >= 7) {
                p[6] = status;                                   // index 6 = status
                result.add(String.join(AppConstants.SEP, p));
            } else {
                result.add(line);
            }
        }
        FileHelper.writeAll(AppConstants.BIKES_FILE, result);
    }

    public List<Rental> readAll() {
        List<Rental> rentals = new ArrayList<>();
        for (String line : FileHelper.readAll(AppConstants.RENTALS_FILE)) {
            Rental r = parseLine(line);
            if (r != null) rentals.add(r);
        }
        return rentals;
    }

    public List<Rental> findByUser(String userId) {
        List<Rental> result = new ArrayList<>();
        for (Rental r : readAll()) {
            if (r.getUserId().equals(userId)) result.add(r);
        }
        return result;
    }

    public Rental findById(String id) {
        String line = FileHelper.findById(AppConstants.RENTALS_FILE, id);
        return line != null ? parseLine(line) : null;
    }

    public boolean rentBike(String userId, String bikeId, String startStation, String endStation, String type, List<String> selectedExtraIds) {

        enqueueRentalRequest(bikeId);
        String requestedBikeId = dequeueRentalRequest();
        if (requestedBikeId == null || !requestedBikeId.equals(bikeId)) return false;

        String bikeLine = FileHelper.findById(AppConstants.BIKES_FILE, bikeId);
        if (bikeLine == null) return false;
        String[] bp = bikeLine.split("\\" + AppConstants.SEP);
        if (bp.length < 7 || !AppConstants.BIKE_AVAILABLE.equals(bp[6])) return false;

        double extrasCost = 0.0;
        String extrasIds  = "";
        if (selectedExtraIds != null && !selectedExtraIds.isEmpty()) {
            List<String> validIds = new ArrayList<>();
            for (String eid : selectedExtraIds) {
                Extra extra = extraService.findById(eid);
                if (extra != null) {
                    validIds.add(eid);
                    if (!extra.isIncluded()) {
                        extrasCost += extra.getPricePerRental();
                    }
                }
            }
            extrasIds = String.join(",", validIds);
        }

        String id        = FileHelper.generateId();
        String startTime = LocalDateTime.now().format(FMT);

        Rental rental;
        if (AppConstants.RENTAL_HOURLY.equals(type)) {
            rental = new HourlyRental(id, userId, bikeId, startStation, endStation,
                    startTime, "", 0, AppConstants.RENTAL_ACTIVE,
                    extrasIds, extrasCost);
        } else {
            rental = new DailyRental(id, userId, bikeId, startStation, endStation,
                    startTime, "", 0, AppConstants.RENTAL_ACTIVE,
                    extrasIds, extrasCost);
        }

        boolean saved = FileHelper.append(AppConstants.RENTALS_FILE, rental.toFileString());
        if (saved) setBikeStatus(bikeId, AppConstants.BIKE_RENTED);
        return saved;
    }

    public double returnBike(String rentalId) {
        Rental rental = findById(rentalId);
        if (rental == null || !rental.isActive()) return -1;

        String endTime = LocalDateTime.now().format(FMT);
        rental.setEndTime(endTime);
        rental.setStatus(AppConstants.RENTAL_COMPLETED);

        double bikePrice = getBikePrice(rental.getBikeId());
        double baseCost  = rental.calculateCost(bikePrice);
        double totalCost = baseCost + rental.getExtrasCost();
        rental.setCost(totalCost);

        List<String> lines  = FileHelper.readAll(AppConstants.RENTALS_FILE);
        List<String> result = new ArrayList<>();
        for (String line : lines) {
            String[] p = line.split("\\" + AppConstants.SEP);
            result.add(p[0].equals(rentalId) ? rental.toFileString() : line);
        }
        FileHelper.writeAll(AppConstants.RENTALS_FILE, result);
        setBikeStatus(rental.getBikeId(), AppConstants.BIKE_AVAILABLE);
        return totalCost;
    }

    public boolean cancel(String rentalId) {
        Rental rental = findById(rentalId);
        if (rental == null || !rental.isActive()) return false;

        rental.setStatus(AppConstants.RENTAL_CANCELLED);
        List<String> lines  = FileHelper.readAll(AppConstants.RENTALS_FILE);
        List<String> result = new ArrayList<>();
        for (String line : lines) {
            String[] p = line.split("\\" + AppConstants.SEP);
            result.add(p[0].equals(rentalId) ? rental.toFileString() : line);
        }
        FileHelper.writeAll(AppConstants.RENTALS_FILE, result);
        setBikeStatus(rental.getBikeId(), AppConstants.BIKE_AVAILABLE);
        return true;
    }
}