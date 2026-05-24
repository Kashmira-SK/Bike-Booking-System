package com.bikerental.BikeRentalSystem.model;

import com.bikerental.BikeRentalSystem.util.AppConstants;

public class BikeReview extends Review {

    public BikeReview(String id, String userId, String targetId, int rating, String comment, String timestamp) {
       // 'super' eken karanne parent class (Review) eke thiyena constructor ekata data pass karana eka.
        super(id, userId, targetId, rating, comment, AppConstants.REVIEW_BIKE, timestamp);
    }
    // '@Override' kiyanne parent class eke liyala thibba bageyata liyapu method ekak, me child class eke athule sampurnayen liyanawa kiyana eka.

    @Override
    public String getReviewType() {
        return "Bike Review";
    }
}
