package com.bikerental.BikeRentalSystem.service;

import com.bikerental.BikeRentalSystem.model.Review;
import com.bikerental.BikeRentalSystem.util.FileHelper;
import java.io.IOException;
import java.util.List;

public class ReviewService {
    private static final String FILE_PATH = "data/reviews.txt";

    public void createReview(Review review) throws IOException {
        FileHelper.appendLine(FILE_PATH, review.toFileString());
    }

    public List<String> readAll() throws IOException {
        return FileHelper.readLines(FILE_PATH);
    }
}