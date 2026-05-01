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

    public void returnBike(String rentalId, String endStationId) throws IOException {
        Rental rental = findById(rentalId);
        if (rental == null) return;
        String endTime = LocalDateTime.now().format(FORMATTER);
        LocalDateTime start = LocalDateTime.parse(rental.getStartTime(), FORMATTER);
        LocalDateTime end = LocalDateTime.parse(endTime, FORMATTER);
        double hours = ChronoUnit.MINUTES.between(start, end) / 60.0;
        double cost = rental.calculateCost(hours);
        rental.setEndTime(endTime);
        rental.setEndStationId(endStationId);
        rental.setCost(cost);
        rental.setStatus("COMPLETED");
        updateRental(rental);
    }

    public void cancelRental(String rentalId) throws IOException {
        Rental rental = findById(rentalId);
        if (rental == null) return;
        rental.setStatus("CANCELLED");
        updateRental(rental);
    }

    public void deleteRental(String rentalId) throws IOException {
        List<Rental> all = readAll();
        List<String> lines = new ArrayList<>();
        for (Rental r : all) {
            if (!r.getRentalId().equals(rentalId)) {
                lines.add(r.toFileString());
            }
        }
        FileHelper.writeLines(FILE_PATH, lines);
    }

    public String generateId() throws IOException {
        return "R" + System.currentTimeMillis();
    }

    private Rental parseRental(String line) {
        String[] p = line.split("\\|", -1);
        Rental r;
        if (p[9].equals("DAILY")) {
            r = new DailyRental(p[0], p[1], p[2], p[3], p[5]);
        } else {
            r = new HourlyRental(p[0], p[1], p[2], p[3], p[5]);
        }
        r.setEndStationId(p[4].isEmpty() ? null : p[4]);
        r.setEndTime(p[6].isEmpty() ? null : p[6]);
        r.setCost(Double.parseDouble(p[7]));
        r.setStatus(p[8]);
        return r;

}