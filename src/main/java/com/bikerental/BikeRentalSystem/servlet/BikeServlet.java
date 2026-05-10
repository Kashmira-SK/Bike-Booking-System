package com.bikerental.BikeRentalSystem.servlet;

import com.bikerental.BikeRentalSystem.model.Bike;
import com.bikerental.BikeRentalSystem.service.BikeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/bikes")
public class BikeServlet {

    @Autowired
    private BikeService bikeService;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("bikes", bikeService.readAll());
        return "bikeList";
    }

    @GetMapping("/add")
    public String showAddForm() {
        return "addBike";
    }

    @PostMapping("/add")
    public String addBike(@RequestParam String type,
                          @RequestParam String model,
                          @RequestParam double pricePerHour,
                          @RequestParam String stationId,
                          Model uiModel) {
        boolean success = bikeService.create(type, model, pricePerHour, stationId);
        if (success) return "redirect:/bikes";
        uiModel.addAttribute("error", "Failed to add bike. Please try again.");
        return "addBike";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable String id, Model model) {
        Bike bike = bikeService.findById(id);
        if (bike == null) return "redirect:/bikes";
        model.addAttribute("bike", bike);
        return "editBike";
    }

    @PostMapping("/edit/{id}")
    public String editBike(@PathVariable String id,
                           @RequestParam String model,
                           @RequestParam double pricePerHour,
                           @RequestParam String stationId,
                           @RequestParam String status) {
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
    public String delete(@PathVariable String id) {
        bikeService.delete(id);
        return "redirect:/bikes";
    }
}