package com.bikerental.BikeRentalSystem.model;

import com.bikerental.BikeRentalSystem.util.AppConstants;

public abstract class Bike {

    private String id;
    private String sellerId;
    private String type;
    private String model;
    private double pricePerHour;
    private String stationId;
    private String status;
    private String imageUrl;
    private String description;

    public Bike(String id, String sellerId, String type, String model,
                double pricePerHour, String stationId, String status,
                String imageUrl, String description) {
        this.id = id;
        this.sellerId = sellerId;
        this.type = type;
        this.model = model;
        this.pricePerHour = pricePerHour;
        this.stationId = stationId;
        this.status = status;
        this.imageUrl = imageUrl;
        this.description = description;
    }

    public abstract String getBikeType();

    public boolean isAvailable() {
        return AppConstants.BIKE_AVAILABLE.equals(status);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSellerId() {
        return sellerId;
    }

    public void setSellerId(String sellerId) {
        this.sellerId = sellerId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public double getPricePerHour() {
        return pricePerHour;
    }

    public void setPricePerHour(double pricePerHour) {
        this.pricePerHour = pricePerHour;
    }

    public String getStationId() {
        return stationId;
    }

    public void setStationId(String stationId) {
        this.stationId = stationId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String toFileString() {
        return id + "|"
                + sellerId + "|"
                + type + "|"
                + model + "|"
                + pricePerHour + "|"
                + stationId + "|"
                + status + "|"
                + imageUrl + "|"
                + description;
    }
}