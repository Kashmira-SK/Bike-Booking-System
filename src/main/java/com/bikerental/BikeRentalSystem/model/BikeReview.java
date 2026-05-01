package com.bikerental.BikeRentalSystem.model;



public class BikeReview extends Review {


    private boolean isConditionGood;


    public BikeReview(String reviewId, String userId, String targetId, int rating, String comment, String timestamp, boolean isConditionGood) {

        super(reviewId, userId, targetId, rating, comment, "BIKE", timestamp);
        this.isConditionGood = isConditionGood;
    }


    @Override
    public String getSummary() {
        return "Bike Review [Bike ID: " + getTargetId() + "] - Rating: " + getRating() + " Stars | Condition: " + (isConditionGood ? "Good" : "Needs Repair");
    }

    public boolean isConditionGood() {
        return isConditionGood;
    }

    public void setConditionGood(boolean conditionGood) {
        this.isConditionGood = conditionGood;
    }


    @Override
    public String toFileString() {
        return super.toFileString() + "|" + isConditionGood;
    }

    @Override
    public String toString() {
        return super.toString() + " | Condition Good: " + isConditionGood;
    }
}