package com.bikerental.BikeRentalSystem.model;

import com.bikerental.BikeRentalSystem.util.AppConstants;

public class MainStation extends Station {

    public MainStation(String id, String name, String address, String city, int capacity, int bikeCount) {
        super(id, name, address, city, capacity, bikeCount, AppConstants.STATION_MAIN);
    }

    @Override
    public String getStationType() {
        return "Main Station";
    }
}