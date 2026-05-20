package com.bikerental.BikeRentalSystem.service;

import com.bikerental.BikeRentalSystem.model.*;
import com.bikerental.BikeRentalSystem.util.AppConstants;
import com.bikerental.BikeRentalSystem.util.FileHelper;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Service
public class PaymentService {

    private static final DateTimeFormatter FMT = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    private Payment parseLine(String line) {
        String[] p = line.split("\\" + AppConstants.SEP);
        if (p.length < 7) return null;
        String id        = p[0];
        String rentalId  = p[1];
        String userId    = p[2];
        double amount    = Double.parseDouble(p[3]);
        String method    = p[4];
        String status    = p[5];
        String timestamp = p[6];

        if (AppConstants.METHOD_CASH.equals(method)) {
            return new CashPayment(id, rentalId, userId, amount, status, timestamp);
        } else {
            return new CardPayment(id, rentalId, userId, amount, status, timestamp);
        }
    }

    // Read rental's cost directly from rentals.txt
    private double getRentalCost(String rentalId) {
        String line = FileHelper.findById(AppConstants.RENTALS_FILE, rentalId);
        if (line == null) return -1;
        String[] p = line.split("\\" + AppConstants.SEP);
        return p.length >= 8 ? Double.parseDouble(p[7]) : -1;
    }

    // Check rental is completed and not already paid
    private boolean rentalIsPayable(String rentalId) {
        String line = FileHelper.findById(AppConstants.RENTALS_FILE, rentalId);
        if (line == null) return false;
        String[] p = line.split("\\" + AppConstants.SEP);
        if (p.length < 9) return false;
        if (!AppConstants.RENTAL_COMPLETED.equals(p[8])) return false;
        // Check no existing completed payment for this rental
        for (Payment payment : readAll()) {
            if (payment.getRentalId().equals(rentalId) && payment.isCompleted()) return false;
        }
        return true;
    }

    public List<Payment> readAll() {
        List<Payment> payments = new ArrayList<>();
        for (String line : FileHelper.readAll(AppConstants.PAYMENTS_FILE)) {
            Payment pay = parseLine(line);
            if (pay != null) payments.add(pay);
        }
        return payments;
    }

    public Payment findById(String id) {
        String line = FileHelper.findById(AppConstants.PAYMENTS_FILE, id);
        return line != null ? parseLine(line) : null;
    }

    public List<Payment> findByUser(String userId) {
        List<Payment> result = new ArrayList<>();
        for (Payment p : readAll()) {
            if (p.getUserId().equals(userId)) result.add(p);
        }
        return result;
    }

    public Payment findByRental(String rentalId) {
        for (Payment p : readAll()) {
            if (p.getRentalId().equals(rentalId)) return p;
        }
        return null;
    }

    // Returns the created Payment on success, null on failure
    public Payment createPayment(String rentalId, String userId, String method) {
        if (!rentalIsPayable(rentalId)) return null;

        double amount = getRentalCost(rentalId);
        if (amount < 0) return null;

        String id        = FileHelper.generateId();
        String timestamp = LocalDateTime.now().format(FMT);

        Payment payment;
        String status = AppConstants.METHOD_CARD.equals(method)
                ? AppConstants.PAYMENT_PENDING
                : AppConstants.PAYMENT_DONE;

        if (AppConstants.METHOD_CASH.equals(method)) {
            payment = new CashPayment(id, rentalId, userId, amount, status, timestamp);
        } else {
            payment = new CardPayment(id, rentalId, userId, amount, status, timestamp);
        }

        boolean saved = FileHelper.append(AppConstants.PAYMENTS_FILE, payment.toFileString());
        return saved ? payment : null;
    }

    public boolean approve(String paymentId) {
        Payment payment = findById(paymentId);
        if (payment == null || !AppConstants.PAYMENT_PENDING.equals(payment.getStatus())) return false;
        payment.setStatus(AppConstants.PAYMENT_DONE);
        List<String> lines  = FileHelper.readAll(AppConstants.PAYMENTS_FILE);
        List<String> result = new ArrayList<>();
        for (String line : lines) {
            String[] p = line.split("\\" + AppConstants.SEP);
            result.add(p[0].equals(paymentId) ? payment.toFileString() : line);
        }
        return FileHelper.writeAll(AppConstants.PAYMENTS_FILE, result);
    }
}