package com.bikerental.BikeRentalSystem.model;

public class ElectricBike extends Bike {

    public ElectricBike(String id, String sellerId, String model,
                        double pricePerHour, String stationId, String status,
                        String imageUrl, String description) {
        super(id, sellerId, "ELECTRIC", model, pricePerHour, stationId, status, imageUrl, description);
    }

    @Override
    public String getBikeType() {
        return "Electric Bike";
    }
}