package com.bikerental.BikeRentalSystem.model;

public class DailyRental extends Rental {
    private static final double RATE_PER_DAY = 800.0;

    public DailyRental(String rentalId, String userId, String bikeId, String startStationId, String startTime) {
        super(rentalId, userId, bikeId, startStationId, startTime, "DAILY");
    }

    @Override
    public double calculateCost(double hours) {
        double days = Math.ceil(hours / 24.0);
        return days * RATE_PER_DAY;
    }
}