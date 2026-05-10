package com.bikerental.BikeRentalSystem.service;

import com.bikerental.BikeRentalSystem.model.*;
import com.bikerental.BikeRentalSystem.util.AppConstants;
import com.bikerental.BikeRentalSystem.util.FileHelper;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Service
public class RentalService {

    private static final DateTimeFormatter FMT = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    private Rental parseLine(String line) {
        String[] p = line.split("\\" + AppConstants.SEP);
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
            return new HourlyRental(id, userId, bikeId, startStation, endStation, startTime, endTime, cost, status);
        } else {
            return new DailyRental(id, userId, bikeId, startStation, endStation, startTime, endTime, cost, status);
        }
    }

    // Read bike's pricePerHour directly from bikes.txt
    private double getBikePrice(String bikeId) {
        String line = FileHelper.findById(AppConstants.BIKES_FILE, bikeId);
        if (line == null) return 0;
        String[] p = line.split("\\" + AppConstants.SEP);
        return p.length >= 4 ? Double.parseDouble(p[3]) : 0;
    }

    // Set bike status directly in bikes.txt
    private void setBikeStatus(String bikeId, String status) {
        List<String> lines = FileHelper.readAll(AppConstants.BIKES_FILE);
        List<String> result = new ArrayList<>();
        for (String line : lines) {
            String[] p = line.split("\\" + AppConstants.SEP);
            if (p[0].equals(bikeId) && p.length >= 6) {
                p[5] = status;
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

    public boolean rentBike(String userId, String bikeId, String startStation, String endStation, String type) {
        // Check bike is available
        String bikeLine = FileHelper.findById(AppConstants.BIKES_FILE, bikeId);
        if (bikeLine == null) return false;
        String[] p = bikeLine.split("\\" + AppConstants.SEP);
        if (!AppConstants.BIKE_AVAILABLE.equals(p[5])) return false;

        String id        = FileHelper.generateId();
        String startTime = LocalDateTime.now().format(FMT);

        Rental rental;
        if (AppConstants.RENTAL_HOURLY.equals(type)) {
            rental = new HourlyRental(id, userId, bikeId, startStation, endStation, startTime, "", 0, AppConstants.RENTAL_ACTIVE);
        } else {
            rental = new DailyRental(id, userId, bikeId, startStation, endStation, startTime, "", 0, AppConstants.RENTAL_ACTIVE);
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

        double price = getBikePrice(rental.getBikeId());
        double cost  = rental.calculateCost(price);
        rental.setCost(cost);

        // Update rental record
        List<String> lines = FileHelper.readAll(AppConstants.RENTALS_FILE);
        List<String> result = new ArrayList<>();
        for (String line : lines) {
            String[] p = line.split("\\" + AppConstants.SEP);
            if (p[0].equals(rentalId)) {
                result.add(rental.toFileString());
            } else {
                result.add(line);
            }
        }
        FileHelper.writeAll(AppConstants.RENTALS_FILE, result);
        setBikeStatus(rental.getBikeId(), AppConstants.BIKE_AVAILABLE);
        return cost;
    }

    public boolean cancel(String rentalId) {
        Rental rental = findById(rentalId);
        if (rental == null || !rental.isActive()) return false;
        rental.setStatus(AppConstants.RENTAL_CANCELLED);
        List<String> lines = FileHelper.readAll(AppConstants.RENTALS_FILE);
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