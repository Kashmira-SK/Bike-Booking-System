<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="navbar.jsp" %>

<div class="container py-4">
    <h2 class="fw-bold mb-4">Admin Dashboard</h2>

    <div class="row g-4">
        <div class="col-md-4">
            <div class="card h-100">
                <div class="card-body">
                    <p class="text-muted small mb-1"><i class="bi bi-people me-1"></i>Total Users</p>
                    <p class="display-6 fw-bold mb-3">${totalUsers}</p>
                    <a href="/admin/users" class="btn btn-green btn-sm">Manage →</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card h-100">
                <div class="card-body">
                    <p class="text-muted small mb-1"><i class="bi bi-bicycle me-1"></i>Total Bikes</p>
                    <p class="display-6 fw-bold mb-3">${totalBikes}</p>
                    <a href="/bikes" class="btn btn-green btn-sm">Browse →</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card h-100">
                <div class="card-body">
                    <p class="text-muted small mb-1"><i class="bi bi-calendar3 me-1"></i>Total Rentals</p>
                    <p class="display-6 fw-bold mb-3">${totalRentals}</p>
                    <a href="/admin/rentals" class="btn btn-green btn-sm">Manage →</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card h-100">
                <div class="card-body">
                    <p class="text-muted small mb-1"><i class="bi bi-activity me-1"></i>Active Rentals</p>
                    <p class="display-6 fw-bold mb-3">${activeRentals}</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card h-100">
                <div class="card-body">
                    <p class="text-muted small mb-1"><i class="bi bi-cash-stack me-1"></i>Total Revenue</p>
                    <p class="display-6 fw-bold mb-3">
                        $<fmt:formatNumber value="${totalRevenue}" maxFractionDigits="2" minFractionDigits="2"/>
                    </p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card h-100">
                <div class="card-body">
                    <p class="text-muted small mb-1"><i class="bi bi-geo-alt me-1"></i>Stations</p>
                    <p class="display-6 fw-bold mb-3">—</p>
                    <a href="/admin/stations" class="btn btn-green btn-sm">Manage →</a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>