package com.bikerental.BikeRentalSystem.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

public class HourlyRental extends Rental {

    private static final DateTimeFormatter FMT =
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public HourlyRental(String id, String userId, String bikeId,
                        String startStation, String endStation,
                        String startTime, String endTime,
                        double cost, String status,
                        String extrasIds, double extrasCost) {
        super(id, userId, bikeId, startStation, endStation,
                startTime, endTime, cost, status, extrasIds, extrasCost);
    }

    @Override
    public String getRentalType() {
        return "HOURLY";
    }

    @Override
    public double calculateCost(double pricePerHour) {
        if (getEndTime() == null || getEndTime().isEmpty()) return 0;
        LocalDateTime start = LocalDateTime.parse(getStartTime(), FMT);
        LocalDateTime end   = LocalDateTime.parse(getEndTime(),   FMT);
        long minutes = ChronoUnit.MINUTES.between(start, end);
        double hours = Math.max(1, Math.ceil(minutes / 60.0));
        return hours * pricePerHour;
    }
}