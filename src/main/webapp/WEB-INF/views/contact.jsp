<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us — BikeRental</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <style>
        :root { --br-dark: #0d1117; }
        footer { background: var(--br-dark); }
        footer a { color: #8d99a6; text-decoration: none; transition: color .15s; }
        footer a:hover { color: #fff; }
        .footer-brand { font-size: 1.25rem; font-weight: 800; color: #fff; }
        .footer-hdg { font-size: .78rem; font-weight: 700; letter-spacing: .1em; text-transform: uppercase; color: #6c757d; }
        .contact-info-card {
            border: 1px solid #e9ecef;
            border-radius: 16px;
            transition: box-shadow .2s;
        }
        .contact-info-card:hover { box-shadow: 0 8px 24px rgba(0,0,0,.08); }
        .contact-icon {
            width: 48px; height: 48px;
            border-radius: 12px;
            background: #e8f0fe;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.2rem;
            flex-shrink: 0;
        }
        .form-control:focus, .form-select:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 .2rem rgba(13,110,253,.15);
        }
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
<div class="container py-5">
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb small">
            <li class="breadcrumb-item"><a href="/home">Home</a></li>
            <li class="breadcrumb-item active">Contact</li>
        </ol>
    </nav>

    <div class="row g-5">
        <%-- Left: Info --%>
        <div class="col-lg-5">
            <h1 class="fw-bold mb-2">Get in touch</h1>
            <p class="text-muted mb-5">Have a question, a problem with a rental, or just want to say hello? We're here to help.</p>

            <div class="d-flex flex-column gap-3">
                <div class="contact-info-card p-4">
                    <div class="d-flex align-items-start gap-3">
                        <div class="contact-icon"><i class="bi bi-geo-alt-fill text-primary"></i></div>
                        <div>
                            <div class="fw-semibold mb-1">Our address</div>
                            <div class="text-muted small">
                                42 Greenway Boulevard, Suite 101<br>
                                Springfield, CA 94102<br>
                                United States
                            </div>
                        </div>
                    </div>
                </div>

                <div class="contact-info-card p-4">
                    <div class="d-flex align-items-start gap-3">
                        <div class="contact-icon"><i class="bi bi-envelope-fill text-primary"></i></div>
                        <div>
                            <div class="fw-semibold mb-1">Email us</div>
                            <div class="text-muted small">
                                General: <a href="mailto:hello@bikerental.example.com" class="text-primary">hello@bikerental.example.com</a><br>
                                Support: <a href="mailto:support@bikerental.example.com" class="text-primary">support@bikerental.example.com</a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="contact-info-card p-4">
                    <div class="d-flex align-items-start gap-3">
                        <div class="contact-icon"><i class="bi bi-telephone-fill text-primary"></i></div>
                        <div>
                            <div class="fw-semibold mb-1">Call us</div>
                            <div class="text-muted small">
                                Mon – Fri, 8 am – 6 pm PST<br>
                                <a href="tel:+14155550192" class="text-primary">+1 (415) 555-0192</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%-- Right: Form (UI only, no backend) --%>
        <div class="col-lg-7">
            <div class="card border-0 shadow-sm rounded-4 p-4 p-md-5">
                <h4 class="fw-bold mb-1">Send us a message</h4>
                <p class="text-muted small mb-4">We'll get back to you within one business day.</p>

                <div class="row g-3">
                    <div class="col-sm-6">
                        <label class="form-label fw-semibold small">First name</label>
                        <input type="text" class="form-control" placeholder="Alex">
                    </div>
                    <div class="col-sm-6">
                        <label class="form-label fw-semibold small">Last name</label>
                        <input type="text" class="form-control" placeholder="Johnson">
                    </div>
                    <div class="col-12">
                        <label class="form-label fw-semibold small">Email address</label>
                        <input type="email" class="form-control" placeholder="alex@example.com">
                    </div>
                    <div class="col-12">
                        <label class="form-label fw-semibold small">Subject</label>
                        <select class="form-select">
                            <option value="" disabled selected>Select a topic…</option>
                            <option>Rental issue</option>
                            <option>Billing question</option>
                            <option>Lost or damaged bike</option>
                            <option>Station feedback</option>
                            <option>Account help</option>
                            <option>Other</option>
                        </select>
                    </div>
                    <div class="col-12">
                        <label class="form-label fw-semibold small">Message</label>
                        <textarea class="form-control" rows="5" placeholder="Tell us how we can help…"></textarea>
                    </div>
                    <div class="col-12 pt-1">
                        <button type="button" class="btn btn-primary px-5 fw-semibold">
                            Send message <i class="bi bi-send ms-1"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%-- FOOTER --%>
<footer class="pt-5 pb-4 mt-5">
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