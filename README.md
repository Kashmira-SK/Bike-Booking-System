# Bike Rental System

A web-based bike rental management system built with Spring Boot, JSP, and flat-file storage.
Developed as a group project for a university assignment.

---

## Team & Components

| Member | Branch | Component |
|---|---|---|
| M1 | `rental-management` | Rental Management |
| M2 | `user-management` | User Management |
| M3 | `bike-management` | Bike Management |
| M4 | `station-management` | Station Management |
| M5 | `payment-management` | Payment Management |
| M6 | `review-management` | Review & Feedback |

---

## Tech Stack

- **Backend** — Java 17, Spring Boot
- **Frontend** — JSP, Bootstrap 5, Bootstrap Icons
- **Storage** — Pipe-delimited text files via `FileHelper` utility
- **Build** — Maven

---

## Architecture

**Inheritance hierarchy** — 6 abstract base classes each with 2 concrete subclasses: `User`, `Bike`, `Station`, `Rental`, `Payment`, `Review`.

**Key design decisions:**
- Cost calculation is centralised in `RentalService` — hourly billed per hour, daily billed at a discounted rate
- Card payments are saved as `PENDING` and require admin approval; cash payments complete immediately
- `FileHelper` is the single I/O utility used by all services
- `BikeService` uses a custom quicksort to return available bikes sorted by price
- `RentalService` uses a queue to process rental requests

---

## Data File Formats

| File | Format |
|---|---|
| `users.txt` | `id\|name\|email\|password\|phone\|role\|status` |
| `bikes.txt` | `id\|sellerId\|type\|model\|pricePerHour\|stationId\|status\|imageUrl\|description` |
| `stations.txt` | `id\|name\|address\|city\|capacity\|bikeCount\|type` |
| `rentals.txt` | `id\|userId\|bikeId\|startStation\|endStation\|startTime\|endTime\|cost\|status\|type` |
| `payments.txt` | `id\|rentalId\|userId\|amount\|method\|status\|timestamp` |
| `reviews.txt` | `id\|userId\|targetId\|rating\|comment\|type\|timestamp` |
| `sellers.txt` | `userId\|location\|description\|approved` |

---

## How to Run

1. Clone the repo
2. Open in IntelliJ IDEA
3. Run `BikeRentalSystemApplication.java`
4. Open browser at `http://localhost:8081`

Default accounts (auto-seeded on first run):

| Role | Email | Password |
|---|---|---|
| Admin | `admin@bikerental.com` | `admin123` |
| Seller | `sarah@bikerental.com` | `seller123` |
| User | `user@bikerental.com` | `user123` |

---

## Branching Strategy

- `main` — stable, production-ready
- `dev` — integration branch
- Feature branches: `rental-management`, `user-management`, `bike-management`, `station-management`, `payment-management`, `review-management`
