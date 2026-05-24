package com.bikerental.BikeRentalSystem.model; // Defines the location (package) of this file

import com.bikerental.BikeRentalSystem.util.AppConstants; // Imports constant values from another utility class

// 'MainStation' inherits properties and behaviors from the 'Station' class
public class MainStation extends Station {

    // Constructor: Used to create a new MainStation object with specific details
    public MainStation(String id, String name, String address, String city, int capacity, int bikeCount) {
        
        // 'super' calls the constructor of the parent 'Station' class
        // It passes the details along with a constant identifying it as a 'MAIN' station
        super(id, name, address, city, capacity, bikeCount, AppConstants.STATION_MAIN);
    }

    // Overrides the parent method to specifically return the type as "Main Station"
    @Override
    public String getStationType() {
        return "Main Station";
    }
}
