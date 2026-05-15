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

@Controller // Tells the system this class handles web page navigation
@RequestMapping("/stations") // All web addresses in this class start with "/stations"
public class StationServlet {

    @Autowired // Automatically connects the StationService (the logic brain) to this class
    private StationService stationService;

    // Shows a list of all bike stations to any visitor
    @GetMapping
    public String list(Model model) {
        // Gets all stations and sends them to the "stationList" HTML page
        model.addAttribute("stations", stationService.readAll());
        return "stationList";
    }

    // Shows details of a specific station based on its ID
    @GetMapping("/{id}")
    public String detail(@PathVariable String id, Model model) {
        Station station = stationService.findById(id);
        if (station == null) return "redirect:/stations"; // If station not found, go back to list
        model.addAttribute("station", station);
        return "stationDetail";
    }

    // Opens the "Add Station" form, but only if the user is logged in
    @GetMapping("/add")
    public String showAddForm(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser"); // Check if a user is logged in
        if (user == null) return "redirect:/login"; // If not logged in, send them to the login page
        
        // Adds station types to the page so the user can pick "Main" or "Satellite"
        model.addAttribute("stationMain", AppConstants.STATION_MAIN);
        model.addAttribute("stationSat", AppConstants.STATION_SAT);
        return "addStation";
    }

    // Handles the data when the user clicks "Submit" on the Add Station form
    @PostMapping("/add")
    public String addStation(@RequestParam String name,
                             @RequestParam String address,
                             @RequestParam String city,
                             @RequestParam int capacity,
                             @RequestParam String type,
                             HttpSession session,
                             Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login"; // Security check
        
        // Asks the service to create the station
        boolean success = stationService.create(name, address, city, capacity, type);
        if (success) return "redirect:/stations"; // If it worked, go back to the list
        
        model.addAttribute("error", "Failed to add station. Please try again."); // Show error if it failed
        return "addStation";
    }

    // Deletes a station when the delete button is clicked
    @PostMapping("/delete/{id}")
    public String delete(@PathVariable String id, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login"; // Only logged-in users can delete
        
        stationService.delete(id); // Ask service to remove the station
        return "redirect:/stations"; // Refresh the list
    }
}e(id);
        return "redirect:/stations";
    }
}
