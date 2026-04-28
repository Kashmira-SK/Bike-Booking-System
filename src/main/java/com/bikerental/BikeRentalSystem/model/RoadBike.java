package com.bikerental.BikeRentalSystem.model;

public class RoadBike extends Bike {
    public RoadBike(String bikeId, String model, double pricePerHour, String stationId) {
        super(bikeId, "Road", model, pricePerHour, stationId);
    }

    @Override
    public String getBikeDescription() {
        return "Road Bike - Model: " + getModel() + ", Best for city roads";
    }


}
