package com.bikerental.BikeRentalSystem.servlet;

import com.bikerental.BikeRentalSystem.model.Bike;
import com.bikerental.BikeRentalSystem.model.Review;
import com.bikerental.BikeRentalSystem.model.User;
import com.bikerental.BikeRentalSystem.service.BikeService;
import com.bikerental.BikeRentalSystem.service.ReviewService;
import com.bikerental.BikeRentalSystem.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
public class UserServlet {

    @Autowired
    private UserService userService;

    @Autowired
    private BikeService bikeService;

    @Autowired
    private ReviewService reviewService;

    @GetMapping("/home")
    public String home(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user != null) {
            model.addAttribute("user", user);
        }
        List<Bike> allBikes = bikeService.readAll();
        model.addAttribute("featuredBikes", allBikes.subList(0, Math.min(4, allBikes.size())));
        List<Review> allReviews = reviewService.readAll();
        model.addAttribute("recentReviews", allReviews.subList(0, Math.min(3, allReviews.size())));
        return "home";
    }

    @GetMapping("/register")
    public String showRegister() {
        return "register";
    }

    @PostMapping("/register")
    public String register(@RequestParam String name,
                           @RequestParam String email,
                           @RequestParam String password,
                           @RequestParam String phone,
                           Model model) {
        if (userService.emailExists(email)) {
            model.addAttribute("error", "An account with that email already exists.");
            return "register";
        }
        boolean success = userService.register(name, email, password, phone);
        if (success) return "redirect:/login";
        model.addAttribute("error", "Registration failed. Please try again.");
        return "register";
    }

    @GetMapping("/login")
    public String showLogin() {
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        HttpSession session,
                        Model model) {
        User user = userService.login(email, password);
        if (user != null) {
            session.setAttribute("loggedInUser", user);
            return "redirect:/home";
        }
        model.addAttribute("error", "Invalid email or password.");
        return "login";
    }

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        model.addAttribute("user", user);
        return "profile";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    @GetMapping("/terms")
    public String terms() {
        return "terms";
    }

    @GetMapping("/privacy")
    public String privacy() {
        return "privacy";
    }

    @GetMapping("/contact")
    public String contact() {
        return "contact";
    }
}