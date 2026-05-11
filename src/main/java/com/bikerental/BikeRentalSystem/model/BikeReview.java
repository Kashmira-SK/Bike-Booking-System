package com.bikerental.BikeRentalSystem.model;

import com.bikerental.BikeRentalSystem.util.AppConstants;

public class BikeReview extends Review {

    public BikeReview(String id, String userId, String targetId, int rating, String comment, String timestamp) {
        super(id, userId, targetId, rating, comment, AppConstants.REVIEW_BIKE, timestamp);
    }

    @Override
    public String getReviewType() {
        return "Bike Review";
    }
}