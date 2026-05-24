package com.bikerental.BikeRentalSystem.servlet;

import com.bikerental.BikeRentalSystem.model.Station;
import com.bikerental.BikeRentalSystem.model.User;
import com.bikerental.BikeRentalSystem.service.StationService;
import com.bikerental.BikeRentalSystem.util.AppConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/stations")
public class StationServlet {

    @Autowired
    private StationService stationService;

    // Guest accessible
    @GetMapping
    public String list(Model model) {
        model.addAttribute("stations", stationService.readAll());
        return "stationList";
    }

    // Guest accessible
    @GetMapping("/{id}")
    public String detail(@PathVariable String id, Model model) {
        Station station = stationService.findById(id);
        if (station == null) return "redirect:/stations";
        model.addAttribute("station", station);
        return "stationDetail";
    }

    // Login needed
    @GetMapping("/add")
    public String showAddForm(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        model.addAttribute("stationMain", AppConstants.STATION_MAIN);
        model.addAttribute("stationSat", AppConstants.STATION_SAT);
        return "addStation";
    }

    @PostMapping("/add")
    public String addStation(@RequestParam String name,
                             @RequestParam String address,
                             @RequestParam String city,
                             @RequestParam int capacity,
                             @RequestParam String type,
                             HttpSession session,
                             Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        boolean success = stationService.create(name, address, city, capacity, type);
        if (success) return "redirect:/stations";
        model.addAttribute("error", "Failed to add station. Please try again.");
        return "addStation";
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable String id, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        stationService.delete(id);
        return "redirect:/stations";
    }
}