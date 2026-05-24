package com.bikerental.BikeRentalSystem.service;

import com.bikerental.BikeRentalSystem.model.*;
import com.bikerental.BikeRentalSystem.util.AppConstants;
import com.bikerental.BikeRentalSystem.util.FileHelper;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
// '@Service' kiyanne Spring Boot walata meka business logic thiyena class ekak kiyala adunala dena eka.
@Service
public class ReviewService {
    
// date and time save wenna ona format eka meken hadanwa
    private static final DateTimeFormatter FMT = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    private Review parseLine(String line) {
        String[] p = line.split("\\" + AppConstants.SEP);
        if (p.length < 7) return null;
        String id        = p[0];
        String userId    = p[1];
        String targetId  = p[2];
        int rating       = Integer.parseInt(p[3]);
        String comment   = p[4];
        String type      = p[5];
        String timestamp = p[6];
// Type eka "Bike" nam BikeReview object ekak hadanawa, nathnam ServiceReview object ekak hadanawa.
        if (AppConstants.REVIEW_BIKE.equals(type)) {
            return new BikeReview(id, userId, targetId, rating, comment, timestamp);
        } else {
            return new ServiceReview(id, userId, targetId, rating, comment, timestamp);
        }
    }

    public List<Review> readAll() {
        List<Review> reviews = new ArrayList<>();
        // FileHelper eken okkoma peli kiyawala loop ekak haraha eka gane gannawa
        for (String line : FileHelper.readAll(AppConstants.REVIEWS_FILE)) {
            Review r = parseLine(line);
            if (r != null) reviews.add(r);// Waradi nathi data witharak list ekata ekathu karanawa
        }
        return reviews;
    }
// Adala ID ekata match wena review eka witharak hoyala denawa
    public Review findById(String id) {
        String line = FileHelper.findById(AppConstants.REVIEWS_FILE, id);
        return line != null ? parseLine(line) : null;
    }

    public List<Review> findByUser(String userId) {
        List<Review> result = new ArrayList<>();
        for (Review r : readAll()) {
            if (r.getUserId().equals(userId)) result.add(r);
        }
        //object eka text file eke anthimata liyanawa
        return result;
    }
// Bike reviews da nathnam Service reviews da kiyala wen karala ganna meka use karanawa.
    public List<Review> findByTarget(String targetId) {
        List<Review> result = new ArrayList<>();
        for (Review r : readAll()) {
            if (r.getTargetId().equals(targetId)) result.add(r);
        }
        return result;
    }

    public List<Review> findByType(String type) {
        List<Review> result = new ArrayList<>();
        for (Review r : readAll()) {
            if (r.getType().equals(type)) result.add(r);
        }
        return result;
    }
// Bike/Service ekakata dila thiyena reviews wala samanya tharu ganana (Average Rating) hoyanawa.
    public double getAverageRating(String targetId) {
        List<Review> reviews = findByTarget(targetId);
        if (reviews.isEmpty()) return 0;
        return reviews.stream().mapToInt(Review::getRating).average().orElse(0);
    }
// Aluth review ekak system ekata add karaddi meka weda karanawa.
    public boolean create(String userId, String targetId, int rating, String comment, String type) {
        if (rating < 1 || rating > 5) return false;
        String id        = FileHelper.generateId();
        String timestamp = LocalDateTime.now().format(FMT);
        Review review;
        // Type eka anuwa Bike da Service da kiyala object eka hadanawa.
        if (AppConstants.REVIEW_BIKE.equals(type)) {
            review = new BikeReview(id, userId, targetId, rating, comment, timestamp);
        } else {
            review = new ServiceReview(id, userId, targetId, rating, comment, timestamp);
        }
        //object eka text file eke anthimata liyanawa
        return FileHelper.append(AppConstants.REVIEWS_FILE, review.toFileString());
    }

    public boolean delete(String id) {
        return FileHelper.deleteById(AppConstants.REVIEWS_FILE, id);
    }

    public boolean update(String id, int rating, String comment) {
        if (rating < 1 || rating > 5)
            return false;

        Review review = findById(id);

        if (review == null)
            return false;

        review.setRating(rating);
        review.setComment(comment);

        List<String> lines  = FileHelper.readAll(AppConstants.REVIEWS_FILE);
        List<String> result = new ArrayList<>();
// Loop eken eka peliya gane check karanawa
        for (String line : lines) {
            String[] p = line.split("\\" + AppConstants.SEP);
            result.add(p[0].equals(id) ? review.toFileString() : line);
        }
        return FileHelper.writeAll(AppConstants.REVIEWS_FILE, result);
    }
}
