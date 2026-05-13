<%@ include file="navbar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container">
    <div class="row align-items-center py-5 mb-4" style="background: linear-gradient(135deg, #1a1a2e, #16213e); border-radius: 16px;">
        <div class="col-md-7 text-white px-5">
            <h1 class="display-5 fw-bold">Rent a bike.<br>Go anywhere.</h1>
            <p class="lead text-secondary mt-3">Affordable, easy bike rentals across the city. Hourly or daily — your call.</p>
            <div class="mt-4">
                <a href="/bikes" class="btn btn-success btn-lg me-2">Browse Bikes</a>
                <a href="/register" class="btn btn-outline-light btn-lg">Get Started</a>
            </div>
        </div>
        <div class="col-md-5 text-center" style="font-size: 8rem;">🚲</div>
    </div>

    <div class="row g-4 mb-5">
        <div class="col-md-4">
            <div class="card h-100 text-center p-4">
                <div style="font-size: 2.5rem;">📍</div>
                <h5 class="mt-3 fw-bold">Find a Station</h5>
                <p class="text-muted">Locate pickup and drop-off stations near you.</p>
                <a href="/stations" class="btn btn-outline-success mt-auto">View Stations</a>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card h-100 text-center p-4">
                <div style="font-size: 2.5rem;">🔑</div>
                <h5 class="mt-3 fw-bold">Rent a Bike</h5>
                <p class="text-muted">Hourly or daily rentals. Pick up and go.</p>
                <a href="/rentals/rent" class="btn btn-outline-success mt-auto">Rent Now</a>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card h-100 text-center p-4">
                <div style="font-size: 2.5rem;">⭐</div>
                <h5 class="mt-3 fw-bold">Leave a Review</h5>
                <p class="text-muted">Share your experience with the community.</p>
                <a href="/reviews/submit" class="btn btn-outline-success mt-auto">Write a Review</a>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.js"></script>
</body>
</html>