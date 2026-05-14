package com.bikerental.BikeRentalSystem.servlet;

import com.bikerental.BikeRentalSystem.model.*;
import com.bikerental.BikeRentalSystem.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/bikes")
public class BikeServlet {

    @Autowired private BikeService bikeService;
    @Autowired private StationService stationService;
    @Autowired private ExtraService extraService;

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

    @GetMapping("/mine")
    public String myBikes(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        if (!user.getRole().equals("SELLER") && !user.getRole().equals("ADMIN"))
            return "redirect:/bikes";
        List<Bike> myBikes = bikeService.findBySeller(user.getId());
        Map<String, List<Extra>> extrasMap = new HashMap<>();
        for (Bike b : myBikes) {
            extrasMap.put(b.getId(), extraService.findByBike(b.getId()));
        }
        model.addAttribute("bikes", myBikes);
        model.addAttribute("extrasMap", extrasMap);
        return "myBikes";
    }

    @GetMapping("/add")
    public String showAddForm(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        if (!user.getRole().equals("SELLER") && !user.getRole().equals("ADMIN"))
            return "redirect:/bikes";
        model.addAttribute("stations", stationService.readAll());
        return "addBike";
    }

    @PostMapping("/add")
    public String addBike(HttpServletRequest request, HttpSession session, Model uiModel) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        if (!user.getRole().equals("SELLER") && !user.getRole().equals("ADMIN"))
            return "redirect:/bikes";

        String type        = request.getParameter("type");
        String model       = request.getParameter("model");
        String stationId   = request.getParameter("stationId");
        String imageUrl    = request.getParameter("imageUrl");
        String description = request.getParameter("description");
        String sellerId    = user.getId();
        double pricePerHour;

        try {
            pricePerHour = Double.parseDouble(request.getParameter("pricePerHour"));
        } catch (NumberFormatException e) {
            uiModel.addAttribute("error", "Invalid price.");
            uiModel.addAttribute("stations", stationService.readAll());
            return "addBike";
        }

        if (imageUrl == null)    imageUrl    = "";
        if (description == null) description = "";

        boolean success = bikeService.create(sellerId, type, model, pricePerHour, stationId, imageUrl, description);
        if (!success) {
            uiModel.addAttribute("error", "Failed to add bike.");
            uiModel.addAttribute("stations", stationService.readAll());
            return "addBike";
        }

        List<Bike> sellerBikes = bikeService.findBySeller(sellerId);
        if (!sellerBikes.isEmpty()) {
            String newBikeId = sellerBikes.get(sellerBikes.size() - 1).getId();
            int i = 0;
            while (request.getParameter("extraName_" + i) != null) {
                String extraName       = request.getParameter("extraName_"     + i);
                String extraPriceStr   = request.getParameter("extraPrice_"    + i);
                String extraIncludedStr = request.getParameter("extraIncluded_" + i);
                if (extraName != null && !extraName.trim().isEmpty()) {
                    double  extraPrice = (extraPriceStr != null && !extraPriceStr.isEmpty())
                            ? Double.parseDouble(extraPriceStr) : 0.0;
                    boolean included   = "on".equals(extraIncludedStr) || "true".equals(extraIncludedStr);
                    extraService.addExtra(newBikeId, extraName.trim(), extraPrice, included);
                }
                i++;
            }
        }

        return "redirect:/bikes/mine";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable String id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        Bike bike = bikeService.findById(id);
        if (bike == null) return "redirect:/bikes";
        if (!bike.getSellerId().equals(user.getId()) && !user.getRole().equals("ADMIN"))
            return "redirect:/bikes";
        model.addAttribute("bike", bike);
        model.addAttribute("stations", stationService.readAll());
        model.addAttribute("extras", extraService.findByBike(id));
        return "editBike";
    }

    @PostMapping("/edit/{id}")
    public String editBike(@PathVariable String id,
                           @RequestParam String model,
                           @RequestParam double pricePerHour,
                           @RequestParam String stationId,
                           @RequestParam String status,
                           @RequestParam(required = false, defaultValue = "") String imageUrl,
                           @RequestParam(required = false, defaultValue = "") String description,
                           HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        Bike bike = bikeService.findById(id);
        if (bike == null) return "redirect:/bikes";
        if (!bike.getSellerId().equals(user.getId()) && !user.getRole().equals("ADMIN"))
            return "redirect:/bikes";
        bike.setModel(model);
        bike.setPricePerHour(pricePerHour);
        bike.setStationId(stationId);
        bike.setStatus(status);
        bike.setImageUrl(imageUrl);
        bike.setDescription(description);
        bikeService.update(bike);
        return "redirect:/bikes/mine";
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable String id, HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        Bike bike = bikeService.findById(id);
        if (bike == null) return "redirect:/bikes/mine";
        if (!bike.getSellerId().equals(user.getId()) && !user.getRole().equals("ADMIN"))
            return "redirect:/bikes";
        bikeService.delete(id);
        return "redirect:/bikes/mine";
    }
}