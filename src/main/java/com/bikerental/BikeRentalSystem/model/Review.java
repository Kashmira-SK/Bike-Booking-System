package com.bikerental.BikeRentalSystem.model;

public abstract class Review {
    private String reviewId;
    private String userId;
    private String targetId;
    private int rating;
    private String comment;
    private String type;
    private String timestamp;

    public Review(String reviewId, String userId, String targetId, int rating, String comment, String type, String timestamp) {
        this.reviewId = reviewId;
        this.userId = userId;
        this.targetId = targetId;
        this.rating = rating;
        this.comment = comment;
        this.type = type;
        this.timestamp = timestamp;
    }

    public abstract String getSummary();

    public String getReviewId() { return reviewId; }
    public String getUserId() { return userId; }
    public String getTargetId() { return targetId; }
    public int getRating() { return rating; }
    public String getComment() { return comment; }
    public String getType() { return type; }
    public String getTimestamp() { return timestamp; }
    public void setComment(String comment) { this.comment = comment; }
    public void setRating(int rating) { this.rating = rating; }

    public String toFileString() {
        return reviewId + "|" + userId + "|" + targetId + "|" + rating + "|" + comment + "|" + type + "|" + timestamp;
    }

    @Override
    public String toString() {
        return "Review[" + reviewId + " | User:" + userId + " | Rating:" + rating + "/5 | " + type + "]";
    }
}