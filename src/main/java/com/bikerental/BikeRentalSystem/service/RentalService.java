package com.bikerental.BikeRentalSystem.service;

import com.bikerental.BikeRentalSystem.model.*;
import com.bikerental.BikeRentalSystem.util.FileHelper;
import java.io.IOException;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.*;

public class RentalService {
    private static final String FILE_PATH = "data/rentals.txt";
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

    public void createRental(Rental rental) throws IOException {
        FileHelper.appendLine(FILE_PATH, rental.toFileString());
    }

    public List<Rental> readAll() throws IOException {
        List<String> lines = FileHelper.readLines(FILE_PATH);
        List<Rental> rentals = new ArrayList<>();
        for (String line : lines) {
            if (!line.trim().isEmpty()) {
                rentals.add(parseRental(line));
            }
        }
        return rentals;
    }

    public Rental findById(String id) throws IOException {
        for (Rental r : readAll()) {
            if (r.getRentalId().equals(id)) return r;
        }
        return null;
    }

    public List<Rental> findByUserId(String userId) throws IOException {
        List<Rental> result = new ArrayList<>();
        for (Rental r : readAll()) {
            if (r.getUserId().equals(userId)) result.add(r);
        }
        return result;
    }

    public void updateRental(Rental updated) throws IOException {
        List<Rental> all = readAll();
        List<String> lines = new ArrayList<>();
        for (Rental r : all) {
            if (r.getRentalId().equals(updated.getRentalId())) {
                lines.add(updated.toFileString());
            } else {
                lines.add(r.toFileString());
            }
        }
        FileHelper.writeLines(FILE_PATH, lines);
    }
}