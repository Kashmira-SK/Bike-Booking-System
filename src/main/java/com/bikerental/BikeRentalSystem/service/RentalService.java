package com.bikerental.BikeRentalSystem.service;

import com.bikerental.BikeRentalSystem.model.Rental;
import com.bikerental.BikeRentalSystem.util.FileHelper;
import java.io.IOException;
import java.time.format.DateTimeFormatter;

public class RentalService {
    private static final String FILE_PATH = "data/rentals.txt";
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

    public void createRental(Rental rental) throws IOException {
        FileHelper.appendLine(FILE_PATH, rental.toFileString());
    }
}
