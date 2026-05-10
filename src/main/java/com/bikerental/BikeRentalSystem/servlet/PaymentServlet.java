package com.bikerental.BikeRentalSystem.servlet;

import com.bikerental.BikeRentalSystem.model.Payment;
import com.bikerental.BikeRentalSystem.model.User;
import com.bikerental.BikeRentalSystem.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/payments")
public class PaymentServlet {

    @Autowired
    private PaymentService paymentService;

    @GetMapping("/checkout")
    public String showCheckout(@RequestParam(required = false) String rentalId, Model model) {
        model.addAttribute("rentalId", rentalId);
        return "checkout";
    }

    @PostMapping("/checkout")
    public String processPayment(@RequestParam String rentalId,
                                 @RequestParam String method,
                                 HttpSession session,
                                 Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        Payment payment = paymentService.createPayment(rentalId, user.getId(), method);
        if (payment != null) {
            model.addAttribute("payment", payment);
            return "receipt";
        }

        model.addAttribute("error", "Payment failed. The rental may not be completed yet or has already been paid.");
        model.addAttribute("rentalId", rentalId);
        return "checkout";
    }

    @GetMapping("/history")
    public String history(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        model.addAttribute("payments", paymentService.findByUser(user.getId()));
        return "paymentHistory";
    }
}