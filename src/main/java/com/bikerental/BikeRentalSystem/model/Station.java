package com.bikerental.BikeRentalSystem.model;

public abstract class Station {

    private String id;
    private String name;
    private String address;
    private String city;
    private int capacity;
    private int bikeCount;
    private String type;

    public Station(String id, String name, String address, String city, int capacity, int bikeCount, String type) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.city = city;
        this.capacity = capacity;
        this.bikeCount = bikeCount;
        this.type = type;
    }

    public abstract String getStationType();

    public boolean hasSpace() {
        return bikeCount < capacity;
    }

    // Getters and setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }
    public int getCapacity() { return capacity; }
    public void setCapacity(int capacity) { this.capacity = capacity; }
    public int getBikeCount() { return bikeCount; }
    public void setBikeCount(int bikeCount) { this.bikeCount = bikeCount; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String toFileString() {
        return id + "|" + name + "|" + address + "|" + city + "|" + capacity + "|" + bikeCount + "|" + type;
    }
}