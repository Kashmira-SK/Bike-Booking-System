package com.bikerental.BikeRentalSystem.model;

import com.bikerental.BikeRentalSystem.util.AppConstants;

public abstract class Bike {

    private String id;
    private String type;
    private String model;
    private double pricePerHour;
    private String stationId;
    private String status;

    public Bike(String id, String type, String model, double pricePerHour, String stationId, String status) {
        this.id = id;
        this.type = type;
        this.model = model;
        this.pricePerHour = pricePerHour;
        this.stationId = stationId;
        this.status = status;
    }

    public abstract String getBikeType();

    public boolean isAvailable() {
        return AppConstants.BIKE_AVAILABLE.equals(status);
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }
    public double getPricePerHour() { return pricePerHour; }
    public void setPricePerHour(double pricePerHour) { this.pricePerHour = pricePerHour; }
    public String getStationId() { return stationId; }
    public void setStationId(String stationId) { this.stationId = stationId; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String toFileString() {
        return id + "|" + type + "|" + model + "|" + pricePerHour + "|" + stationId + "|" + status;
    }
}