package com.bikerental.BikeRentalSystem.model;

public abstract class Review {

    private String id;
    private String userId;
    private String targetId;
    private int rating;
    private String comment;
    private String type;
    private String timestamp;

    public Review(String id, String userId, String targetId, int rating,
                  String comment, String type, String timestamp) {
        this.id = id;
        this.userId = userId;
        this.targetId = targetId;
        this.rating = rating;
        this.comment = comment;
        this.type = type;
        this.timestamp = timestamp;
    }

    public abstract String getReviewType();

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    public String getTargetId() { return targetId; }
    public void setTargetId(String targetId) { this.targetId = targetId; }
    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }
    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getTimestamp() { return timestamp; }
    public void setTimestamp(String timestamp) { this.timestamp = timestamp; }

    public String toFileString() {
        return id + "|" + userId + "|" + targetId + "|" + rating + "|" + comment + "|" + type + "|" + timestamp;
    }
}