package com.bikerental.BikeRentalSystem.servlet;

import com.bikerental.BikeRentalSystem.model.*;
import com.bikerental.BikeRentalSystem.service.*;
import com.bikerental.BikeRentalSystem.util.AppConstants;
import com.bikerental.BikeRentalSystem.util.FileHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminServlet {

    @Autowired private UserService    userService;
    @Autowired private BikeService    bikeService;
    @Autowired private RentalService  rentalService;
    @Autowired private PaymentService paymentService;
    @Autowired private StationService stationService;

    private boolean isAdmin(HttpSession session) {
        User u = (User) session.getAttribute(AppConstants.SESSION_USER);
        return u != null && AppConstants.ROLE_ADMIN.equals(u.getRole());
    }

    @GetMapping
    public String dashboard(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/home";

        List<Rental>  rentals  = rentalService.readAll();
        List<Payment> payments = paymentService.readAll();

        long   activeRentals = rentals.stream()
                .filter(r -> AppConstants.RENTAL_ACTIVE.equals(r.getStatus())).count();
        double totalRevenue  = payments.stream()
                .filter(p -> AppConstants.PAYMENT_DONE.equals(p.getStatus()))
                .mapToDouble(Payment::getAmount).sum();

        model.addAttribute("totalUsers",    userService.readAll().size());
        model.addAttribute("totalBikes",    bikeService.readAll().size());
        model.addAttribute("totalRentals",  rentals.size());
        model.addAttribute("activeRentals", activeRentals);
        model.addAttribute("totalRevenue",  totalRevenue);
        return "adminDashboard";
    }

    @GetMapping("/users")
    public String users(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/home";
        model.addAttribute("users", userService.readAll());
        return "adminUsers";
    }

    @PostMapping("/users/role")
    public String changeRole(@RequestParam String userId,
                             @RequestParam String newRole,
                             HttpSession session) {
        if (!isAdmin(session)) return "redirect:/home";
        User u = userService.findById(userId);
        if (u != null) { u.setRole(newRole); userService.update(u); }
        return "redirect:/admin/users";
    }

    @PostMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable String id, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/home";
        userService.delete(id);
        return "redirect:/admin/users";
    }

    @GetMapping("/users/{id}")
    public String userDetail(@PathVariable String id, HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/home";
        User u = userService.findById(id);
        if (u == null) return "redirect:/admin/users";
        model.addAttribute("user",     u);
        model.addAttribute("rentals",  rentalService.findByUser(id));
        model.addAttribute("payments", paymentService.findByUser(id));
        return "adminUserDetail";
    }

    @GetMapping("/rentals")
    public String rentals(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/home";
        model.addAttribute("rentals", rentalService.readAll());
        return "adminRentals";
    }

    @PostMapping("/rentals/cancel/{id}")
    public String cancelRental(@PathVariable String id, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/home";
        rentalService.cancel(id);
        return "redirect:/admin/rentals";
    }

    @PostMapping("/rentals/delete/{id}")
    public String deleteRental(@PathVariable String id, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/home";
        FileHelper.deleteById(AppConstants.RENTALS_FILE, id);
        return "redirect:/admin/rentals";
    }

    @GetMapping("/bikes")
    public String bikes(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/home";
        model.addAttribute("bikes", bikeService.readAll());
        return "redirect:/bikes";
    }

    @GetMapping("/stations")
    public String stations(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/home";
        model.addAttribute("stations", stationService.readAll());
        return "adminStations";
    }

    @PostMapping("/stations/add")
    public String addStation(@RequestParam String name,
                             @RequestParam String address,
                             @RequestParam String city,
                             @RequestParam int    capacity,
                             @RequestParam String type,
                             HttpSession session) {
        if (!isAdmin(session)) return "redirect:/home";
        stationService.create(name, address, city, capacity, type);
        return "redirect:/admin/stations";
    }

    @PostMapping("/stations/edit/{id}")
    public String editStation(@PathVariable String id,
                              @RequestParam String name,
                              @RequestParam String address,
                              @RequestParam String city,
                              @RequestParam int    capacity,
                              @RequestParam String type,
                              HttpSession session) {
        if (!isAdmin(session)) return "redirect:/home";
        Station s = stationService.findById(id);
        if (s != null) {
            s.setName(name); s.setAddress(address); s.setCity(city);
            s.setCapacity(capacity); s.setType(type);
            stationService.update(s);
        }
        return "redirect:/admin/stations";
    }

    @PostMapping("/stations/delete/{id}")
    public String deleteStation(@PathVariable String id, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/home";
        stationService.delete(id);
        return "redirect:/admin/stations";
    }
}