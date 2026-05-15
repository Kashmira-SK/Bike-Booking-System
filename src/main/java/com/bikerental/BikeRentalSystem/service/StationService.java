package com.bikerental.BikeRentalSystem.service;

import com.bikerental.BikeRentalSystem.model.*;
import com.bikerental.BikeRentalSystem.util.AppConstants;
import com.bikerental.BikeRentalSystem.util.FileHelper;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service // Tells Spring that this class handles the business logic
public class StationService {

    // Converts a single line of text from the file into a Station object
    private Station parseLine(String line) {
        String[] p = line.split("\\" + AppConstants.SEP); // Split the line by "|"
        if (p.length < 7) return null; // If data is missing, skip it
        
        // Extracting data from the split text
        String id       = p[0];
        String name     = p[1];
        String address  = p[2];
        String city     = p[3];
        int capacity    = Integer.parseInt(p[4]);
        int bikeCount   = Integer.parseInt(p[5]);
        String type     = p[6];

        // Decide whether to create a MainStation or a SatelliteStation object
        if (type.equals(AppConstants.STATION_MAIN)) {
            return new MainStation(id, name, address, city, capacity, bikeCount);
        } else {
            return new SatelliteStation(id, name, address, city, capacity, bikeCount);
        }
    }

    // Reads the entire text file and returns a list of all Station objects
    public List<Station> readAll() {
        List<Station> stations = new ArrayList<>();
        for (String line : FileHelper.readAll(AppConstants.STATIONS_FILE)) {
            Station s = parseLine(line);
            if (s != null) stations.add(s);
        }
        return stations;
    }

    // Searches for a specific station by its ID
    public Station findById(String id) {
        String line = FileHelper.findById(AppConstants.STATIONS_FILE, id);
        return line != null ? parseLine(line) : null;
    }

    // Creates a brand new station and saves it to the file
    public boolean create(String name, String address, String city, int capacity, String type) {
        String id = FileHelper.generateId(); // Get a new unique ID
        Station station;
        // Create the right object based on type
        if (type.equals(AppConstants.STATION_MAIN)) {
            station = new MainStation(id, name, address, city, capacity, 0);
        } else {
            station = new SatelliteStation(id, name, address, city, capacity, 0);
        }
        // Save the new station info as a line in the text file
        return FileHelper.append(AppConstants.STATIONS_FILE, station.toFileString());
    }

    // Updates an existing station's information in the file
    public boolean update(Station updated) {
        List<String> lines = FileHelper.readAll(AppConstants.STATIONS_FILE);
        List<String> result = new ArrayList<>();
        boolean found = false;
        
        for (String line : lines) {
            String[] p = line.split("\\" + AppConstants.SEP);
            if (p[0].equals(updated.getId())) { // If we find the right ID
                result.add(updated.toFileString()); // Put the updated info
                found = true;
            } else {
                result.add(line); // Keep the old info for other stations
            }
        }
        if (found) FileHelper.writeAll(AppConstants.STATIONS_FILE, result);
        return found;
    }

    // Removes a station from the file using its ID
    public boolean delete(String id) {
        return FileHelper.deleteById(AppConstants.STATIONS_FILE, id);
    }

    // This is used when a bike is rented or returned to change the bike count
    // delta can be +1 (return) or -1 (rent)
    public boolean updateBikeCount(String stationId, int delta) {
        Station station = findById(stationId);
        if (station == null) return false;
        
        // Update the count and save the change
        station.setBikeCount(station.getBikeCount() + delta);
        return update(station);
    }
}
    }
}
