package com.bikerental.BikeRentalSystem.model;

public abstract class User {
    private String userId;
    private String name;
    private String email;
    private String password;
    private String phone;
    private String role;
    private String status;

    public User(String userId, String name, String email, String password, String phone, String role) {
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.role = role;
        this.status = "ACTIVE";
    }

    public abstract String getAccessLevel();

    public String getUserId() { return userId; }
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getPassword() { return password; }
    public String getPhone() { return phone; }
    public String getRole() { return role; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public void setPassword(String password) { this.password = password; }

    public String toFileString() {
        return userId + "|" + name + "|" + email + "|" + password + "|" + phone + "|" + role + "|" + status;
    }

    @Override
    public String toString() {
        return "User[" + userId + " | " + name + " | " + role + " | " + status + "]";
    }
}