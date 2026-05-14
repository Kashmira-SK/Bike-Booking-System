package com.bikerental.BikeRentalSystem.service;

import com.bikerental.BikeRentalSystem.model.Extra;
import com.bikerental.BikeRentalSystem.util.AppConstants;
import com.bikerental.BikeRentalSystem.util.FileHelper;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ExtraService {

    // Format: id|bikeId|name|pricePerRental|included
    public Extra parseLine(String line) {
        String[] p = line.split("\\" + AppConstants.SEP);
        if (p.length < 5) return null;
        String  id             = p[0];
        String  bikeId         = p[1];
        String  name           = p[2];
        double  pricePerRental = Double.parseDouble(p[3]);
        boolean included       = "Y".equalsIgnoreCase(p[4].trim());
        return new Extra(id, bikeId, name, pricePerRental, included);
    }

    private List<Extra> readAll() {
        List<Extra> extras = new ArrayList<>();
        for (String line : FileHelper.readAll(AppConstants.EXTRAS_FILE)) {
            Extra e = parseLine(line);
            if (e != null) extras.add(e);
        }
        return extras;
    }

    // Returns all extras associated with a given bike (both included and paid).
    public List<Extra> findByBike(String bikeId) {
        List<Extra> result = new ArrayList<>();
        for (Extra e : readAll()) {
            if (e.getBikeId().equals(bikeId)) result.add(e);
        }
        return result;
    }

    //Looks up a single extra by its ID, or null if not found.
    public Extra findById(String id) {
        for (Extra e : readAll()) {
            if (e.getId().equals(id)) return e;
        }
        return null;
    }

    /**
     * Adds a new extra to extras.txt.
     *
     * @param bikeId   the bike this extra belongs to
     * @param name     display name (must not contain '|')
     * @param price    cost per rental (0.00 for included extras)
     * @param included true if the extra ships with the bike for free
     */
    public boolean addExtra(String bikeId, String name, double price, boolean included) {
        String safeName = name == null ? "" : name.replace("|", "-");
        String id       = FileHelper.generateId();
        Extra  extra    = new Extra(id, bikeId, safeName, price, included);
        return FileHelper.append(AppConstants.EXTRAS_FILE, extra.toFileString());
    }

    // Removes an extra by ID. Returns false if not found.
    public boolean delete(String id) {
        return FileHelper.deleteById(AppConstants.EXTRAS_FILE, id);
    }
}