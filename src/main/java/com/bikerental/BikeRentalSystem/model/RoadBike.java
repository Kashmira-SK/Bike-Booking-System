package com.bikerental.BikeRentalSystem.model;

public class RoadBike extends Bike {

    public RoadBike(String id, String sellerId, String model,
                    double pricePerHour, String stationId, String status,
                    String imageUrl, String description) {
        super(id, sellerId, "ROAD", model, pricePerHour, stationId, status, imageUrl, description);
    }

    @Override
    public String getBikeType() {
        return "Road Bike";
    }
}