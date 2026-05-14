<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fn"  uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BikeRental — Rent a Bike, Explore Freely</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <style>
        :root { --br-dark: #0d1117; --br-dark2: #1a2332; }

        /* Navbar */
        .navbar-brand { letter-spacing: -.3px; }

        /* Hero */
        .hero-section {
            min-height: 92vh;
            background: linear-gradient(135deg, var(--br-dark) 0%, var(--br-dark2) 55%, #0f1923 100%);
            position: relative;
            display: flex;
            align-items: center;
        }
        .hero-section::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(ellipse at 72% 50%, rgba(13,110,253,.18) 0%, transparent 68%);
            pointer-events: none;
        }
        .hero-tagline {
            font-size: .75rem;
            font-weight: 700;
            letter-spacing: .14em;
            text-transform: uppercase;
            color: #6ea8fe;
        }
        .hero-title { font-weight: 800; letter-spacing: -1.5px; }
        .hero-stat-val { font-size: 1.4rem; font-weight: 800; color: #fff; }
        .hero-stat-lbl { font-size: .78rem; color: #6c757d; }

        /* Section label */
        .section-label {
            font-size: .73rem;
            font-weight: 700;
            letter-spacing: .14em;
            text-transform: uppercase;
            color: #0d6efd;
        }

        /* How it works */
        .how-icon {
            width: 60px; height: 60px; border-radius: 50%;
            background: #e8f0fe;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.45rem; margin: 0 auto 1rem;
        }
        .how-card {
            border: 1px solid #e9ecef; border-radius: 18px;
            transition: transform .2s, box-shadow .2s;
        }
        .how-card:hover { transform: translateY(-5px); box-shadow: 0 14px 36px rgba(0,0,0,.09); }

        /* Bike cards */
        .bike-card {
            border: 1px solid #e9ecef; border-radius: 18px; overflow: hidden;
            transition: transform .2s, box-shadow .2s;
        }
        .bike-card:hover { transform: translateY(-5px); box-shadow: 0 14px 36px rgba(0,0,0,.09); }
        .bike-emoji { font-size: 2.8rem; line-height: 1; }

        /* Review cards */
        .review-card { border: 1px solid #e9ecef; border-radius: 18px; }

        /* Pricing */
        .pricing-card { border-radius: 22px; border: 2px solid #e9ecef; }
        .pricing-card.featured { border-color: #0d6efd; }

        /* Footer */
        footer { background: var(--br-dark); }
        footer a { color: #8d99a6; text-decoration: none; transition: color .15s; }
        footer a:hover { color: #fff; }
        .footer-brand { font-size: 1.25rem; font-weight: 800; color: #fff; letter-spacing: -.3px; }
        .footer-hdg { font-size: .78rem; font-weight: 700; letter-spacing: .1em; text-transform: uppercase; color: #6c757d; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark sticky-top" style="background: var(--br-dark); border-bottom: 1px solid #1e2a38;">
    <div class="container">
        <a class="navbar-brand fw-bold" href="/home">🚲 BikeRental</a>
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="mainNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link active" href="/home">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="/bikes">Bikes</a></li>
                <li class="nav-item"><a class="nav-link" href="/stations">Stations</a></li>
                <li class="nav-item"><a class="nav-link" href="/reviews">Reviews</a></li>
            </ul>
            <div class="d-flex align-items-center gap-2">
                <c:choose>
                    <c:when test="${not empty sessionScope.loggedInUser}">
                        <span class="text-secondary small me-1">Hi, <span class="text-white fw-semibold">${sessionScope.loggedInUser.name}</span></span>
                        <a href="/profile" class="btn btn-outline-light btn-sm">Profile</a>
                        <a href="/logout" class="btn btn-outline-danger btn-sm">Logout</a>
                    </c:when>
                    <c:otherwise>
                        <a href="/login"    class="btn btn-outline-light btn-sm">Login</a>
                        <a href="/register" class="btn btn-primary    btn-sm">Register</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<section class="hero-section">
    <div class="container position-relative">
        <div class="row align-items-center">
            <div class="col-lg-7">
                <span class="hero-tagline mb-3 d-inline-block">City · Mountain · Electric</span>
                <h1 class="display-3 text-white hero-title mb-3">
                    Rent a bike.<br>Explore freely.
                </h1>
                <p class="text-secondary mb-4" style="font-size:1.15rem; max-width:480px;">
                    Hourly and daily rentals. Pick up at any station.
                </p>
                <div class="d-flex flex-wrap gap-3 mb-5">
                    <a href="/bikes" class="btn btn-primary btn-lg px-4 fw-semibold">Browse Bikes</a>
                    <c:choose>
                        <c:when test="${not empty sessionScope.loggedInUser}">
                            <a href="/rentals/rent" class="btn btn-outline-light btn-lg px-4">Rent Now</a>
                        </c:when>
                        <c:otherwise>
                            <a href="/register" class="btn btn-outline-light btn-lg px-4">Get Started</a>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="d-flex gap-5">
                    <div><div class="hero-stat-val">500+</div><div class="hero-stat-lbl">Bikes</div></div>
                    <div><div class="hero-stat-val">30+</div><div class="hero-stat-lbl">Stations</div></div>
                    <div><div class="hero-stat-val">10k+</div><div class="hero-stat-lbl">Happy riders</div></div>
                </div>
            </div>
            <div class="col-lg-5 d-none d-lg-flex justify-content-center">
                <div style="font-size:8.5rem; filter:drop-shadow(0 0 48px rgba(13,110,253,.45));">🚲</div>
            </div>
        </div>
    </div>
</section>

<section class="py-6" style="padding:5rem 0; background:#f8f9fa;">
    <div class="container">
        <div class="text-center mb-5">
            <span class="section-label d-block mb-2">Simple process</span>
            <h2 class="fw-bold" style="font-size:2.2rem;">How it works</h2>
        </div>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card how-card h-100 text-center p-4">
                    <div class="card-body">
                        <div class="how-icon"><i class="bi bi-search text-primary"></i></div>
                        <span class="badge bg-primary bg-opacity-10 text-primary mb-3 px-3">Step 1</span>
                        <h5 class="fw-bold mb-2">Find a bike</h5>
                        <p class="text-muted mb-0 small">Browse the full fleet — city, mountain, and electric. Filter by type, price, and nearest station.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card how-card h-100 text-center p-4">
                    <div class="card-body">
                        <div class="how-icon"><i class="bi bi-geo-alt text-primary"></i></div>
                        <span class="badge bg-primary bg-opacity-10 text-primary mb-3 px-3">Step 2</span>
                        <h5 class="fw-bold mb-2">Pick up at a station</h5>
                        <p class="text-muted mb-0 small">Choose your pickup location from 30+ stations across the city. Unlock instantly with your account.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card how-card h-100 text-center p-4">
                    <div class="card-body">
                        <div class="how-icon"><i class="bi bi-arrow-repeat text-primary"></i></div>
                        <span class="badge bg-primary bg-opacity-10 text-primary mb-3 px-3">Step 3</span>
                        <h5 class="fw-bold mb-2">Ride and return</h5>
                        <p class="text-muted mb-0 small">Enjoy your ride, then drop off at any station when you're done. No need to return to the original spot.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section style="padding:5rem 0;">
    <div class="container">
        <div class="d-flex justify-content-between align-items-end mb-5">
            <div>
                <span class="section-label d-block mb-2">Our fleet</span>
                <h2 class="fw-bold mb-0" style="font-size:2.2rem;">Featured bikes</h2>
            </div>
            <a href="/bikes" class="btn btn-outline-primary">View all →</a>
        </div>
        <div class="row g-4">
            <c:choose>
                <c:when test="${not empty featuredBikes}">
                    <c:forEach var="bike" items="${featuredBikes}">
                        <div class="col-sm-6 col-lg-3">
                            <div class="card bike-card h-100">
                                <div class="card-body d-flex flex-column p-4">
                                    <div class="mb-3">
                                        <c:set var="bt" value="${fn:toUpperCase(bike.type)}"/>
                                        <c:choose>
                                            <c:when test="${bt == 'MOUNTAIN'}"><span class="bike-emoji">🚵</span></c:when>
                                            <c:when test="${bt == 'ROAD'}"><span class="bike-emoji">🚴</span></c:when>
                                            <c:when test="${bt == 'ELECTRIC'}"><span class="bike-emoji">⚡</span></c:when>
                                            <c:otherwise><span class="bike-emoji">🚲</span></c:otherwise>
                                        </c:choose>
                                    </div>
                                    <span class="badge bg-secondary bg-opacity-10 text-secondary text-capitalize mb-2 align-self-start">${bike.type}</span>
                                    <h6 class="fw-bold mb-1">${bike.model}</h6>
                                    <p class="text-muted small flex-grow-1 mb-3">${bike.description}</p>
                                    <div class="d-flex justify-content-between align-items-center pt-3 border-top">
                                        <div>
                                            <span class="fw-bold text-primary fs-5">$<fmt:formatNumber value="${bike.pricePerHour}" pattern="#,##0.00"/></span>
                                            <span class="text-muted small">/hr</span>
                                        </div>
                                        <a href="/rentals/rent?bikeId=${bike.id}" class="btn btn-primary btn-sm">Rent This</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12 text-center py-5 text-muted">
                        <div class="fs-1 mb-3">🚲</div>
                        <p>No bikes available right now. Check back soon!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</section>

<section style="padding:5rem 0; background:#f8f9fa;">
    <div class="container">
        <div class="text-center mb-5">
            <span class="section-label d-block mb-2">What riders say</span>
            <h2 class="fw-bold" style="font-size:2.2rem;">Recent reviews</h2>
        </div>
        <div class="row g-4">
            <c:choose>
                <c:when test="${not empty recentReviews}">
                    <c:forEach var="review" items="${recentReviews}">
                        <div class="col-md-4">
                            <div class="card review-card h-100 p-4">
                                <div class="card-body d-flex flex-column">
                                    <div class="mb-3">
                                        <c:forEach begin="1" end="${review.rating}" var="s">⭐</c:forEach>
                                    </div>
                                    <p class="flex-grow-1 mb-3" style="font-size:.95rem; line-height:1.6;">"${review.comment}"</p>
                                    <div class="text-muted small">
                                        <i class="bi bi-clock me-1"></i>${review.timestamp}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12 text-center py-5 text-muted">
                        <div class="fs-1 mb-3">⭐</div>
                        <p class="mb-3">No reviews yet. Be the first to ride and share your experience!</p>
                        <a href="/bikes" class="btn btn-outline-primary">Browse bikes</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="text-center mt-5">
            <a href="/reviews" class="btn btn-outline-secondary">Read all reviews</a>
        </div>
    </div>
</section>

<section style="padding:5rem 0;">
    <div class="container">
        <div class="text-center mb-5">
            <span class="section-label d-block mb-2">Simple pricing</span>
            <h2 class="fw-bold" style="font-size:2.2rem;">Hourly or daily — your call</h2>
            <p class="text-muted">No hidden fees. Pay only for what you use.</p>
        </div>
        <div class="row g-4 justify-content-center">
            <%-- Hourly --%>
            <div class="col-md-5">
                <div class="card pricing-card h-100 p-4">
                    <div class="card-body">
                        <div class="text-center mb-4">
                            <div class="fs-2 mb-2">⏱️</div>
                            <h4 class="fw-bold">Hourly</h4>
                            <div class="my-3" style="font-size:2.4rem; font-weight:800;">From $3<span class="fs-6 text-muted fw-normal">/hr</span></div>
                            <p class="text-muted small">Best for short trips and errands</p>
                        </div>
                        <ul class="list-unstyled mb-4">
                            <li class="py-2 border-bottom"><i class="bi bi-check-circle-fill text-success me-2"></i>Flexible — pay only for time used</li>
                            <li class="py-2 border-bottom"><i class="bi bi-check-circle-fill text-success me-2"></i>Billed per hour, rounded up</li>
                            <li class="py-2 border-bottom"><i class="bi bi-check-circle-fill text-success me-2"></i>Helmet included</li>
                            <li class="py-2 text-muted"><i class="bi bi-x-circle me-2"></i>Lock not included</li>
                        </ul>
                        <a href="/bikes" class="btn btn-outline-primary w-100 fw-semibold">Get started</a>
                    </div>
                </div>
            </div>
            <%-- Daily --%>
            <div class="col-md-5">
                <div class="card pricing-card featured h-100 p-4 position-relative">
                    <div class="position-absolute top-0 start-50 translate-middle">
                        <span class="badge bg-primary px-3 py-2 rounded-pill">Best value</span>
                    </div>
                    <div class="card-body">
                        <div class="text-center mb-4">
                            <div class="fs-2 mb-2">📅</div>
                            <h4 class="fw-bold">Daily</h4>
                            <div class="my-3" style="font-size:2.4rem; font-weight:800;">From $18<span class="fs-6 text-muted fw-normal">/day</span></div>
                            <p class="text-muted small">Best for full-day adventures</p>
                        </div>
                        <ul class="list-unstyled mb-4">
                            <li class="py-2 border-bottom"><i class="bi bi-check-circle-fill text-success me-2"></i>8-hour flat day rate</li>
                            <li class="py-2 border-bottom"><i class="bi bi-check-circle-fill text-success me-2"></i>No hourly surprises</li>
                            <li class="py-2 border-bottom"><i class="bi bi-check-circle-fill text-success me-2"></i>Helmet included</li>
                            <li class="py-2"><i class="bi bi-check-circle-fill text-success me-2"></i>Lock included</li>
                        </ul>
                        <a href="/bikes" class="btn btn-primary w-100 fw-semibold">Get started</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

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