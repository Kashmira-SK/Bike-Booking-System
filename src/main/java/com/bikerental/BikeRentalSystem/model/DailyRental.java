package com.bikerental.BikeRentalSystem.model;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

public class DailyRental extends Rental {
    private static final DateTimeFormatter FMT =
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

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
        if (getEndTime() == null || getEndTime().isEmpty()) return 0;
        LocalDateTime start = LocalDateTime.parse(getStartTime(), FMT);
        LocalDateTime end   = LocalDateTime.parse(getEndTime(),   FMT);
        long hours = ChronoUnit.HOURS.between(start, end);
        double days = Math.max(1, Math.ceil(hours / 24.0));
        return days * pricePerHour * 24;
    }
}