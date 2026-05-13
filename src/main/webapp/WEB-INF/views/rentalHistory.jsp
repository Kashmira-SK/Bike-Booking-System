<%@ include file="navbar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container">
    <div class="page-header d-flex justify-content-between align-items-center">
        <h2><i class="bi bi-clock-history"></i> My Rentals</h2>
        <a href="/rentals/rent" class="btn btn-primary"><i class="bi bi-key"></i> Rent a Bike</a>
    </div>

    <c:if test="${empty rentals}">
        <div class="card p-5 text-center">
            <p class="text-muted mb-3">You haven't rented any bikes yet.</p>
            <a href="/bikes" class="btn btn-primary">Browse Bikes</a>
        </div>
    </c:if>

    <div class="row g-3">
        <c:forEach var="r" items="${rentals}">
            <div class="col-12">
                <div class="card">
                    <div class="card-body d-flex justify-content-between align-items-center flex-wrap gap-3">
                        <div>
                            <span class="badge ${r.status == 'ACTIVE' ? 'bg-success' : r.status == 'COMPLETED' ? 'bg-secondary' : 'bg-danger'} mb-1">
                                ${r.status}
                            </span>
                            <h6 class="mb-1">Bike: ${r.bikeId}</h6>
                            <small class="text-muted">
                                <i class="bi bi-calendar"></i> ${r.startTime}
                                <c:if test="${not empty r.endTime}"> → ${r.endTime}</c:if>
                            </small><br>
                            <small class="text-muted">
                                <i class="bi bi-geo"></i> ${r.startStation} → ${r.endStation}
                                &nbsp;|&nbsp; ${r.type}
                            </small>
                        </div>
                        <div class="text-end">
                            <c:if test="${r.cost > 0}">
                                <div class="fw-bold text-success fs-5">$${r.cost}</div>
                            </c:if>
                            <div class="d-flex gap-2 mt-2">
                                <c:if test="${r.status == 'ACTIVE'}">
                                    <a href="/rentals/return?rentalId=${r.id}" class="btn btn-warning btn-sm">
                                        <i class="bi bi-arrow-return-left"></i> Return
                                    </a>
                                    <form action="/rentals/cancel/${r.id}" method="post"
                                          onsubmit="return confirm('Cancel this rental?')">
                                        <button type="submit" class="btn btn-outline-danger btn-sm">Cancel</button>
                                    </form>
                                </c:if>
                                <c:if test="${r.status == 'COMPLETED'}">
                                    <a href="/payments/checkout?rentalId=${r.id}" class="btn btn-primary btn-sm">
                                        <i class="bi bi-credit-card"></i> Pay Now
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body></html>