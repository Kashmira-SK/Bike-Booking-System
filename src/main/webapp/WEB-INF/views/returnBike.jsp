<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>

<div class="container py-4" style="max-width:540px">
    <h2 class="fw-bold mb-4"><i class="bi bi-arrow-return-left me-2"></i>Return Bike</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <c:if test="${not empty rental}">
        <div class="card mb-4">
            <div class="card-header fw-semibold"><i class="bi bi-info-circle me-2"></i>Rental Details</div>
            <div class="card-body">
                <table class="table table-sm mb-0">
                    <tr><th>Rental ID</th><td>${rental.id}</td></tr>
                    <tr><th>Bike</th><td>${rental.bikeId}</td></tr>
                    <tr><th>Type</th><td>${rental.type}</td></tr>
                    <tr><th>Started</th><td>${rental.startTime}</td></tr>
                </table>
            </div>
        </div>
        <div class="card p-4">
            <p class="text-muted mb-3">Returning this bike will calculate your final cost and take you to checkout.</p>
            <form action="/rentals/return" method="post">
                <input type="hidden" name="rentalId" value="${rental.id}">
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-warning flex-grow-1">
                        <i class="bi bi-arrow-return-left me-1"></i>Confirm Return
                    </button>
                    <a href="/rentals/history" class="btn btn-outline-secondary">Back</a>
                </div>
            </form>
        </div>
    </c:if>

    <c:if test="${empty rental}">
        <div class="card p-4">
            <form action="/rentals/return" method="post">
                <div class="mb-3">
                    <label class="form-label">Rental ID</label>
                    <input type="text" name="rentalId" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-warning w-100">Return Bike</button>
            </form>
        </div>
    </c:if>
</div>

<%@ include file="footer.jsp" %>