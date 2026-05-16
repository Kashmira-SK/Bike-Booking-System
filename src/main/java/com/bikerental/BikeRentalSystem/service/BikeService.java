package com.bikerental.BikeRentalSystem.service;

import com.bikerental.BikeRentalSystem.model.*;
import com.bikerental.BikeRentalSystem.util.AppConstants;
import com.bikerental.BikeRentalSystem.util.FileHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class BikeService {

    @Autowired
    private StationService stationService;

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

    private void quickSort(List<Bike> bikes, int low, int high) {
        if (low < high) {
            int pi = partition(bikes, low, high);
            quickSort(bikes, low, pi - 1);
            quickSort(bikes, pi + 1, high);
        }
    }

    private int partition(List<Bike> bikes, int low, int high) {
        double pivot = bikes.get(high).getPricePerHour();
        int i = low - 1;
        for (int j = low; j < high; j++) {
            if (bikes.get(j).getPricePerHour() <= pivot) {
                i++;
                Bike temp = bikes.get(i);
                bikes.set(i, bikes.get(j));
                bikes.set(j, temp);
            }
        }
        Bike temp = bikes.get(i + 1);
        bikes.set(i + 1, bikes.get(high));
        bikes.set(high, temp);
        return i + 1;
    }

    public List<Bike> findAvailableSorted() {
        List<Bike> available = findAvailable();
        if (available.size() > 1) quickSort(available, 0, available.size() - 1);
        return available;
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

    public boolean create(String sellerId, String type, String model,
                          double pricePerHour, String stationId,
                          String imageUrl, String description) {
        String id = FileHelper.generateId();
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
        boolean saved = FileHelper.append(AppConstants.BIKES_FILE, bike.toFileString());
        if (saved) stationService.updateBikeCount(stationId, 1);
        return saved;
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
        Bike bike = findById(id);
        if (bike != null) stationService.updateBikeCount(bike.getStationId(), -1);
        return FileHelper.deleteById(AppConstants.BIKES_FILE, id);
    }
}