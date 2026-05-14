<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bike Rental System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        /* =============================================
           GLOBAL GLASSMORPHISM DESIGN SYSTEM
        ============================================= */

        body {
            min-height: 100vh;
            margin: 0;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            color: #ffffff;
            background-color: #1b4332;
            background-image: url('https://images.unsplash.com/photo-1541625602330-2277a4c46182?w=1920&q=80');
            background-attachment: fixed;
            background-size: cover;
            background-position: center;
            position: relative;
        }

        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background: rgba(10, 30, 20, 0.60);
            z-index: 0;
            pointer-events: none;
        }

        body.bg-fallback {
            background-image: linear-gradient(135deg, #1b4332 0%, #2d6a4f 50%, #40916c 100%) !important;
        }

        body > * { position: relative; z-index: 1; }

        /* --- Glass card --- */
        .glass-card {
            background: rgba(255, 255, 255, 0.10);
            border: 1px solid rgba(255, 255, 255, 0.18);
            border-radius: 16px;
            -webkit-backdrop-filter: blur(14px);
            backdrop-filter: blur(14px);
            color: #ffffff;
            transition: transform 0.2s ease, border-color 0.2s ease;
        }
        .glass-card:hover {
            transform: translateY(-3px);
            border-color: rgba(255, 255, 255, 0.30);
        }

        /* Override Bootstrap .card globally */
        .card {
            background: rgba(255, 255, 255, 0.10) !important;
            border: 1px solid rgba(255, 255, 255, 0.18) !important;
            border-radius: 16px !important;
            -webkit-backdrop-filter: blur(14px) !important;
            backdrop-filter: blur(14px) !important;
            color: #ffffff !important;
            transition: transform 0.2s ease, border-color 0.2s ease !important;
        }
        .card:hover {
            transform: translateY(-3px);
            border-color: rgba(255, 255, 255, 0.30) !important;
        }
        .card-body, .card-header, .card-footer {
            background: transparent !important;
            color: #ffffff !important;
            border-color: rgba(255, 255, 255, 0.12) !important;
        }
        .card-title, .card-text, .card-header { color: #ffffff !important; }

        /* --- Buttons --- */
        .btn-green {
            background: #52b788;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            font-weight: 500;
            transition: background 0.2s ease, transform 0.1s ease;
        }
        .btn-green:hover { background: #40916c; color: #ffffff; }
        .btn-green:active { transform: scale(0.97); }

        .btn-primary {
            background: #52b788 !important;
            border-color: #52b788 !important;
            border-radius: 8px !important;
            color: #ffffff !important;
            font-weight: 500 !important;
            transition: background 0.2s ease, transform 0.1s ease !important;
        }
        .btn-primary:hover { background: #40916c !important; border-color: #40916c !important; }
        .btn-primary:active { transform: scale(0.97) !important; }
        .btn-primary:disabled { background: #40916c !important; border-color: #40916c !important; opacity: 0.6 !important; }

        .btn-outline-primary {
            border-color: #52b788 !important;
            color: #52b788 !important;
            border-radius: 8px !important;
        }
        .btn-outline-primary:hover { background: #52b788 !important; color: #ffffff !important; }

        .btn-success {
            background: #52b788 !important;
            border-color: #52b788 !important;
            border-radius: 8px !important;
            color: #ffffff !important;
        }
        .btn-success:hover { background: #40916c !important; border-color: #40916c !important; }

        .btn-secondary {
            background: rgba(255,255,255,0.12) !important;
            border-color: rgba(255,255,255,0.20) !important;
            border-radius: 8px !important;
            color: #ffffff !important;
        }
        .btn-secondary:hover { background: rgba(255,255,255,0.20) !important; }

        .btn-outline-secondary {
            border-color: rgba(255,255,255,0.30) !important;
            color: rgba(255,255,255,0.80) !important;
            border-radius: 8px !important;
        }
        .btn-outline-secondary:hover { background: rgba(255,255,255,0.10) !important; color: #ffffff !important; }

        .btn-warning {
            background: rgba(255,193,7,0.85) !important;
            border-color: transparent !important;
            border-radius: 8px !important;
            color: #000 !important;
        }
        .btn-warning:hover { background: rgba(255,193,7,1) !important; }

        .btn-danger {
            background: rgba(220,53,69,0.85) !important;
            border-color: transparent !important;
            border-radius: 8px !important;
            color: #ffffff !important;
        }
        .btn-danger:hover { background: rgba(220,53,69,1) !important; }

        .btn-outline-danger {
            border-color: rgba(220,53,69,0.60) !important;
            color: #ff8a95 !important;
            border-radius: 8px !important;
        }
        .btn-outline-danger:hover { background: rgba(220,53,69,0.20) !important; }

        .btn-info {
            background: rgba(13,202,240,0.75) !important;
            border-color: transparent !important;
            border-radius: 8px !important;
            color: #000 !important;
        }

        /* Active/press scale for all buttons */
        .btn:active { transform: scale(0.97); }

        /* --- Tables --- */
        .table { color: #ffffff !important; }
        .table thead th,
        .table-dark thead th,
        thead.table-dark th,
        .table thead tr th {
            background: rgba(82, 183, 136, 0.25) !important;
            color: #ffffff !important;
            border-color: rgba(255, 255, 255, 0.15) !important;
            font-weight: 600;
        }
        .table-secondary thead th { background: rgba(82, 183, 136, 0.15) !important; }
        .table tbody tr { border-color: rgba(255, 255, 255, 0.10) !important; }
        .table tbody tr:hover { background: rgba(255, 255, 255, 0.07) !important; }
        .table tbody td, .table tbody th { color: #ffffff !important; border-color: rgba(255,255,255,0.08) !important; }
        .table-striped > tbody > tr:nth-of-type(odd) > * {
            background: rgba(255, 255, 255, 0.05) !important;
            color: #ffffff !important;
        }
        .table-bordered { border-color: rgba(255,255,255,0.12) !important; }
        .table-sm td, .table-sm th { color: #ffffff !important; }

        /* --- Forms --- */
        .form-control, .form-select {
            background: rgba(255, 255, 255, 0.10) !important;
            border: 1px solid rgba(255, 255, 255, 0.20) !important;
            border-radius: 8px !important;
            color: #ffffff !important;
            -webkit-backdrop-filter: blur(8px);
            backdrop-filter: blur(8px);
        }
        .form-control:focus, .form-select:focus {
            background: rgba(255, 255, 255, 0.15) !important;
            border-color: #52b788 !important;
            box-shadow: 0 0 0 0.2rem rgba(82, 183, 136, 0.25) !important;
            color: #ffffff !important;
        }
        .form-control::placeholder { color: rgba(255, 255, 255, 0.40) !important; }
        .form-select option { background: #1b4332; color: #ffffff; }
        .form-label { color: rgba(255, 255, 255, 0.85); font-weight: 500; }
        .form-check-label { color: rgba(255,255,255,0.80); }
        .form-check-input { background-color: rgba(255,255,255,0.15) !important; border-color: rgba(255,255,255,0.30) !important; }
        .form-check-input:checked { background-color: #52b788 !important; border-color: #52b788 !important; }
        .form-control:disabled, .form-control[readonly] {
            background: rgba(255,255,255,0.06) !important;
            color: rgba(255,255,255,0.50) !important;
        }

        /* --- Badges --- */
        .badge.bg-success { background: #d8f3dc !important; color: #1b4332 !important; }
        .badge.bg-secondary { background: rgba(255,255,255,0.18) !important; color: #ffffff !important; }
        .badge.bg-warning { background: rgba(255,193,7,0.85) !important; color: #000 !important; }
        .badge.bg-danger { background: rgba(220,53,69,0.85) !important; color: #ffffff !important; }
        .badge.bg-info { background: rgba(13,202,240,0.75) !important; color: #000 !important; }
        .badge.bg-primary { background: rgba(82,183,136,0.85) !important; color: #ffffff !important; }

        /* --- Alerts --- */
        .alert { -webkit-backdrop-filter: blur(10px); backdrop-filter: blur(10px); border-radius: 10px !important; }
        .alert-success { background: rgba(216,243,220,0.12) !important; border-color: rgba(82,183,136,0.40) !important; color: #d8f3dc !important; }
        .alert-danger  { background: rgba(220,53,69,0.12) !important;  border-color: rgba(220,53,69,0.35) !important;  color: #ffb3bb !important; }
        .alert-warning { background: rgba(255,193,7,0.10) !important;  border-color: rgba(255,193,7,0.30) !important;  color: #ffe69c !important; }
        .alert-info    { background: rgba(13,202,240,0.10) !important; border-color: rgba(13,202,240,0.30) !important; color: #cff4fc !important; }

        /* --- Misc --- */
        .text-muted { color: rgba(255, 255, 255, 0.60) !important; }
        .text-success { color: #52b788 !important; }
        .text-primary { color: #52b788 !important; }
        .text-dark { color: #ffffff !important; }
        .border-bottom { border-color: rgba(255,255,255,0.12) !important; }
        .border-top { border-color: rgba(255,255,255,0.12) !important; }
        .breadcrumb-item a { color: #52b788; }
        .breadcrumb-item.active { color: rgba(255,255,255,0.60); }
        .breadcrumb-item + .breadcrumb-item::before { color: rgba(255,255,255,0.30); }
        hr { border-color: rgba(255,255,255,0.12) !important; }
        a { color: #52b788; }
        a:hover { color: #74c69d; }

        /* --- Modal --- */
        .modal-content {
            background: rgba(15,35,22,0.92) !important;
            border: 1px solid rgba(255,255,255,0.18) !important;
            -webkit-backdrop-filter: blur(16px);
            backdrop-filter: blur(16px);
            border-radius: 16px !important;
            color: #ffffff !important;
        }
        .modal-header { border-bottom-color: rgba(255,255,255,0.12) !important; }
        .modal-footer { border-top-color: rgba(255,255,255,0.12) !important; }
        .btn-close { filter: invert(1) !important; }
        .modal-title { color: #ffffff !important; }

        /* --- Dropdown --- */
        .dropdown-menu {
            background: rgba(10,25,15,0.92) !important;
            border: 1px solid rgba(255,255,255,0.15) !important;
            -webkit-backdrop-filter: blur(14px);
            backdrop-filter: blur(14px);
            border-radius: 10px !important;
        }
        .dropdown-item { color: rgba(255,255,255,0.85) !important; }
        .dropdown-item:hover { background: rgba(82,183,136,0.20) !important; color: #ffffff !important; }

        /* --- Pagination --- */
        .page-link { background: rgba(255,255,255,0.08) !important; border-color: rgba(255,255,255,0.15) !important; color: #d8f3dc !important; }
        .page-link:hover { background: rgba(82,183,136,0.25) !important; color: #ffffff !important; }
        .page-item.active .page-link { background: #52b788 !important; border-color: #52b788 !important; color: #ffffff !important; }

        /* --- Page fade-in --- */
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(10px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        .container, .container-fluid { animation: fadeInUp 0.4s ease both; }

        /* --- Navbar --- */
        .navbar-glass {
            background: rgba(10, 25, 15, 0.75) !important;
            border-bottom: 1px solid rgba(255,255,255,0.10);
            -webkit-backdrop-filter: blur(12px);
            backdrop-filter: blur(12px);
            transition: background 0.3s ease;
        }
        .navbar-glass.scrolled { background: rgba(10, 25, 15, 0.92) !important; }
        .navbar-brand { color: #d8f3dc !important; font-weight: 700; font-size: 1.3rem; }
        .navbar-brand:hover { color: #52b788 !important; }
        .navbar-glass .nav-link {
            color: rgba(255,255,255,0.85) !important;
            font-weight: 500;
            padding-left: 1rem !important;
            padding-right: 1rem !important;
            position: relative;
            transition: color 0.2s ease;
        }
        .navbar-glass .nav-link::after {
            content: '';
            position: absolute;
            bottom: 2px; left: 1rem; right: 1rem;
            height: 2px;
            background: #52b788;
            width: 0;
            transition: width 0.25s ease;
            border-radius: 2px;
        }
        .navbar-glass .nav-link:hover { color: #ffffff !important; }
        .navbar-glass .nav-link:hover::after,
        .navbar-glass .nav-link.active::after { width: calc(100% - 2rem); }
        .navbar-glass .nav-link.active { color: #52b788 !important; }
        .navbar-toggler { border-color: rgba(255,255,255,0.25) !important; }
        .navbar-toggler-icon { filter: invert(1); }

        /* --- Scrollbar --- */
        ::-webkit-scrollbar { width: 7px; }
        ::-webkit-scrollbar-track { background: rgba(0,0,0,0.15); }
        ::-webkit-scrollbar-thumb { background: #40916c; border-radius: 4px; }
        ::-webkit-scrollbar-thumb:hover { background: #52b788; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-glass fixed-top" id="mainNavbar">
    <div class="container-fluid px-4">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-bicycle me-2"></i>BikeRental
        </a>
        <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse" data-bs-target="#navbarMain"
                aria-controls="navbarMain" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarMain">
            <ul class="navbar-nav ms-auto align-items-lg-center gap-lg-1">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home">
                        <i class="bi bi-house me-1"></i>Home
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/bikes">
                        <i class="bi bi-bicycle me-1"></i>Bikes
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/stations">
                        <i class="bi bi-geo-alt me-1"></i>Stations
                    </a>
                </li>
                <c:choose>
                    <c:when test="${not empty sessionScope.loggedInUser}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/rentals/my">
                                <i class="bi bi-calendar-check me-1"></i>My Rentals
                            </a>
                        </li>
                        <c:if test="${sessionScope.loggedInUser.role == 'ADMIN'}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button"
                                   data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="bi bi-gear me-1"></i>Admin
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/users">
                                        <i class="bi bi-people me-2"></i>Manage Users</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/bikes">
                                        <i class="bi bi-bicycle me-2"></i>Manage Bikes</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/rentals">
                                        <i class="bi bi-calendar3 me-2"></i>Manage Rentals</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/stations">
                                        <i class="bi bi-geo-alt me-2"></i>Manage Stations</a></li>
                                    <li><hr class="dropdown-divider" style="border-color:rgba(255,255,255,0.12)"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin">
                                        <i class="bi bi-speedometer2 me-2"></i>Dashboard</a></li>
                                </ul>
                            </li>
                        </c:if>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/profile">
                                <i class="bi bi-person-circle me-1"></i>${sessionScope.loggedInUser.name}
                            </a>
                        </li>
                        <li class="nav-item ms-lg-2">
                            <a class="btn btn-green px-3" href="${pageContext.request.contextPath}/logout">
                                <i class="bi bi-box-arrow-right me-1"></i>Logout
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item ms-lg-2">
                            <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                <i class="bi bi-box-arrow-in-right me-1"></i>Login
                            </a>
                        </li>
                        <li class="nav-item ms-lg-1">
                            <a class="btn btn-green px-3" href="${pageContext.request.contextPath}/register">
                                <i class="bi bi-person-plus me-1"></i>Register
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<div style="height: 72px;"></div>

<script>
    (function () {
        var nav = document.getElementById('mainNavbar');
        window.addEventListener('scroll', function () {
            nav.classList.toggle('scrolled', window.scrollY > 40);
        }, { passive: true });
    })();
    (function () {
        var img = new Image();
        img.onerror = function () { document.body.classList.add('bg-fallback'); };
        img.src = 'https://images.unsplash.com/photo-1541625602330-2277a4c46182?w=1920&q=80';
    })();
</script>