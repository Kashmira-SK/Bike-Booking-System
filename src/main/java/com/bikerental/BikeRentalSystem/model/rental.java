package com.bikerental.BikeRentalSystem.model;

public abstract class Rental {
    private String rentalId;
    private String userId;
    private String bikeId;
    private String startStationId;
    private String endStationId;
    private String startTime;
    private String endTime;
    private double cost;
    private String status;
    private String type;

    public Rental(String rentalId, String userId, String bikeId,
                  String startStationId, String startTime, String type) {
        this.rentalId = rentalId;
        this.userId = userId;
        this.bikeId = bikeId;
        this.startStationId = startStationId;
        this.startTime = startTime;
        this.status = "ACTIVE";
        this.type = type;
        this.cost = 0.0;
    }
}