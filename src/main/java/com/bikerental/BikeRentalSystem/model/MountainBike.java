package com.bikerental.BikeRentalSystem.model;

public class MountainBike extends Bike {

    public MountainBike(String id, String model, double pricePerHour, String stationId, String status) {
        super(id, "MOUNTAIN", model, pricePerHour, stationId, status);
    }

    @Override
    public String getBikeType() {
        return "Mountain Bike";
    }
}