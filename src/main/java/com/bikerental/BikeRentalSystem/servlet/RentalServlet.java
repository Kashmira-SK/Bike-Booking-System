package com.bikerental.BikeRentalSystem.servlet;

import com.bikerental.BikeRentalSystem.model.Rental;
import com.bikerental.BikeRentalSystem.model.User;
import com.bikerental.BikeRentalSystem.service.RentalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/rentals")
public class RentalServlet {

    @Autowired
    private RentalService rentalService;

    @GetMapping
    public String allRentals(Model model) {
        model.addAttribute("rentals", rentalService.readAll());
        return "allRentals";
    }

    @GetMapping("/history")
    public String history(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        model.addAttribute("rentals", rentalService.findByUser(user.getId()));
        return "rentalHistory";
    }

    @GetMapping("/rent")
    public String showRentForm() {
        return "rentBike";
    }

    @PostMapping("/rent")
    public String rentBike(@RequestParam String bikeId,
                           @RequestParam String startStation,
                           @RequestParam String endStation,
                           @RequestParam String type,
                           HttpSession session,
                           Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        boolean success = rentalService.rentBike(user.getId(), bikeId, startStation, endStation, type);
        if (success) return "redirect:/rentals/history";

        model.addAttribute("error", "Could not rent bike. It may no longer be available.");
        return "rentBike";
    }

    @GetMapping("/return")
    public String showReturnForm() {
        return "returnBike";
    }

    @PostMapping("/return")
    public String returnBike(@RequestParam String rentalId, Model model) {
        double cost = rentalService.returnBike(rentalId);
        if (cost < 0) {
            model.addAttribute("error", "Rental not found or already completed.");
            return "returnBike";
        }
        model.addAttribute("cost", cost);
        model.addAttribute("rentalId", rentalId);
        return "returnBike";
    }

    @PostMapping("/cancel/{id}")
    public String cancel(@PathVariable String id, HttpSession session) {
        rentalService.cancel(id);
        return "redirect:/rentals/history";
    }
}