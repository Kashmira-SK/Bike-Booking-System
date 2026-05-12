package com.bikerental.BikeRentalSystem.servlet;

import com.bikerental.BikeRentalSystem.model.*;
import com.bikerental.BikeRentalSystem.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/bikes")
public class BikeServlet {

    @Autowired private BikeService bikeService;
    @Autowired private StationService stationService;

    // Guest accessible
    @GetMapping
    public String list(Model model) {
        model.addAttribute("bikes", bikeService.readAll());
        Map<String, String> stationNames = new HashMap<>();
        for (Station s : stationService.readAll()) {
            stationNames.put(s.getId(), s.getName());
        }
        model.addAttribute("stationNames", stationNames);
        return "bikeList";
    }

    // Login needed
    @GetMapping("/add")
    public String showAddForm(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        model.addAttribute("stations", stationService.readAll());
        return "addBike";
    }

    @PostMapping("/add")
    public String addBike(@RequestParam String type,
                          @RequestParam String model,
                          @RequestParam double pricePerHour,
                          @RequestParam String stationId,
                          HttpSession session,
                          Model uiModel) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        boolean success = bikeService.create(type, model, pricePerHour, stationId);
        if (success) return "redirect:/bikes";
        uiModel.addAttribute("error", "Failed to add bike.");
        uiModel.addAttribute("stations", stationService.readAll());
        return "addBike";
    }

    // Login needed
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable String id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        Bike bike = bikeService.findById(id);
        if (bike == null) return "redirect:/bikes";
        model.addAttribute("bike", bike);
        model.addAttribute("stations", stationService.readAll());
        return "editBike";
    }

    @PostMapping("/edit/{id}")
    public String editBike(@PathVariable String id,
                           @RequestParam String model,
                           @RequestParam double pricePerHour,
                           @RequestParam String stationId,
                           @RequestParam String status,
                           HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        Bike bike = bikeService.findById(id);
        if (bike != null) {
            bike.setModel(model);
            bike.setPricePerHour(pricePerHour);
            bike.setStationId(stationId);
            bike.setStatus(status);
            bikeService.update(bike);
        }
        return "redirect:/bikes";
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable String id, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        bikeService.delete(id);
        return "redirect:/bikes";
    }
}