package com.bikerental.BikeRentalSystem.service;

import com.bikerental.BikeRentalSystem.model.*;
import com.bikerental.BikeRentalSystem.util.AppConstants;
import com.bikerental.BikeRentalSystem.util.FileHelper;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class BikeService {

    private Bike parseLine(String line) {
        String[] p = line.split("\\" + AppConstants.SEP);
        if (p.length < 9) return null;

        String id           = p[0];
        String sellerId     = p[1];
        String type         = p[2];
        String model        = p[3];
        double pricePerHour = Double.parseDouble(p[4]);
        String stationId    = p[5];
        String status       = p[6];
        String imageUrl     = p[7];

        String description  = p[8];

        switch (type) {
            case "MOUNTAIN":
                return new MountainBike(id, sellerId, model, pricePerHour, stationId, status, imageUrl, description);
            case "ROAD":
                return new RoadBike(id, sellerId, model, pricePerHour, stationId, status, imageUrl, description);
            case "ELECTRIC":
                return new ElectricBike(id, sellerId, model, pricePerHour, stationId, status, imageUrl, description);
            default:
                return null;
        }
    }

    public List<Bike> readAll() {
        List<Bike> bikes = new ArrayList<>();
        for (String line : FileHelper.readAll(AppConstants.BIKES_FILE)) {
            Bike b = parseLine(line);
            if (b != null) bikes.add(b);
        }
        return bikes;
    }

    public Bike findById(String id) {
        String line = FileHelper.findById(AppConstants.BIKES_FILE, id);
        return line != null ? parseLine(line) : null;
    }

    public List<Bike> findByStation(String stationId) {
        List<Bike> result = new ArrayList<>();
        for (Bike b : readAll()) {
            if (b.getStationId().equals(stationId)) result.add(b);
        }
        return result;
    }

    public List<Bike> findBySeller(String sellerId) {
        List<Bike> result = new ArrayList<>();
        for (Bike b : readAll()) {
            if (b.getSellerId().equals(sellerId)) result.add(b);
        }
        return result;
    }

    public List<Bike> findAvailable() {
        List<Bike> result = new ArrayList<>();
        for (Bike b : readAll()) {
            if (b.isAvailable()) result.add(b);
        }
        return result;
    }

    /**
     * Creates and persists a new bike.
     *
     * @param sellerId    userId of the seller, or "ADMIN" for admin-added bikes
     * @param type        MOUNTAIN | ROAD | ELECTRIC
     * @param model       model name
     * @param pricePerHour hourly rate
     * @param stationId   station the bike belongs to
     * @param imageUrl    URL string, may be empty
     * @param description short text (no pipe characters)
     */
    public boolean create(String sellerId, String type, String model,
                          double pricePerHour, String stationId,
                          String imageUrl, String description) {
        String id = FileHelper.generateId();
        // Sanitise: descriptions must not contain the separator
        String safeDesc = description == null ? "" : description.replace("|", "-");
        String safeImg  = imageUrl    == null ? "" : imageUrl;
        String safeSelr = sellerId    == null ? "ADMIN" : sellerId;

        Bike bike;
        switch (type) {
            case "MOUNTAIN":
                bike = new MountainBike(id, safeSelr, model, pricePerHour, stationId,
                        AppConstants.BIKE_AVAILABLE, safeImg, safeDesc);
                break;
            case "ROAD":
                bike = new RoadBike(id, safeSelr, model, pricePerHour, stationId,
                        AppConstants.BIKE_AVAILABLE, safeImg, safeDesc);
                break;
            case "ELECTRIC":
                bike = new ElectricBike(id, safeSelr, model, pricePerHour, stationId,
                        AppConstants.BIKE_AVAILABLE, safeImg, safeDesc);
                break;
            default:
                return false;
        }
        return FileHelper.append(AppConstants.BIKES_FILE, bike.toFileString());
    }

    public boolean updateStatus(String id, String status) {
        Bike bike = findById(id);
        if (bike == null) return false;
        bike.setStatus(status);
        return update(bike);
    }

    public boolean update(Bike updated) {
        List<String> lines  = FileHelper.readAll(AppConstants.BIKES_FILE);
        List<String> result = new ArrayList<>();
        boolean found = false;
        for (String line : lines) {
            String[] p = line.split("\\" + AppConstants.SEP);
            if (p[0].equals(updated.getId())) {
                result.add(updated.toFileString());
                found = true;
            } else {
                result.add(line);
            }
        }
        if (found) FileHelper.writeAll(AppConstants.BIKES_FILE, result);
        return found;
    }

    public boolean delete(String id) {
        return FileHelper.deleteById(AppConstants.BIKES_FILE, id);
    }
}