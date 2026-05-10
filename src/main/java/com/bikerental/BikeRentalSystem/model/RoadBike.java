package com.bikerental.BikeRentalSystem.model;

public class RoadBike extends Bike {

    public RoadBike(String id, String model, double pricePerHour, String stationId, String status) {
        super(id, "ROAD", model, pricePerHour, stationId, status);
    }

    @Override
    public String getBikeType() {
        return "Road Bike";
    }
}