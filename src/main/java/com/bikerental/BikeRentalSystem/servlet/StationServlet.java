package com.bikerental.BikeRentalSystem.servlet;

import com.bikerental.BikeRentalSystem.model.Station;
import com.bikerental.BikeRentalSystem.service.StationService;
import com.bikerental.BikeRentalSystem.util.AppConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/stations")
public class StationServlet {

    @Autowired
    private StationService stationService;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("stations", stationService.readAll());
        return "stationList";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
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
                             Model model) {
        boolean success = stationService.create(name, address, city, capacity, type);
        if (success) {
            return "redirect:/stations";
        }
        model.addAttribute("error", "Failed to add station. Please try again.");
        return "addStation";
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable String id, Model model) {
        Station station = stationService.findById(id);
        if (station == null) return "redirect:/stations";
        model.addAttribute("station", station);
        return "stationDetail";
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable String id) {
        stationService.delete(id);
        return "redirect:/stations";
    }
}