package com.bikerental.BikeRentalSystem.servlet;

import com.bikerental.BikeRentalSystem.model.User;
import com.bikerental.BikeRentalSystem.service.ReviewService;
import com.bikerental.BikeRentalSystem.util.AppConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/reviews")
public class ReviewServlet {

    @Autowired
    private ReviewService reviewService;

    // Guest accessible
    @GetMapping
    public String viewAll(Model model) {
        model.addAttribute("reviews", reviewService.readAll());
        return "viewReviews";
    }

    // Login needed
    @GetMapping("/my")
    public String myReviews(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        model.addAttribute("reviews", reviewService.findByUser(user.getId()));
        return "myReviews";
    }

    // Guest accessible (form shown to all; POST enforces login)
    @GetMapping("/submit")
    public String showSubmitForm(@RequestParam(required = false) String targetId,
                                 @RequestParam(required = false) String type,
                                 Model model) {
        model.addAttribute("targetId", targetId);
        model.addAttribute("type", type);
        model.addAttribute("reviewBike", AppConstants.REVIEW_BIKE);
        model.addAttribute("reviewService", AppConstants.REVIEW_SERVICE);
        return "submitReview";
    }

    // Login needed
    @PostMapping("/submit")
    public String submitReview(@RequestParam String targetId,
                               @RequestParam int rating,
                               @RequestParam String comment,
                               @RequestParam String type,
                               HttpSession session,
                               Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        boolean success = reviewService.create(user.getId(), targetId, rating, comment, type);
        if (success) return "redirect:/reviews/my";
        model.addAttribute("error", "Failed to submit review. Rating must be between 1 and 5.");
        model.addAttribute("targetId", targetId);
        model.addAttribute("type", type);
        return "submitReview";
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable String id, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        reviewService.delete(id);
        return "redirect:/reviews/my";
    }
}