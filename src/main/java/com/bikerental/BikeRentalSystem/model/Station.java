package com.bikerental.BikeRentalSystem.model;

// 'abstract' means you can't create a "Station" object directly. 
// You must create a 'MainStation' or 'SatelliteStation' instead.
public abstract class Station {

    // These are the details (data) every station must have
    private String id;       // Unique ID for the station
    private String name;     // Name of the station
    private String address;  // Street address
    private String city;     // City location
    private int capacity;    // Maximum bikes the station can hold
    private int bikeCount;   // Number of bikes currently at the station
    private String type;     // Type of station (Main or Satellite)

    // Constructor: This sets up all the information when a new station is created
    public Station(String id, String name, String address, String city, int capacity, int bikeCount, String type) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.city = city;
        this.capacity = capacity;
        this.bikeCount = bikeCount;
        this.type = type;
    }

    // This is a "rule." Every class that extends Station MUST provide its own version of this method.
    public abstract String getStationType();

    // A simple check to see if there is room for more bikes
    public boolean hasSpace() {
        return bikeCount < capacity; // Returns true if current bikes are less than total capacity
    }

    // Getters and Setters: These are used to safely read or update the private data above
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

    // This converts all the station info into a single line of text separated by "|"
    // Useful for saving the data into a text file.
    public String toFileString() {
        return id + "|" + name + "|" + address + "|" + city + "|" + capacity + "|" + bikeCount + "|" + type;
    }
}dress + "|" + city + "|" + capacity + "|" + bikeCount + "|" + type;
    }
}
