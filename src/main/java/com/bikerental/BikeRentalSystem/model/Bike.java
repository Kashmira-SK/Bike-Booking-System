package com.bikerental.BikeRentalSystem.model;

public abstract class Bike {
    private String bikeId;
    private String type;
    private String model;
    private double pricePerHour;
    private String stationId;
    private String status;

    public Bike(String bikeId, String type, String model, double pricePerHour, String stationId) {
        this.bikeId = bikeId;
        this.type = type;
        this.model = model;
        this.pricePerHour = pricePerHour;
        this.stationId = stationId;
        this.status = "AVAILABLE";
    }

    public abstract String getBikeDescription();

    public String getBikeId() { return bikeId; }
    public String getType() { return type; }
    public String getModel() { return model; }
    public double getPricePerHour() { return pricePerHour; }
    public String getStationId() { return stationId; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public void setStationId(String stationId) { this.stationId = stationId; }
    public void setPricePerHour(double pricePerHour) { this.pricePerHour = pricePerHour; }

    public String toFileString() {
        return bikeId + "|" + type + "|" + model + "|" + pricePerHour + "|" + stationId + "|" + status;
    }

    @Override
    public String toString() {
        return "Bike[" + bikeId + " | " + model + " | " + type + " | " + status + "]";
    }
}