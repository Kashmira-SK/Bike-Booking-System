<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>

<style>
    .avatar-ring {
        width: 80px; height: 80px; border-radius: 50%;
        display: flex; align-items: center; justify-content: center;
        font-size: 2.2rem;
        background: linear-gradient(135deg, #52b788 0%, #40916c 100%);
        color: #fff; flex-shrink: 0;
    }
    .role-badge-lg { font-size: 0.75rem; letter-spacing: .04em; padding: .35em .7em; border-radius: 999px; }
    .seller-cta   { border: 2px dashed rgba(255,193,7,0.60) !important; background: rgba(255,193,7,0.06) !important; }
    .seller-active { border: 2px solid rgba(82,183,136,0.60) !important; background: rgba(82,183,136,0.08) !important; }
    .admin-card   { border: 2px solid rgba(255,193,7,0.50) !important; background: rgba(255,193,7,0.06) !important; }
    .icon-circle {
        width: 42px; height: 42px; border-radius: 50%;
        display: flex; align-items: center; justify-content: center;
        flex-shrink: 0; font-size: 1.1rem;
    }
    .ic-green  { background: rgba(82,183,136,0.20); color: #74c69d; }
    .ic-yellow { background: rgba(255,193,7,0.20);  color: #ffe69c; }
    .ic-red    { background: rgba(220,53,69,0.20);  color: #ff8a95; }
    .ic-teal   { background: rgba(13,202,240,0.20); color: #a5f3fc; }
    .info-row th { font-weight: 400; color: rgba(255,255,255,0.60); width: 38%; padding: .75rem 1.25rem; }
    .info-row td { padding: .75rem 1rem; font-weight: 500; }
    .info-row tr { border-color: rgba(255,255,255,0.08) !important; }
</style>

<c:set var="user" value="${sessionScope.loggedInUser}" />
<c:set var="role" value="${sessionScope.loggedInUser.role}" />
<c:set var="ctx"  value="${pageContext.request.contextPath}" />

<div class="container py-4">

    <%-- Profile header --%>
    <div class="card mb-4">
        <div class="card-body p-4">
            <div class="d-flex align-items-center gap-4 flex-wrap">
                <div class="avatar-ring"><i class="bi bi-person-fill"></i></div>
                <div>
                    <h2 class="mb-1 fw-bold"><c:out value="${user.name}" /></h2>
                    <span class="role-badge-lg badge
                        ${role == 'ADMIN'  ? 'bg-warning' :
                          role == 'SELLER' ? 'bg-success' : 'bg-secondary'}">
                        <c:out value="${role}" />
                    </span>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-4">

        <%-- Account info table --%>
        <div class="col-lg-7">
            <div class="card h-100">
                <div class="card-header fw-semibold">
                    <i class="bi bi-person-vcard me-2"></i>Account Information
                </div>
                <div class="card-body p-0">
                    <table class="table mb-0 info-row">
                        <tbody>
                            <tr>
                                <th><i class="bi bi-person me-2"></i>Full Name</th>
                                <td><c:out value="${user.name}" /></td>
                            </tr>
                            <tr>
                                <th><i class="bi bi-envelope me-2"></i>Email</th>
                                <td><c:out value="${user.email}" /></td>
                            </tr>
                            <tr>
                                <th><i class="bi bi-telephone me-2"></i>Phone</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty user.phone}"><c:out value="${user.phone}" /></c:when>
                                        <c:otherwise><span class="text-muted fst-italic">Not provided</span></c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <th><i class="bi bi-shield-check me-2"></i>Role</th>
                                <td>
                                    <span class="badge role-badge-lg
                                        ${role == 'ADMIN'  ? 'bg-warning' :
                                          role == 'SELLER' ? 'bg-success' : 'bg-secondary'}">
                                        <c:out value="${role}" />
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <th><i class="bi bi-activity me-2"></i>Status</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.status == 'ACTIVE' or empty user.status}">
                                            <span class="badge bg-success">
                                                <i class="bi bi-circle-fill me-1" style="font-size:.45rem;"></i>Active
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger">
                                                <i class="bi bi-circle-fill me-1" style="font-size:.45rem;"></i>
                                                <c:out value="${user.status}" />
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <%-- Role card --%>
        <div class="col-lg-5 d-flex flex-column gap-4">
            <c:if test="${role == 'REGULAR'}">
                <div class="card seller-cta">
                    <div class="card-body p-4 text-center">
                        <i class="bi bi-shop fs-1 mb-3" style="color:rgba(255,193,7,0.85);display:block;"></i>
                        <h5 class="fw-bold mb-2">Want to list your bikes?</h5>
                        <p class="text-muted mb-4" style="font-size:.92rem;">Upgrade to a Seller account and start earning by sharing your bikes with the community.</p>
                        <a href="${ctx}/seller/register" class="btn btn-warning fw-semibold px-4">
                            <i class="bi bi-arrow-up-circle me-2"></i>Become a Seller
                        </a>
                    </div>
                </div>
            </c:if>
            <c:if test="${role == 'SELLER'}">
                <div class="card seller-active">
                    <div class="card-body p-4 text-center">
                        <i class="bi bi-patch-check-fill fs-1 mb-3" style="color:#52b788;display:block;"></i>
                        <h5 class="fw-bold mb-1">You're a verified Seller</h5>
                        <p class="text-muted mb-4" style="font-size:.92rem;">Your seller account is active. Manage your listed bikes and track your earnings below.</p>
                        <a href="${ctx}/bikes/my" class="btn btn-green fw-semibold px-4">
                            <i class="bi bi-list-check me-2"></i>Manage My Bikes
                        </a>
                    </div>
                </div>
            </c:if>
            <c:if test="${role == 'ADMIN'}">
                <div class="card admin-card">
                    <div class="card-body p-4 text-center">
                        <i class="bi bi-shield-lock-fill fs-1 mb-3" style="color:rgba(255,193,7,0.85);display:block;"></i>
                        <h5 class="fw-bold mb-1">Administrator Account</h5>
                        <p class="text-muted mb-4" style="font-size:.92rem;">You have full administrative access to the platform, including user management and station control.</p>
                        <a href="${ctx}/admin/users" class="btn btn-warning fw-semibold px-4">
                            <i class="bi bi-people me-2"></i>Admin Panel
                        </a>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <%-- Quick links --%>
    <div class="mt-4">
        <p class="text-muted small text-uppercase fw-semibold mb-3" style="letter-spacing:.08em;font-size:.73rem;">Quick Access</p>
        <div class="row g-3">
            <div class="col-sm-6 col-md-4">
                <a href="${ctx}/rentals/my" class="card text-decoration-none">
                    <div class="card-body d-flex align-items-center gap-3 p-3">
                        <div class="icon-circle ic-green"><i class="bi bi-clock-history"></i></div>
                        <div>
                            <div class="fw-semibold">My Rentals</div>
                            <div class="text-muted" style="font-size:.82rem;">View rental history</div>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-sm-6 col-md-4">
                <a href="${ctx}/payments/my" class="card text-decoration-none">
                    <div class="card-body d-flex align-items-center gap-3 p-3">
                        <div class="icon-circle ic-green"><i class="bi bi-credit-card"></i></div>
                        <div>
                            <div class="fw-semibold">My Payments</div>
                            <div class="text-muted" style="font-size:.82rem;">Billing &amp; invoices</div>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-sm-6 col-md-4">
                <a href="${ctx}/reviews/my" class="card text-decoration-none">
                    <div class="card-body d-flex align-items-center gap-3 p-3">
                        <div class="icon-circle ic-yellow"><i class="bi bi-star"></i></div>
                        <div>
                            <div class="fw-semibold">My Reviews</div>
                            <div class="text-muted" style="font-size:.82rem;">Ratings you've left</div>
                        </div>
                    </div>
                </a>
            </div>
            <c:if test="${role == 'SELLER' or role == 'ADMIN'}">
                <div class="col-sm-6 col-md-4">
                    <a href="${ctx}/bikes/my" class="card text-decoration-none">
                        <div class="card-body d-flex align-items-center gap-3 p-3">
                            <div class="icon-circle ic-teal"><i class="bi bi-bicycle"></i></div>
                            <div>
                                <div class="fw-semibold">My Bikes</div>
                                <div class="text-muted" style="font-size:.82rem;">Manage your listings</div>
                            </div>
                        </div>
                    </a>
                </div>
            </c:if>
            <c:if test="${role == 'ADMIN'}">
                <div class="col-sm-6 col-md-4">
                    <a href="${ctx}/admin/users" class="card text-decoration-none">
                        <div class="card-body d-flex align-items-center gap-3 p-3">
                            <div class="icon-circle ic-red"><i class="bi bi-shield-lock"></i></div>
                            <div>
                                <div class="fw-semibold">Admin Panel</div>
                                <div class="text-muted" style="font-size:.82rem;">Users &amp; system</div>
                            </div>
                        </div>
                    </a>
                </div>
            </c:if>
        </div>
    </div>

</div>

<%@ include file="footer.jsp" %>