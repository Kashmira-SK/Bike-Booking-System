<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- ─────────────────────────────────────────────────────────────────────────
     navbar.jsp  —  role-aware navigation bar
     Include with:  <%@ include file="navbar.jsp" %>

     Roles (AppConstants):
       REGULAR  → public links + rental/payment links + "Become a Seller" in profile
       SELLER   → everything REGULAR has + My Bikes
       ADMIN    → everything SELLER has + Admin dropdown + "Admin" badge

     Flash messages (session-scoped, auto-cleared after one display):
       session.setAttribute("flashError",   "…")  → red banner
       session.setAttribute("flashSuccess", "…")  → green banner
     ──────────────────────────────────────────────────────────────────────── --%>

<%-- ── Convenience aliases ─────────────────────────────────────────────── --%>
<c:set var="user"   value="${sessionScope.loggedInUser}" />
<c:set var="role"   value="${sessionScope.loggedInUser.role}" />
<c:set var="isAuth" value="${not empty sessionScope.loggedInUser}" />
<c:set var="ctx"    value="${pageContext.request.contextPath}" />
<c:set var="uri"    value="${pageContext.request.requestURI}" />

<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container-fluid px-3">

        <%-- ── Brand ──────────────────────────────────────────────────────── --%>
        <a class="navbar-brand fw-bold text-warning d-flex align-items-center gap-2"
           href="${ctx}/home">
            <i class="bi bi-bicycle fs-5"></i>
            <span>BikeRental</span>
        </a>

        <%-- ── Hamburger toggler ───────────────────────────────────────────── --%>
        <button class="navbar-toggler border-secondary" type="button"
                data-bs-toggle="collapse" data-bs-target="#mainNavbar"
                aria-controls="mainNavbar" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="mainNavbar">

            <%-- ══════════════════════════════════════════════════════════════
                 LEFT — public links + role-gated links
                 ══════════════════════════════════════════════════════════════ --%>
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                <%-- Home --%>
                <li class="nav-item">
                    <a class="nav-link ${fn:containsIgnoreCase(uri, '/home') ? 'active' : ''}"
                       href="${ctx}/home">
                        <i class="bi bi-house-door me-1"></i>Home
                    </a>
                </li>

                <%-- Bikes --%>
                <li class="nav-item">
                    <a class="nav-link ${fn:containsIgnoreCase(uri, '/bikes') and not fn:containsIgnoreCase(uri, '/bikes/my') and not fn:containsIgnoreCase(uri, '/bikes/add') ? 'active' : ''}"
                       href="${ctx}/bikes">
                        <i class="bi bi-bicycle me-1"></i>Bikes
                    </a>
                </li>

                <%-- Stations --%>
                <li class="nav-item">
                    <a class="nav-link ${fn:containsIgnoreCase(uri, '/stations') and not fn:containsIgnoreCase(uri, '/stations/add') and not fn:containsIgnoreCase(uri, '/stations/manage') ? 'active' : ''}"
                       href="${ctx}/stations">
                        <i class="bi bi-geo-alt me-1"></i>Stations
                    </a>
                </li>

                <%-- Reviews --%>
                <li class="nav-item">
                    <a class="nav-link ${fn:containsIgnoreCase(uri, '/reviews') ? 'active' : ''}"
                       href="${ctx}/reviews">
                        <i class="bi bi-star me-1"></i>Reviews
                    </a>
                </li>

                <%-- ── REGULAR / SELLER / ADMIN ─────────────────────────── --%>
                <c:if test="${isAuth}">

                    <li class="nav-item">
                        <a class="nav-link ${fn:containsIgnoreCase(uri, '/rentals/rent') ? 'active' : ''}"
                           href="${ctx}/rentals/rent">
                            <i class="bi bi-unlock me-1"></i>Rent a Bike
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link ${fn:containsIgnoreCase(uri, '/rentals/my') ? 'active' : ''}"
                           href="${ctx}/rentals/my">
                            <i class="bi bi-clock-history me-1"></i>My Rentals
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link ${fn:containsIgnoreCase(uri, '/payments/my') ? 'active' : ''}"
                           href="${ctx}/payments/my">
                            <i class="bi bi-credit-card me-1"></i>My Payments
                        </a>
                    </li>

                </c:if>

                <%-- ── SELLER + ADMIN: My Bikes ──────────────────────────── --%>
                <c:if test="${isAuth and (role == 'SELLER' or role == 'ADMIN')}">
                    <li class="nav-item">
                        <a class="nav-link ${fn:containsIgnoreCase(uri, '/bikes/my') ? 'active' : ''}"
                           href="${ctx}/bikes/my">
                            <i class="bi bi-list-check me-1"></i>My Bikes
                        </a>
                    </li>
                </c:if>

                <%-- ── ADMIN: Admin dropdown ─────────────────────────────── --%>
                <c:if test="${isAuth and role == 'ADMIN'}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-warning
                                  ${fn:containsIgnoreCase(uri, '/admin/') or fn:containsIgnoreCase(uri, '/stations/manage') ? 'active' : ''}"
                           href="#" id="adminDropdown" role="button"
                           data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-shield-lock me-1"></i>Admin
                        </a>
                        <ul class="dropdown-menu dropdown-menu-dark"
                            aria-labelledby="adminDropdown">
                            <li>
                                <a class="dropdown-item
                                          ${fn:containsIgnoreCase(uri, '/admin/users') ? 'active' : ''}"
                                   href="${ctx}/admin/users">
                                    <i class="bi bi-people me-2"></i>All Users
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item
                                          ${fn:containsIgnoreCase(uri, '/admin/rentals') ? 'active' : ''}"
                                   href="${ctx}/admin/rentals">
                                    <i class="bi bi-receipt me-2"></i>All Rentals
                                </a>
                            </li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <a class="dropdown-item
                                          ${fn:containsIgnoreCase(uri, '/stations/manage') ? 'active' : ''}"
                                   href="${ctx}/stations/manage">
                                    <i class="bi bi-building me-2"></i>Manage Stations
                                </a>
                            </li>
                        </ul>
                    </li>
                </c:if>

            </ul><%-- /left nav --%>

            <%-- ══════════════════════════════════════════════════════════════
                 RIGHT — auth controls
                 ══════════════════════════════════════════════════════════════ --%>
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-lg-center gap-1">

                <%-- ── Not logged in: Login + Register ───────────────────── --%>
                <c:if test="${not isAuth}">
                    <li class="nav-item">
                        <a class="btn btn-outline-light btn-sm px-3"
                           href="${ctx}/login">
                            <i class="bi bi-box-arrow-in-right me-1"></i>Login
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-warning btn-sm px-3"
                           href="${ctx}/register">
                            <i class="bi bi-person-plus me-1"></i>Register
                        </a>
                    </li>
                </c:if>

                <%-- ── Logged in: Profile dropdown ────────────────────────── --%>
                <c:if test="${isAuth}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle d-flex align-items-center gap-2
                                  ${fn:containsIgnoreCase(uri, '/profile') ? 'active' : ''}"
                           href="#" id="profileDropdown" role="button"
                           data-bs-toggle="dropdown" aria-expanded="false">

                            <i class="bi bi-person-circle fs-5"></i>
                            <span class="d-none d-sm-inline"><c:out value="${user.name}" /></span>

                            <%-- ADMIN gets a visible badge next to their name --%>
                            <c:if test="${role == 'ADMIN'}">
                                <span class="badge bg-warning text-dark"
                                      style="font-size:0.6rem;letter-spacing:.03em;">ADMIN</span>
                            </c:if>

                        </a>

                        <ul class="dropdown-menu dropdown-menu-dark dropdown-menu-end shadow"
                            aria-labelledby="profileDropdown">

                            <%-- Mini identity header --%>
                            <li class="px-3 py-2 text-muted" style="font-size:0.78rem;">
                                Signed in as
                                <strong class="text-light"><c:out value="${user.name}" /></strong>
                                <br>
                                <span class="badge mt-1
                                    ${role == 'ADMIN'  ? 'bg-warning text-dark' :
                                      role == 'SELLER' ? 'bg-success' : 'bg-secondary'}">
                                    <c:out value="${role}" />
                                </span>
                            </li>
                            <li><hr class="dropdown-divider my-1"></li>

                            <li>
                                <a class="dropdown-item" href="${ctx}/profile">
                                    <i class="bi bi-person me-2"></i>My Profile
                                </a>
                            </li>

                            <%-- "Become a Seller" only for REGULAR — hidden for SELLER and ADMIN --%>
                            <c:if test="${role == 'REGULAR'}">
                                <li>
                                    <a class="dropdown-item text-warning fw-semibold"
                                       href="${ctx}/seller/register">
                                        <i class="bi bi-shop me-2"></i>Become a Seller
                                    </a>
                                </li>
                            </c:if>

                            <li><hr class="dropdown-divider my-1"></li>
                            <li>
                                <a class="dropdown-item text-danger" href="${ctx}/logout">
                                    <i class="bi bi-box-arrow-right me-2"></i>Logout
                                </a>
                            </li>

                        </ul>
                    </li>
                </c:if>

            </ul><%-- /right nav --%>

        </div><%-- /collapse --%>
    </div><%-- /container-fluid --%>
</nav>

<%-- ── Flash error (red) — session-scoped, consumed after first render ──────── --%>
<c:if test="${not empty sessionScope.flashError}">
    <div class="alert alert-danger alert-dismissible fade show mb-0 rounded-0 border-0"
         role="alert" id="flashErrorBanner">
        <div class="container-fluid">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>
            <c:out value="${sessionScope.flashError}" />
            <button type="button" class="btn-close" data-bs-dismiss="alert"
                    aria-label="Dismiss"></button>
        </div>
    </div>
    <c:remove var="flashError" scope="session" />
</c:if>

<%-- ── Flash success (green) ────────────────────────────────────────────────── --%>
<c:if test="${not empty sessionScope.flashSuccess}">
    <div class="alert alert-success alert-dismissible fade show mb-0 rounded-0 border-0"
         role="alert" id="flashSuccessBanner">
        <div class="container-fluid">
            <i class="bi bi-check-circle-fill me-2"></i>
            <c:out value="${sessionScope.flashSuccess}" />
            <button type="button" class="btn-close" data-bs-dismiss="alert"
                    aria-label="Dismiss"></button>
        </div>
    </div>
    <c:remove var="flashSuccess" scope="session" />
</c:if>