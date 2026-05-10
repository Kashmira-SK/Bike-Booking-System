package com.bikerental.BikeRentalSystem.model;

import com.bikerental.BikeRentalSystem.util.AppConstants;

public class RegularUser extends User {

    public RegularUser(String id, String name, String email, String password, String phone, String status) {
        super(id, name, email, password, phone, AppConstants.ROLE_REGULAR, status);
    }

    @Override
    public String getUserRole() {
        return "Regular User";
    }
}