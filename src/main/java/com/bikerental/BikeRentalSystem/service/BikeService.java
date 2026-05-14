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
        if (p.length < 6) return null;
        String id          = p[0];
        String type        = p[1];
        String model       = p[2];
        double pricePerHour = Double.parseDouble(p[3]);
        String stationId   = p[4];
        String status      = p[5];

        switch (type) {
            case "MOUNTAIN": return new MountainBike(id, model, pricePerHour, stationId, status);
            case "ROAD":     return new RoadBike(id, model, pricePerHour, stationId, status);
            case "ELECTRIC": return new ElectricBike(id, model, pricePerHour, stationId, status);
            default:         return null;
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

    public List<Bike> findAvailable() {
        List<Bike> result = new ArrayList<>();
        for (Bike b : readAll()) {
            if (b.isAvailable()) result.add(b);
        }
        return result;
    }

    public boolean create(String type, String model, double pricePerHour, String stationId) {
        String id = FileHelper.generateId();
        Bike bike;
        switch (type) {
            case "MOUNTAIN": bike = new MountainBike(id, model, pricePerHour, stationId, AppConstants.BIKE_AVAILABLE); break;
            case "ROAD":     bike = new RoadBike(id, model, pricePerHour, stationId, AppConstants.BIKE_AVAILABLE); break;
            case "ELECTRIC": bike = new ElectricBike(id, model, pricePerHour, stationId, AppConstants.BIKE_AVAILABLE); break;
            default: return false;
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
        List<String> lines = FileHelper.readAll(AppConstants.BIKES_FILE);
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