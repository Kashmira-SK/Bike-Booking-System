package com.bikerental.BikeRentalSystem.util;

public class AppConstants {

    private AppConstants() {}

    // ── Data files ───────────────────────────────────────────────────────────
    public static final String RENTALS_FILE     = "data/rentals.txt";
    public static final String USERS_FILE       = "data/users.txt";
    public static final String BIKES_FILE       = "data/bikes.txt";
    public static final String STATIONS_FILE    = "data/stations.txt";
    public static final String PAYMENTS_FILE    = "data/payments.txt";
    public static final String REVIEWS_FILE     = "data/reviews.txt";
    public static final String SELLERS_FILE     = "data/sellers.txt";
    public static final String EXTRAS_FILE      = "data/extras.txt";
    public static final String SEP              = "|";

    // ── Bike status ──────────────────────────────────────────────────────────
    public static final String BIKE_AVAILABLE   = "AVAILABLE";
    public static final String BIKE_RENTED      = "RENTED";
    public static final String BIKE_MAINTENANCE = "MAINTENANCE";

    // ── Rental status / type ─────────────────────────────────────────────────
    public static final String RENTAL_ACTIVE    = "ACTIVE";
    public static final String RENTAL_COMPLETED = "COMPLETED";
    public static final String RENTAL_CANCELLED = "CANCELLED";
    public static final String RENTAL_HOURLY    = "HOURLY";
    public static final String RENTAL_DAILY     = "DAILY";

    // ── Payment status / method ──────────────────────────────────────────────
    public static final String PAYMENT_PENDING  = "PENDING";
    public static final String PAYMENT_DONE     = "COMPLETED";
    public static final String PAYMENT_FAILED   = "FAILED";
    public static final String METHOD_CASH      = "CASH";
    public static final String METHOD_CARD      = "CARD";

    // ── Roles ────────────────────────────────────────────────────────────────
    public static final String ROLE_REGULAR     = "REGULAR";
    public static final String ROLE_ADMIN       = "ADMIN";
    public static final String ROLE_SELLER      = "SELLER";

    // ── User status ──────────────────────────────────────────────────────────
    public static final String USER_ACTIVE      = "ACTIVE";
    public static final String USER_INACTIVE    = "INACTIVE";

    // ── Station type ─────────────────────────────────────────────────────────
    public static final String STATION_MAIN     = "MAIN";
    public static final String STATION_SAT      = "SATELLITE";

    // ── Review type ──────────────────────────────────────────────────────────
    public static final String REVIEW_BIKE      = "BIKE";
    public static final String REVIEW_SERVICE   = "SERVICE";

    // ── Session attribute keys ───────────────────────────────────────────────
    public static final String SESSION_USER          = "loggedInUser";
    public static final String SESSION_FLASH_ERROR   = "flashError";
    public static final String SESSION_FLASH_SUCCESS = "flashSuccess";

    // ── Route paths ──────────────────────────────────────────────────────────
    public static final String ROUTE_HOME            = "/home";
    public static final String ROUTE_LOGIN           = "/login";
    public static final String ROUTE_PROFILE         = "/profile";
    public static final String ROUTE_SELLER_REG      = "/seller/register";
    public static final String ROUTE_RENTALS_RENT    = "/rentals/rent";
    public static final String ROUTE_RENTALS_MY      = "/rentals/my";
    public static final String ROUTE_PAYMENTS_MY     = "/payments/my";
    public static final String ROUTE_BIKES_ADD       = "/bikes/add";
    public static final String ROUTE_BIKES_MY        = "/bikes/my";
    public static final String ROUTE_STATIONS_ADD    = "/stations/add";
    public static final String ROUTE_STATIONS_MANAGE = "/stations/manage";
    public static final String ROUTE_ADMIN_USERS     = "/admin/users";
    public static final String ROUTE_ADMIN_RENTALS   = "/admin/rentals";
}