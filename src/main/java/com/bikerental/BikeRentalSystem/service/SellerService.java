package com.bikerental.BikeRentalSystem.service;

import com.bikerental.BikeRentalSystem.util.AppConstants;
import com.bikerental.BikeRentalSystem.model.SellerProfile;
import com.bikerental.BikeRentalSystem.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;

@Service
public class SellerService {

    @Autowired
    private UserService userService;

    public boolean register(String userId, String location, String description) {

        // Guard: don't double-register
        if (exists(userId)) return false;

        // Ensure sellers.txt exists
        ensureFileExists();

        SellerProfile profile = new SellerProfile(userId, location, description, true);

        // 1. Append to sellers.txt
        try {
            String line = profile.toFileString() + System.lineSeparator();
            Files.writeString(
                    Paths.get(AppConstants.SELLERS_FILE),
                    line,
                    StandardOpenOption.CREATE,
                    StandardOpenOption.APPEND);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        // 2. Promote the user's role to SELLER in users.txt
        User user = userService.findById(userId);
        if (user == null) return false;

        user.setRole(AppConstants.ROLE_SELLER);
        return userService.update(user);
    }

    public SellerProfile findByUserId(String userId) {
        File file = new File(AppConstants.SELLERS_FILE);
        if (!file.exists()) return null;

        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.isBlank()) continue;
                String[] parts = line.split("\\|");
                if (parts.length >= 4 && parts[0].equals(userId)) {
                    return new SellerProfile(
                            parts[0],
                            parts[1],
                            parts[2],
                            "Y".equalsIgnoreCase(parts[3]));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean exists(String userId) {
        return findByUserId(userId) != null;
    }

    private void ensureFileExists() {
        File file = new File(AppConstants.SELLERS_FILE);
        if (!file.exists()) {
            file.getParentFile().mkdirs();
            try {
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}