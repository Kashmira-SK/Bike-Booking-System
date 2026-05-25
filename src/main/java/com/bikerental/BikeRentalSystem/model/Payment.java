package com.bikerental.BikeRentalSystem.model;

public abstract class Payment {

    private String id;
    private String rentalId;
    private String userId;
    private double amount;
    private String method;
    private String status;
    private String timestamp;

    public Payment(String id, String rentalId, String userId, double amount,
                   String method, String status, String timestamp) {
        this.id = id;
        this.rentalId = rentalId;
        this.userId = userId;
        this.amount = amount;
        this.method = method;
        this.status = status;
        this.timestamp = timestamp;
    }

    public abstract String getPaymentMethod();

    public boolean isCompleted() { return "COMPLETED".equals(status); }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getRentalId() { return rentalId; }
    public void setRentalId(String rentalId) { this.rentalId = rentalId; }
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }
    public String getMethod() { return method; }
    public void setMethod(String method) { this.method = method; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getTimestamp() { return timestamp; }
    public void setTimestamp(String timestamp) { this.timestamp = timestamp; }

    public String toFileString() {
        return id + "|" + rentalId + "|" + userId + "|" + amount + "|" + method + "|" + status + "|" + timestamp;
    }
}