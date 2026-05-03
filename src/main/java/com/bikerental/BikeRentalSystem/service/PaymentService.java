package com.bikerental.BikeRentalSystem.service;

import com.bikerental.BikeRentalSystem.model.Payment;
import com.bikerental.BikeRentalSystem.util.FileHelper;
import java.io.IOException;
import java.util.List;

public class PaymentService {
    private static final String FILE_PATH = "data/payments.txt";

    public void createPayment(Payment payment) throws IOException {
        FileHelper.appendLine(FILE_PATH, payment.toFileString());
    }

    public List<String> readAll() throws IOException {
        return FileHelper.readLines(FILE_PATH);
    }
}