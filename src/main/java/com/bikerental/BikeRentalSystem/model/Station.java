package com.bikerental.BikeRentalSystem.model;

public abstract class Station {
    private String stationId;
    private String name;
    private String address;
    private String city;
    private int capacity;
    private int bikeCount;
    private String type;

    public Station(String stationId, String name, String address, String city, int capacity, String type) {
        this.stationId = stationId;
        this.name = name;
        this.address = address;
        this.city = city;
        this.capacity = capacity;
        this.bikeCount = 0;
        this.type = type;
    }

    public abstract String getStationInfo();

    public String getStationId() { return stationId; }
    public String getName() { return name; }
    public String getAddress() { return address; }
    public String getCity() { return city; }
    public int getCapacity() { return capacity; }
    public int getBikeCount() { return bikeCount; }
    public String getType() { return type; }
    public void setBikeCount(int bikeCount) { this.bikeCount = bikeCount; }
    public void setName(String name) { this.name = name; }
    public void setAddress(String address) { this.address = address; }

    public String toFileString() {
        return stationId + "|" + name + "|" + address + "|" + city + "|" + capacity + "|" + bikeCount + "|" + type;
    }

    @Override
    public String toString() {
        return "Station[" + stationId + " | " + name + " | " + city + " | Bikes:" + bikeCount + "/" + capacity + "]";
    }
}