package com.bikerental.BikeRentalSystem.service;

import com.bikerental.BikeRentalSystem.model.*;
import com.bikerental.BikeRentalSystem.util.AppConstants;
import com.bikerental.BikeRentalSystem.util.FileHelper;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class StationService {

    private Station parseLine(String line) {
        String[] p = line.split("\\" + AppConstants.SEP);
        if (p.length < 7) return null;
        String id       = p[0];
        String name     = p[1];
        String address  = p[2];
        String city     = p[3];
        int capacity    = Integer.parseInt(p[4]);
        int bikeCount   = Integer.parseInt(p[5]);
        String type     = p[6];

        if (type.equals(AppConstants.STATION_MAIN)) {
            return new MainStation(id, name, address, city, capacity, bikeCount);
        } else {
            return new SatelliteStation(id, name, address, city, capacity, bikeCount);
        }
    }

    public List<Station> readAll() {
        List<Station> stations = new ArrayList<>();
        for (String line : FileHelper.readAll(AppConstants.STATIONS_FILE)) {
            Station s = parseLine(line);
            if (s != null) stations.add(s);
        }
        return stations;
    }

    public Station findById(String id) {
        String line = FileHelper.findById(AppConstants.STATIONS_FILE, id);
        return line != null ? parseLine(line) : null;
    }

    public boolean create(String name, String address, String city, int capacity, String type) {
        String id = FileHelper.generateId();
        Station station;
        if (type.equals(AppConstants.STATION_MAIN)) {
            station = new MainStation(id, name, address, city, capacity, 0);
        } else {
            station = new SatelliteStation(id, name, address, city, capacity, 0);
        }
        return FileHelper.append(AppConstants.STATIONS_FILE, station.toFileString());
    }

    public boolean update(Station updated) {
        List<String> lines = FileHelper.readAll(AppConstants.STATIONS_FILE);
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
        if (found) FileHelper.writeAll(AppConstants.STATIONS_FILE, result);
        return found;
    }

    public boolean delete(String id) {
        return FileHelper.deleteById(AppConstants.STATIONS_FILE, id);
    }

    // Called by BikeService when a bike is added/removed at a station
    public boolean updateBikeCount(String stationId, int delta) {
        Station station = findById(stationId);
        if (station == null) return false;
        station.setBikeCount(station.getBikeCount() + delta);
        return update(station);
    }
}