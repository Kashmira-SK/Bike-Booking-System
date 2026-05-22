package com.bikerental.BikeRentalSystem.service;

import com.bikerental.BikeRentalSystem.util.AppConstants;
import com.bikerental.BikeRentalSystem.util.FileHelper;
import com.bikerental.BikeRentalSystem.model.SellerProfile;
import com.bikerental.BikeRentalSystem.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SellerService {

    @Autowired
    private UserService userService;

    private SellerProfile parseLine(String line) {
        String[] p = line.split("\\" + AppConstants.SEP);
        if (p.length < 4) return null;
        return new SellerProfile(p[0], p[1], p[2], "Y".equalsIgnoreCase(p[3]));
    }

    public boolean register(String userId, String location, String description) {
        if (exists(userId)) return false;
        SellerProfile profile = new SellerProfile(userId, location, description, true);
        boolean saved = FileHelper.append(AppConstants.SELLERS_FILE, profile.toFileString());
        if (!saved) return false;
        User user = userService.findById(userId);
        if (user == null) return false;
        user.setRole(AppConstants.ROLE_SELLER);
        return userService.update(user);
    }

    public SellerProfile findByUserId(String userId) {
        String line = FileHelper.findById(AppConstants.SELLERS_FILE, userId);
        return line != null ? parseLine(line) : null;
    }

    public boolean exists(String userId) {
        return findByUserId(userId) != null;
    }
}