package com.bikerental.BikeRentalSystem.model;

public class CashPayment extends Payment {
    private double cashReceived;

    public CashPayment(String paymentId, String rentalId, String userId, double amount, String timestamp, double cashReceived) {
        super(paymentId, rentalId, userId, amount, "CASH", timestamp);
        this.cashReceived = cashReceived;
    }

    @Override
    public String getPaymentSummary() {
        return "Cash Payment | Amount: Rs." + getAmount() + " | Received: Rs." + cashReceived;
    }

    public double getCashReceived() { return cashReceived; }
}

