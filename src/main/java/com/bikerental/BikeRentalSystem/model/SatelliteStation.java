package com.bikerental.BikeRentalSystem.model;

import com.bikerental.BikeRentalSystem.util.AppConstants;

public class SatelliteStation extends Station {

    public SatelliteStation(String id, String name, String address, String city, int capacity, int bikeCount) {
        super(id, name, address, city, capacity, bikeCount, AppConstants.STATION_SAT);
    }

    @Override
    public String getStationType() {
        return "Satellite Station";
    }
}