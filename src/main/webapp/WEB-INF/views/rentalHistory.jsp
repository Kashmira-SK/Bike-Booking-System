<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold mb-0"><i class="bi bi-clock-history me-2"></i>My Rentals</h2>
        <a href="/rentals/rent" class="btn btn-green"><i class="bi bi-key me-1"></i>Rent a Bike</a>
    </div>

    <c:if test="${empty rentals}">
        <div class="card p-5 text-center">
            <p class="text-muted mb-3">You haven't rented any bikes yet.</p>
            <a href="/bikes" class="btn btn-green">Browse Bikes</a>
        </div>
    </c:if>

    <div class="row g-3">
        <c:forEach var="r" items="${rentals}">
            <div class="col-12">
                <div class="card">
                    <div class="card-body d-flex justify-content-between align-items-center flex-wrap gap-3">
                        <div>
                            <c:choose>
                                <c:when test="${r.status eq 'ACTIVE'}">
                                    <span class="badge bg-success mb-1">ACTIVE</span>
                                </c:when>
                                <c:if test="${r.status eq 'ACTIVE'}">
                                    <a href="/rentals/return?rentalId=${r.id}" class="btn btn-warning btn-sm">
                                        <i class="bi bi-arrow-return-left me-1"></i>Return
                                    </a>
                                    <form action="/rentals/cancel/${r.id}" method="post"
                                          onsubmit="return confirm('Cancel this rental?')">
                                        <button type="submit" class="btn btn-outline-danger btn-sm">Cancel</button>
                                    </form>
                                </c:if>
                                <c:if test="${r.status eq 'COMPLETED' and not paidRentalIds.contains(r.id) and not pendingRentalIds.contains(r.id)}">

                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<%@ include file="footer.jsp" %>