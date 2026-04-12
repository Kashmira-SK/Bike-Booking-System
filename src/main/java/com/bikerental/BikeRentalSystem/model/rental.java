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
    
    public abstract double calculateCost(double hours);

    public String getRentalId() { return rentalId; }
    public String getUserId() { return userId; }
    public String getBikeId() { return bikeId; }
    public String getStartStationId() { return startStationId; }
    public String getEndStationId() { return endStationId; }
    public String getStartTime() { return startTime; }
    public String getEndTime() { return endTime; }
    public double getCost() { return cost; }
    public String getStatus() { return status; }
    public String getType() { return type; }

    public void setEndStationId(String endStationId) { this.endStationId = endStationId; }
    public void setEndTime(String endTime) { this.endTime = endTime; }
    public void setCost(double cost) { this.cost = cost; }
    public void setStatus(String status) { this.status = status; }

    public String toFileString() {
        return rentalId + "|" + userId + "|" + bikeId + "|" +
                startStationId + "|" + (endStationId != null ? endStationId : "") + "|" +
                startTime + "|" + (endTime != null ? endTime : "") + "|" +
                cost + "|" + status + "|" + type;
    }
}