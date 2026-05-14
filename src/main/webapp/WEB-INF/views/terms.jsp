<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Terms of Service — BikeRental</title>
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
            <li class="breadcrumb-item active">Terms of Service</li>
        </ol>
    </nav>
    <h1 class="fw-bold mb-1">Terms of Service</h1>
    <p class="text-muted small mb-5">Last updated: January 1, 2025</p>

    <div class="legal-prose">
        <h5>1. Rental Liability</h5>
        <p>
            By renting a bike through BikeRental, you agree to assume full responsibility for the bicycle
            during the rental period. BikeRental shall not be held liable for any injuries, accidents, or
            losses sustained while operating a rental bike. Riders are solely responsible for obeying all
            applicable traffic laws, cycling regulations, and local ordinances. Any damage caused to third
            parties or property during the rental period is the sole financial responsibility of the renter.
            BikeRental strongly recommends that renters carry personal liability insurance prior to beginning
            any rental.
        </p>

        <h5>2. Helmet Policy</h5>
        <p>
            A helmet is provided with every rental at no additional charge. Renters are required to wear the
            provided helmet at all times while operating a BikeRental bicycle. Failure to wear a helmet may
            result in immediate termination of the rental and forfeiture of any unused rental time without
            refund. If the provided helmet does not fit correctly, renters should contact a station attendant
            before beginning their ride. BikeRental accepts no liability for head injuries sustained when a
            helmet is not worn or is worn incorrectly.
        </p>

        <h5>3. Damage Policy</h5>
        <p>
            Renters are responsible for returning the bicycle in the same condition as received, subject to
            normal wear and tear. Any damage beyond normal wear — including but not limited to bent frames,
            broken components, damaged locks, or missing accessories — will be assessed by BikeRental staff
            upon return. The cost of repairs will be charged to the payment method on file. In the event of
            a total loss due to theft or irreparable damage, the renter may be charged the full replacement
            value of the bicycle. Renters should report any pre-existing damage at the time of pickup to
            avoid being held responsible for prior issues.
        </p>

        <h5>4. Account and Payment Terms</h5>
        <p>
            A valid BikeRental account and payment method are required to initiate any rental. BikeRental
            reserves the right to suspend or terminate accounts that violate these terms. Refunds for
            shortened rentals are issued at BikeRental's sole discretion and are not guaranteed. BikeRental
            reserves the right to amend these Terms of Service at any time; continued use of the service
            following any changes constitutes acceptance of the revised terms.
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