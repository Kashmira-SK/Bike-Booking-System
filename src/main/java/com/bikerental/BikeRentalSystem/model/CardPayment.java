package com.bikerental.BikeRentalSystem.model;

import org.springframework.http.converter.json.GsonBuilderUtils;

public class CardPayment {
    class CardPayment extends Payment {
        private String cardNumber;
        private String cardHolderName;
        private String expiryDate;
    }
    // Constructor
    public CardPayment(int paymentId, double amount, double cashReceived) {
        super(paymentId, amount);   // Parent class constructor call
    }
}