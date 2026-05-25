package com.bikerental.BikeRentalSystem.model;

import com.bikerental.BikeRentalSystem.util.AppConstants;

public class ServiceReview extends Review {

    public ServiceReview(String id, String userId, String targetId, int rating, String comment, String timestamp) {
        super(id, userId, targetId, rating, comment, AppConstants.REVIEW_SERVICE, timestamp);
    }

    @Override
    public String getReviewType() {
        return "Service Review";
    }
}