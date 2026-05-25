package com.bikerental.BikeRentalSystem.model;

public class MountainBike extends Bike {

    public MountainBike(String id, String sellerId, String model,
                        double pricePerHour, String stationId, String status,
                        String imageUrl, String description) {
        super(id, sellerId, "MOUNTAIN", model, pricePerHour, stationId, status, imageUrl, description);
    }

    @Override
    public String getBikeType() {
        return "Mountain Bike";
    }
}