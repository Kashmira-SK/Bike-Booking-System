package com.bikerental.BikeRentalSystem.servlet;

import com.bikerental.BikeRentalSystem.util.AppConstants;
import com.bikerental.BikeRentalSystem.model.User;
import com.bikerental.BikeRentalSystem.service.SellerService;
import com.bikerental.BikeRentalSystem.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/seller")
public class SellerServlet {

    @Autowired
    private SellerService sellerService;

    @Autowired
    private UserService userService;

    @GetMapping("/register")
    public String showRegisterForm(HttpSession session, Model model) {

        User loggedIn = (User) session.getAttribute("loggedInUser");

        if (loggedIn == null) {
            return "redirect:/login";
        }

        if (!AppConstants.ROLE_REGULAR.equals(loggedIn.getRole())) {
            // Already a seller or admin — send to profile
            return "redirect:/profile";
        }

        return "sellerRegister";
    }

    @PostMapping("/register")
    public String processRegister(
            @RequestParam("location")    String location,
            @RequestParam("description") String description,
            HttpSession session,
            Model model) {

        User loggedIn = (User) session.getAttribute("loggedInUser");

        if (loggedIn == null) {
            return "redirect:/login";
        }

        if (!AppConstants.ROLE_REGULAR.equals(loggedIn.getRole())) {
            return "redirect:/profile";
        }

        // Validate inputs
        if (location == null || location.isBlank()
                || description == null || description.isBlank()) {
            model.addAttribute("error", "Location and description are required.");
            return "sellerRegister";
        }

        boolean success = sellerService.register(loggedIn.getId(), location.trim(), description.trim());

        if (!success) {
            model.addAttribute("error", "Registration failed. You may already be registered.");
            return "sellerRegister";
        }

        // Re-fetch the updated user (role is now SELLER) and refresh the session
        User updatedUser = userService.findById(loggedIn.getId());
        if (updatedUser != null) {
            session.setAttribute("loggedInUser", updatedUser);
        }

        return "redirect:/profile";
    }
}