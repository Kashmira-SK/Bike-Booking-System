package com.bikerental.BikeRentalSystem.servlet;

import com.bikerental.BikeRentalSystem.model.*;
import com.bikerental.BikeRentalSystem.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;


@Controller
@RequestMapping("/rentals")
public class RentalServlet {

    @Autowired private RentalService rentalService;
    @Autowired private BikeService bikeService;
    @Autowired private StationService stationService;

    // Admin/overview — login needed
    @GetMapping
    public String allRentals(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        model.addAttribute("rentals", rentalService.readAll());
        return "allRentals";
    }

    // Login needed
    @GetMapping("/history")
    public String history(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        model.addAttribute("rentals", rentalService.findByUser(user.getId()));
        return "rentalHistory";
    }

    // Login needed
    @GetMapping("/rent")
    public String showRentForm(@RequestParam(required = false) String bikeId,
                               HttpSession session,
                               Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        if (bikeId != null) {
            model.addAttribute("selectedBike", bikeService.findById(bikeId));
        }
        model.addAttribute("availableBikes", bikeService.findAvailableSorted());
        model.addAttribute("stations", stationService.readAll());
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
        boolean success = rentalService.rentBike(user.getId(), bikeId, startStation, endStation, type, new ArrayList<>());
        if (success) return "redirect:/rentals/history";
        model.addAttribute("error", "Could not rent bike. It may no longer be available.");
        model.addAttribute("availableBikes", bikeService.findAvailableSorted());
        model.addAttribute("stations", stationService.readAll());
        return "rentBike";
    }

    // Login needed
    @GetMapping("/return")
    public String showReturnForm(@RequestParam(required = false) String rentalId,
                                 HttpSession session,
                                 Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        if (rentalId != null) {
            model.addAttribute("rental", rentalService.findById(rentalId));
        }
        return "returnBike";
    }

    @PostMapping("/return")
    public String returnBike(@RequestParam String rentalId,
                             HttpSession session,
                             Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        double cost = rentalService.returnBike(rentalId);
        if (cost < 0) {
            model.addAttribute("error", "Rental not found or already completed.");
            return "returnBike";
        }
        return "redirect:/payments/checkout?rentalId=" + rentalId;
    }

    @PostMapping("/cancel/{id}")
    public String cancel(@PathVariable String id, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        rentalService.cancel(id);
        return "redirect:/rentals/history";
    }
}