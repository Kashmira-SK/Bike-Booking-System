package com.bikerental.BikeRentalSystem.model; // The folder where this file lives

import com.bikerental.BikeRentalSystem.util.AppConstants; // Importing shortcut names for station types

// This class is a "SatelliteStation," which is a special type of "Station"
public class SatelliteStation extends Station {

    // This is the setup (Constructor) for creating a new Satellite Station
    public SatelliteStation(String id, String name, String address, String city, int capacity, int bikeCount) {
        
        // This sends all the info to the main "Station" class to save it
        // It also labels this station as a 'SAT' (Satellite) type
        super(id, name, address, city, capacity, bikeCount, AppConstants.STATION_SAT);
    }

    // This method tells the system exactly what kind of station this is
    @Override
    public String getStationType() {
        return "Satellite Station";
    }
}
