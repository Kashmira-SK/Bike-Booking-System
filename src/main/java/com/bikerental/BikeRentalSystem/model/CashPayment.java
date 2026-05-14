package com.bikerental.BikeRentalSystem.model;

import com.bikerental.BikeRentalSystem.util.AppConstants;

public class CashPayment extends Payment {

    public CashPayment(String id, String rentalId, String userId, double amount, String status, String timestamp) {
        super(id, rentalId, userId, amount, AppConstants.METHOD_CASH, status, timestamp);
    }

    @Override
    public String getPaymentMethod() {
        return "Cash";
    }
}