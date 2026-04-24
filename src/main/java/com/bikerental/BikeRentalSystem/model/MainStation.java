package com.bikerental.BikeRentalSystem.model;

import java.util.ArrayList;
import java.util.List;

public class MainStation extends Station {
    private boolean hasMaintenanceHub;
    private String contactNumber;
    private List<String> satelliteStationIds;

    public MainStation(String stationId, String name, String address, String city, int capacity, boolean hasMaintenanceHub, String contactNumber) {

        super(stationId, name, address, city, capacity, "Main");
        this.hasMaintenanceHub = hasMaintenanceHub;
        this.contactNumber = contactNumber;
        this.satelliteStationIds = new ArrayList<>();
    }


    public boolean hasSpace() {
        return getBikeCount() < getCapacity();
    }


    public void addSatelliteStation(String id) {
        if (!satelliteStationIds.contains(id)) {
            satelliteStationIds.add(id);
        }
    }

    @Override
    public String getStationInfo() {
        return String.format("Main Station: %s [%s]\nLocation: %s, %s\nCapacity: %d/%d\nMaintenance Hub: %s\nContact: %s",
                getName(), getStationId(), getAddress(), getCity(), getBikeCount(), getCapacity(),
                (hasMaintenanceHub ? "Available" : "Not Available"), contactNumber);
    }


    public boolean isHasMaintenanceHub() { return hasMaintenanceHub; }
    public void setHasMaintenanceHub(boolean hasMaintenanceHub) { this.hasMaintenanceHub = hasMaintenanceHub; }
    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }

    @Override
    public String toFileString() {

        return super.toFileString() + "|" + hasMaintenanceHub + "|" + contactNumber;
    }
}
