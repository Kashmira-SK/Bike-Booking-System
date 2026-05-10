package com.bikerental.BikeRentalSystem.servlet;

import com.bikerental.BikeRentalSystem.model.User;
import com.bikerental.BikeRentalSystem.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserServlet {

    @Autowired
    private UserService userService;

    // --- Register ---
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

    // --- Login ---
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
            return "redirect:/profile";
        }
        model.addAttribute("error", "Invalid email or password.");
        return "login";
    }

    // --- Profile ---
    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        model.addAttribute("user", user);
        return "profile";
    }

    // --- Logout ---
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}