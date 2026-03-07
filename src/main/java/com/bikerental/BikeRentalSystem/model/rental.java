package com.bikerental.BikeRentalSystem.model;

public abstract class Rental {
    private String rentalId;
    private String userId;
    private String bikeId;

    public Rental(String rentalId, String userId, String bikeId) {
        this.rentalId = rentalId;
        this.userId = userId;
        this.bikeId = bikeId;
    }

    public String getRentalId() { return rentalId; }
    public String getUserId() { return userId; }
    public String getBikeId() { return bikeId; }

    public abstract double calculateCost();
}