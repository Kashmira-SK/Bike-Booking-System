# 🚲 Bike Booking System

A web-based bike rental management system built with Spring Boot, JSP, and text file storage.
Developed as a group project using Java OOP principles.

---

## 👥 Team & Components

| Member | Branch | Component |
|---|---|---|
| M1 | `rental-management` | Rental Management |
| M2 | `user-management` | User Management |
| M3 | `bike-management` | Bike Management |
| M4 | `station-management` | Station Management |
| M5 | `payment-management` | Payment Management |
| M6 | `review-management` | Review & Feedback |

---

## 🏗️ Project Vision — Full File Structure

```
src/main/java/com/bikerental/BikeRentalSystem/
│
├── model/
│   ├── Rental.java                  ← abstract
│   ├── HourlyRental.java
│   ├── DailyRental.java
│   ├── User.java                    ← abstract
│   ├── RegularUser.java
│   ├── AdminUser.java
│   ├── Bike.java                    ← abstract
│   ├── ElectricBike.java
│   ├── MountainBike.java
│   ├── RoadBike.java
│   ├── Station.java                 ← abstract
│   ├── MainStation.java
│   ├── SatelliteStation.java
│   ├── Payment.java                 ← abstract
│   ├── CashPayment.java
│   ├── CardPayment.java
│   ├── Review.java                  ← abstract
│   ├── BikeReview.java
│   └── ServiceReview.java
│
├── service/
│   ├── RentalService.java
│   ├── UserService.java
│   ├── BikeService.java
│   ├── StationService.java
│   ├── PaymentService.java
│   └── ReviewService.java
│
├── servlet/
│   ├── RentalServlet.java
│   ├── UserServlet.java
│   ├── BikeServlet.java
│   ├── StationServlet.java
│   ├── PaymentServlet.java
│   └── ReviewServlet.java
│
└── util/
    └── FileHelper.java

src/main/webapp/WEB-INF/views/
├── rentBike.jsp
├── returnBike.jsp
├── rentalHistory.jsp
├── allRentals.jsp
├── register.jsp
├── login.jsp
├── profile.jsp
├── addBike.jsp
├── bikeList.jsp
├── editBike.jsp
├── addStation.jsp
├── stationList.jsp
├── stationDetail.jsp
├── checkout.jsp
├── paymentHistory.jsp
├── receipt.jsp
├── submitReview.jsp
├── viewReviews.jsp
└── myReviews.jsp

data/
├── rentals.txt
├── users.txt
├── bikes.txt
├── stations.txt
├── payments.txt
└── reviews.txt
```

## ⚙️ Tech Stack

- **Backend** — Java, Spring Boot
- **Frontend** — JSP, Bootstrap 5
- **Storage** — Text files via FileHelper utility
- **Build** — Maven

---

## 🔧 How to Run

1. Clone the repo
2. Open in IntelliJ IDEA
3. Switch to your branch — `git checkout your-branch-name`
4. Run `BikeRentalSystemApplication.java`
5. Open browser at `http://localhost:8080`

---

## 🌿 Branch Rules

- **Never push directly to `main`**
- Always work on your own branch
- Pull before you start — `git pull origin your-branch`
- Commit often with clear messages
- Main will be merged at the end by the project lead

---

## 📁 Data File Formats

| Component | Format |
|---|---|
| Rental | `id\|userId\|bikeId\|startStation\|endStation\|startTime\|endTime\|cost\|status\|type` |
| User | `id\|name\|email\|password\|phone\|role\|status` |
| Bike | `id\|type\|model\|pricePerHour\|stationId\|status` |
| Station | `id\|name\|address\|city\|capacity\|bikeCount\|type` |
| Payment | `id\|rentalId\|userId\|amount\|method\|status\|timestamp` |
| Review | `id\|userId\|targetId\|rating\|comment\|type\|timestamp` |