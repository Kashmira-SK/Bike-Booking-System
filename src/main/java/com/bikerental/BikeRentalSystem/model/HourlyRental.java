package com.bikerental.BikeRentalSystem.model;

public class HourlyRental extends Rental {
    private static final double RATE_PER_HOUR = 150.0;

    public HourlyRental(String rentalId, String userId, String bikeId, String startStationId, String startTime) {
        super(rentalId, userId, bikeId, startStationId, startTime, "HOURLY");
    }

    @Override
    public double calculateCost(double hours) {
        return Math.ceil(hours) * RATE_PER_HOUR;
    }
}