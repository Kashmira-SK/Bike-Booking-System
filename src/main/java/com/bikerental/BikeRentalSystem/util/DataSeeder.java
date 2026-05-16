package com.bikerental.BikeRentalSystem.util;

import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class DataSeeder implements ApplicationListener<ContextRefreshedEvent> {

    private boolean hasRun = false;

    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
        if (hasRun) return;
        hasRun = true;

        if (
                !FileHelper.readAll(AppConstants.USERS_FILE).isEmpty()    ||
                        !FileHelper.readAll(AppConstants.BIKES_FILE).isEmpty()    ||
                        !FileHelper.readAll(AppConstants.STATIONS_FILE).isEmpty() ||
                        !FileHelper.readAll(AppConstants.REVIEWS_FILE).isEmpty()  ||
                        !FileHelper.readAll(AppConstants.RENTALS_FILE).isEmpty()  ||
                        !FileHelper.readAll(AppConstants.PAYMENTS_FILE).isEmpty() ||
                        !FileHelper.readAll(AppConstants.SELLERS_FILE).isEmpty()
        ) return;

        FileHelper.writeAll(AppConstants.STATIONS_FILE, List.of(
                "S001|Central Station|No 1 Main St|Colombo|20|0|MAIN",
                "S002|Kandy Hub|Temple Rd|Kandy|10|0|SATELLITE",
                "S003|Galle Fort|Fort Rd|Galle|8|0|SATELLITE"
        ));

        FileHelper.writeAll(AppConstants.USERS_FILE, List.of(
                "U001|Admin User|admin@bikerental.com|admin123|0771234567|ADMIN|ACTIVE",
                "U002|Sarah Seller|sarah@bikerental.com|seller123|0779876543|SELLER|ACTIVE",
                "U003|Regular User|user@bikerental.com|user123|0760000000|REGULAR|ACTIVE"
        ));

        FileHelper.writeAll(AppConstants.SELLERS_FILE, List.of(
                "U002|Kandy Hub Area|I offer well-maintained mountain bikes for the hill country.|Y"
        ));

        FileHelper.writeAll(AppConstants.BIKES_FILE, List.of(
                "B001|U002|MOUNTAIN|Trek Marlin 5|3.50|S002|AVAILABLE|https://images.unsplash.com/photo-1571068316344-75bc76f77890?w=400|Great for hill trails",
                "B002|U002|MOUNTAIN|Giant Talon 3|3.00|S002|AVAILABLE|https://images.unsplash.com/photo-1576435728678-68d0fbf94e91?w=400|Reliable hardtail MTB",
                "B003|U001|ROAD|Trek Domane AL2|2.50|S001|AVAILABLE|https://images.unsplash.com/photo-1485965120184-e220f721d03e?w=400|Smooth city roads",
                "B004|U001|ROAD|Giant Contend 3|2.00|S001|AVAILABLE|https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400|Lightweight road bike",
                "B005|U001|ELECTRIC|Specialized Turbo Vado|5.00|S001|AVAILABLE|https://images.unsplash.com/photo-1571333250630-f0230c320b6d?w=400|Pedal-assisted electric",
                "B006|U001|ELECTRIC|Giant E+2|4.50|S003|AVAILABLE|https://images.unsplash.com/photo-1532298229144-0ec0c57515c7?w=400|Long range electric bike"
        ));

        FileHelper.writeAll(AppConstants.REVIEWS_FILE, List.of(
                "R001|U003|B003|5|Smooth ride, great condition. Loved it!|BIKE|2025-05-01 10:00:00",
                "R002|U003|B005|4|Electric assist made the hills so easy. Highly recommend.|BIKE|2025-05-03 14:30:00",
                "R003|U002|B001|5|My own bike, well maintained. Customers love it!|BIKE|2025-05-05 09:15:00"
        ));

        updateStationBikeCounts();
    }

    private void updateStationBikeCounts() {
        List<String> stations = FileHelper.readAll(AppConstants.STATIONS_FILE);
        List<String> updated = new ArrayList<>();
        for (String station : stations) {
            String[] p = station.split("\\" + AppConstants.SEP);
            if (p.length == 7) {
                if ("S001".equals(p[0]))      p[5] = "4";
                else if ("S002".equals(p[0])) p[5] = "2";
                else if ("S003".equals(p[0])) p[5] = "1";
                updated.add(String.join(AppConstants.SEP, p));
            } else {
                updated.add(station);
            }
        }
        FileHelper.writeAll(AppConstants.STATIONS_FILE, updated);
    }
}