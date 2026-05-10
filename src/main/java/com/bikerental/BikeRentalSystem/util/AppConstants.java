package com.bikerental.BikeRentalSystem.util;

public class AppConstants {

    public static final String RENTALS_FILE     = "data/rentals.txt";
    public static final String USERS_FILE       = "data/users.txt";
    public static final String BIKES_FILE       = "data/bikes.txt";
    public static final String STATIONS_FILE    = "data/stations.txt";
    public static final String PAYMENTS_FILE    = "data/payments.txt";
    public static final String REVIEWS_FILE     = "data/reviews.txt";

    public static final String SEP              = "|";

    public static final String BIKE_AVAILABLE   = "AVAILABLE";
    public static final String BIKE_RENTED      = "RENTED";
    public static final String BIKE_MAINTENANCE = "MAINTENANCE";

    public static final String RENTAL_ACTIVE    = "ACTIVE";
    public static final String RENTAL_COMPLETED = "COMPLETED";
    public static final String RENTAL_CANCELLED = "CANCELLED";
    public static final String RENTAL_HOURLY    = "HOURLY";
    public static final String RENTAL_DAILY     = "DAILY";

    public static final String PAYMENT_PENDING  = "PENDING";
    public static final String PAYMENT_DONE     = "COMPLETED";
    public static final String PAYMENT_FAILED   = "FAILED";
    public static final String METHOD_CASH      = "CASH";
    public static final String METHOD_CARD      = "CARD";

    public static final String ROLE_REGULAR     = "REGULAR";
    public static final String ROLE_ADMIN       = "ADMIN";
    public static final String USER_ACTIVE      = "ACTIVE";
    public static final String USER_INACTIVE    = "INACTIVE";

    public static final String STATION_MAIN     = "MAIN";
    public static final String STATION_SAT      = "SATELLITE";

    public static final String REVIEW_BIKE      = "BIKE";
    public static final String REVIEW_SERVICE   = "SERVICE";

    private AppConstants() {}
}