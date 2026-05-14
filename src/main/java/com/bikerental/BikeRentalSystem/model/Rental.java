package com.bikerental.BikeRentalSystem.model;

import com.bikerental.BikeRentalSystem.util.AppConstants;

public abstract class Rental {

    private String id;
    private String userId;
    private String bikeId;
    private String startStation;
    private String endStation;
    private String startTime;
    private String endTime;
    private double cost;
    private String status;
    private String extrasIds;
    private double extrasCost;

    public Rental(String id, String userId, String bikeId,
                  String startStation, String endStation,
                  String startTime, String endTime,
                  double cost, String status,
                  String extrasIds, double extrasCost) {
        this.id           = id;
        this.userId       = userId;
        this.bikeId       = bikeId;
        this.startStation = startStation;
        this.endStation   = endStation;
        this.startTime    = startTime;
        this.endTime      = endTime;
        this.cost         = cost;
        this.status       = status;
        this.extrasIds    = extrasIds;
        this.extrasCost   = extrasCost;
    }

    public abstract String getRentalType();

    public abstract double calculateCost(double pricePerHour);

    public boolean isActive() {
        return AppConstants.RENTAL_ACTIVE.equals(status);
    }

    public String getId()                           { return id; }
    public void   setId(String id)                  { this.id = id; }

    public String getUserId()                       { return userId; }
    public void   setUserId(String userId)          { this.userId = userId; }

    public String getBikeId()                       { return bikeId; }
    public void   setBikeId(String bikeId)          { this.bikeId = bikeId; }

    public String getStartStation()                 { return startStation; }
    public void   setStartStation(String s)         { this.startStation = s; }

    public String getEndStation()                   { return endStation; }
    public void   setEndStation(String s)           { this.endStation = s; }

    public String getStartTime()                    { return startTime; }
    public void   setStartTime(String startTime)    { this.startTime = startTime; }

    public String getEndTime()                      { return endTime; }
    public void   setEndTime(String endTime)        { this.endTime = endTime; }

    public double getCost()                         { return cost; }
    public void   setCost(double cost)              { this.cost = cost; }

    public String getStatus()                       { return status; }
    public void   setStatus(String status)          { this.status = status; }

    public String getExtrasIds()                    { return extrasIds; }
    public void   setExtrasIds(String extrasIds)    { this.extrasIds = extrasIds; }

    public double getExtrasCost()                   { return extrasCost; }
    public void   setExtrasCost(double extrasCost)  { this.extrasCost = extrasCost; }

    public String toFileString() {
        return id           + "|"
                + userId       + "|"
                + bikeId       + "|"
                + startStation + "|"
                + endStation   + "|"
                + startTime    + "|"
                + endTime      + "|"
                + cost         + "|"
                + status       + "|"
                + getRentalType() + "|"
                + extrasIds    + "|"
                + extrasCost;
    }
}