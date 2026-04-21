package com.bikerental.BikeRentalSystem.model;

public abstract class Payment {
    private String paymentId;
    private String rentalId;
    private String userId;
    private double amount;
    private String method;
    private String status;
    private String timestamp;

    public Payment(String paymentId, String rentalId, String userId, double amount, String method, String timestamp) {
        this.paymentId = paymentId;
        this.rentalId = rentalId;
        this.userId = userId;
        this.amount = amount;
        this.method = method;
        this.status = "PENDING";
        this.timestamp = timestamp;
    }

    public abstract String getPaymentSummary();

    public String getPaymentId() { return paymentId; }
    public String getRentalId() { return rentalId; }
    public String getUserId() { return userId; }
    public double getAmount() { return amount; }
    public String getMethod() { return method; }
    public String getStatus() { return status; }
    public String getTimestamp() { return timestamp; }
    public void setStatus(String status) { this.status = status; }

    public String toFileString() {
        return paymentId + "|" + rentalId + "|" + userId + "|" + amount + "|" + method + "|" + status + "|" + timestamp;
    }

    @Override
    public String toString() {
        return "Payment[" + paymentId + " | Rental:" + rentalId + " | Rs." + amount + " | " + method + " | " + status + "]";
    }
}