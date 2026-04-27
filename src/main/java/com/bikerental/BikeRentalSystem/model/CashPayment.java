package com.bikerental.BikeRentalSystem.model;

public class CashPayment {
    class CashPayment extends Payment {
        private String cardNumber;
        private String cardHolderName;
        private String expiryDate;


    }  // Constructor

    public CashPayment(int paymentId, double amount, double cashReceived) {
        super(paymentId, amount);   // Parent class constructor call
    }
}



