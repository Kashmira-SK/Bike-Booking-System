package com.bikerental.BikeRentalSystem.model;

public class DailyRental extends Rental {

    public DailyRental(String id, String userId, String bikeId,
                       String startStation, String endStation,
                       String startTime, String endTime,
                       double cost, String status) {
        super(id, userId, bikeId, startStation, endStation,
                startTime, endTime, cost, status);
    }

    @Override
    public String getRentalType() { return "DAILY"; }

    @Override
    public double calculateCost(double pricePerHour) {
        // Cost calculation is handled in RentalService.calculateCost()
        return 0;
    }
}