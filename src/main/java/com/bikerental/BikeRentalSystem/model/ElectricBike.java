package com.bikerental.BikeRentalSystem.model;

public class ElectricBike extends Bike  {
    public ElectricBike(String bikeId, String model, double pricePerHour, String stationId) {
        super(bikeId, "Electric", model, pricePerHour, stationId);
    }

    @Override
    public String getBikeDescription() {
        return "Electric Bike - Model: " + getModel() + ", Battery powered";
    }

}
