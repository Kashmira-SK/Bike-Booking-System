package com.bikerental.BikeRentalSystem.service;

import com.bikerental.BikeRentalSystem.model.*;
import com.bikerental.BikeRentalSystem.util.AppConstants;
import com.bikerental.BikeRentalSystem.util.FileHelper;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserService {

    private User parseLine(String line) {
        String[] p = line.split("\\" + AppConstants.SEP);
        if (p.length < 7) return null;
        String id       = p[0];
        String name     = p[1];
        String email    = p[2];
        String password = p[3];
        String phone    = p[4];
        String role     = p[5];
        String status   = p[6];

        if (AppConstants.ROLE_ADMIN.equals(role)) {
            return new AdminUser(id, name, email, password, phone, status);
        } else {
            return new RegularUser(id, name, email, password, phone, status);
        }
    }

    public List<User> readAll() {
        List<User> users = new ArrayList<>();
        for (String line : FileHelper.readAll(AppConstants.USERS_FILE)) {
            User u = parseLine(line);
            if (u != null) users.add(u);
        }
        return users;
    }

    public User findById(String id) {
        String line = FileHelper.findById(AppConstants.USERS_FILE, id);
        return line != null ? parseLine(line) : null;
    }

    public User findByEmail(String email) {
        for (User u : readAll()) {
            if (u.getEmail().equalsIgnoreCase(email)) return u;
        }
        return null;
    }

    public boolean emailExists(String email) {
        return findByEmail(email) != null;
    }

    public boolean register(String name, String email, String password, String phone) {
        if (emailExists(email)) return false;
        String id = FileHelper.generateId();
        User user = new RegularUser(id, name, email, password, phone, AppConstants.USER_ACTIVE);
        return FileHelper.append(AppConstants.USERS_FILE, user.toFileString());
    }

    public User login(String email, String password) {
        User user = findByEmail(email);
        if (user != null && user.getPassword().equals(password) && user.isActive()) {
            return user;
        }
        return null;
    }

    public boolean update(User updated) {
        List<String> lines = FileHelper.readAll(AppConstants.USERS_FILE);
        List<String> result = new ArrayList<>();
        boolean found = false;
        for (String line : lines) {
            String[] p = line.split("\\" + AppConstants.SEP);
            if (p[0].equals(updated.getId())) {
                result.add(updated.toFileString());
                found = true;
            } else {
                result.add(line);
            }
        }
        if (found) FileHelper.writeAll(AppConstants.USERS_FILE, result);
        return found;
    }

    public boolean delete(String id) {
        return FileHelper.deleteById(AppConstants.USERS_FILE, id);
    }
}