package com.bikerental.BikeRentalSystem.model;

public class SatelliteStation extends Station {

    private String parentStationId;
    private double distanceInKm;
    private boolean isOperational;

    public SatelliteStation(String stationId, String name, String address, String city,
                            int capacity, String type, String parentStationId, double distanceInKm) {

        super(stationId, name, address, city, capacity, type);

        this.parentStationId = parentStationId;
        this.distanceInKm = distanceInKm;
        this.isOperational = true;
    }

    @Override
    public String getStationInfo() {
        return "Satellite Station: " + getName() +
                " | Parent: " + parentStationId +
                " | Distance: " + distanceInKm + "km" +
                " | Bikes Available: " + getBikeCount();
    }

    public String getParentStationId() {
        return parentStationId;
    }

    public void setParentStationId(String parentStationId) {
        this.parentStationId = parentStationId;
    }

    public double getDistanceInKm() {
        return distanceInKm;
    }

    public void setDistanceInKm(double distanceInKm) {
        this.distanceInKm = distanceInKm;
    }

    public boolean isOperational() {
        return isOperational;
    }

    public void setOperational(boolean operational) {
        this.isOperational = operational;
    }
}