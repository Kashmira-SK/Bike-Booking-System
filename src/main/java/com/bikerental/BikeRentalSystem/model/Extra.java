package com.bikerental.BikeRentalSystem.model;

public class Extra {

    private String id;
    private String bikeId;
    private String name;
    private double pricePerRental;
    private boolean included;       // true = free with bike (Y), false = costs extra (N)

    public Extra(String id, String bikeId, String name,
                 double pricePerRental, boolean included) {
        this.id             = id;
        this.bikeId         = bikeId;
        this.name           = name;
        this.pricePerRental = pricePerRental;
        this.included       = included;
    }

    public String getId()                        { return id; }
    public void   setId(String id)               { this.id = id; }

    public String getBikeId()                    { return bikeId; }
    public void   setBikeId(String bikeId)       { this.bikeId = bikeId; }

    public String getName()                      { return name; }
    public void   setName(String name)           { this.name = name; }

    public double getPricePerRental()            { return pricePerRental; }
    public void   setPricePerRental(double p)    { this.pricePerRental = p; }

    public boolean isIncluded()                  { return included; }
    public void    setIncluded(boolean included) { this.included = included; }

    public String toFileString() {
        return id             + "|"
                + bikeId         + "|"
                + name           + "|"
                + pricePerRental + "|"
                + (included ? "Y" : "N");
    }
}