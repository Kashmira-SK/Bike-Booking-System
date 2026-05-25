package com.bikerental.BikeRentalSystem.model;

import com.bikerental.BikeRentalSystem.util.AppConstants;

public class CardPayment extends Payment {
    
     // Call parent constructor using super
    public CardPayment(String id, String rentalId, String userId, double amount, String status, String timestamp) {
        super(id, rentalId, userId, amount, AppConstants.METHOD_CARD, status, timestamp);
    }

    // Override abstract method from Payment class
    @Override
     public String getPaymentMethod() {
        return "Card";
    }
   
}
