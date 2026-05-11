package com.bikerental.BikeRentalSystem.model;

public class ElectricBike extends Bike {

    public ElectricBike(String id, String model, double pricePerHour, String stationId, String status) {
        super(id, "ELECTRIC", model, pricePerHour, stationId, status);
    }

    @Override
    public String getBikeType() {
        return "Electric Bike";
    }
}