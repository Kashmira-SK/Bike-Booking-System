<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Privacy Policy — BikeRental</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <style>
        :root { --br-dark: #0d1117; }
        footer { background: var(--br-dark); }
        footer a { color: #8d99a6; text-decoration: none; transition: color .15s; }
        footer a:hover { color: #fff; }
        .footer-brand { font-size: 1.25rem; font-weight: 800; color: #fff; }
        .footer-hdg { font-size: .78rem; font-weight: 700; letter-spacing: .1em; text-transform: uppercase; color: #6c757d; }
        .legal-prose h5 { font-weight: 700; margin-top: 2rem; margin-bottom: .6rem; }
        .legal-prose p  { color: #4a5568; line-height: 1.8; }
    </style>
</head>
<body>

<%-- NAVBAR --%>
<nav class="navbar navbar-expand-lg navbar-dark sticky-top" style="background: var(--br-dark); border-bottom: 1px solid #1e2a38;">
    <div class="container">
        <a class="navbar-brand fw-bold" href="/home">🚲 BikeRental</a>
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="mainNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="/home">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="/bikes">Bikes</a></li>
                <li class="nav-item"><a class="nav-link" href="/stations">Stations</a></li>
                <li class="nav-item"><a class="nav-link" href="/reviews">Reviews</a></li>
            </ul>
            <div class="d-flex align-items-center gap-2">
                <c:choose>
                    <c:when test="${not empty sessionScope.loggedInUser}">
                        <span class="text-secondary small me-1">Hi, <span class="text-white fw-semibold">${sessionScope.loggedInUser.name}</span></span>
                        <a href="/profile" class="btn btn-outline-light btn-sm">Profile</a>
                        <a href="/logout"  class="btn btn-outline-danger btn-sm">Logout</a>
                    </c:when>
                    <c:otherwise>
                        <a href="/login"    class="btn btn-outline-light btn-sm">Login</a>
                        <a href="/register" class="btn btn-primary btn-sm">Register</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<%-- CONTENT --%>
<div class="container py-5" style="max-width: 760px;">
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb small">
            <li class="breadcrumb-item"><a href="/home">Home</a></li>
            <li class="breadcrumb-item active">Privacy Policy</li>
        </ol>
    </nav>
    <h1 class="fw-bold mb-1">Privacy Policy</h1>
    <p class="text-muted small mb-5">Last updated: January 1, 2025</p>

    <div class="legal-prose">
        <h5>1. Information We Collect</h5>
        <p>
            When you create a BikeRental account, we collect the information you provide directly, including
            your full name, email address, phone number, and password. When you complete a rental, we also
            collect transaction data such as the bike rented, pickup and return station, rental duration, and
            payment details. We may additionally collect device and usage information — such as browser type,
            IP address, and pages visited — to help us maintain and improve the platform.
        </p>

        <h5>2. How We Use Your Information</h5>
        <p>
            We use the information we collect to operate and provide the BikeRental service, process
            payments, send booking confirmations and service-related communications, and improve the
            platform's features and reliability. We may use anonymised, aggregated usage data for internal
            analytics. We will not use your personal information to send marketing communications without
            your explicit consent, and you may opt out of any such communications at any time through your
            account settings.
        </p>

        <h5>3. Information Sharing</h5>
        <p>
            BikeRental does not sell, rent, or trade your personal information to third parties. We may share
            limited data with trusted service providers who assist us in operating the platform — such as
            payment processors and infrastructure providers — solely to the extent necessary to perform those
            services. These providers are contractually required to keep your information confidential and may
            not use it for any other purpose. We may also disclose information when required by law or to
            protect the rights and safety of BikeRental, its users, or the public.
        </p>

        <h5>4. Data Retention and Your Rights</h5>
        <p>
            We retain your personal data for as long as your account is active or as needed to provide
            services. You may request access to, correction of, or deletion of your personal data at any
            time by contacting us at privacy@bikerental.example.com. Upon a valid deletion request, we will
            remove your personal data from our systems within 30 days, except where retention is required
            by law. BikeRental takes reasonable technical and organisational measures to protect your data
            against unauthorised access, loss, or misuse.
        </p>
    </div>
</div>

<%-- FOOTER --%>
<footer class="pt-5 pb-4">
    <div class="container">
        <div class="row g-4 pb-4" style="border-bottom:1px solid #1e2a38;">
            <div class="col-md-4">
                <div class="footer-brand mb-2">🚲 BikeRental</div>
                <p class="text-secondary small mb-0" style="line-height:1.7;">
                    Rent a bike. Explore freely.<br>
                    Hourly and daily rentals at stations near you.
                </p>
            </div>
            <div class="col-md-4">
                <div class="footer-hdg mb-3">Explore</div>
                <ul class="list-unstyled mb-0 small">
                    <li class="mb-2"><a href="/home">Home</a></li>
                    <li class="mb-2"><a href="/bikes">Bikes</a></li>
                    <li class="mb-2"><a href="/stations">Stations</a></li>
                    <li class="mb-2"><a href="/reviews">Reviews</a></li>
                </ul>
            </div>
            <div class="col-md-4">
                <div class="footer-hdg mb-3">Legal</div>
                <ul class="list-unstyled mb-0 small">
                    <li class="mb-2"><a href="/terms">Terms of Service</a></li>
                    <li class="mb-2"><a href="/privacy">Privacy Policy</a></li>
                    <li class="mb-2"><a href="/contact">Contact</a></li>
                </ul>
            </div>
        </div>
        <div class="pt-4 text-center text-secondary small">
            &copy; 2025 BikeRental. All rights reserved.
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>