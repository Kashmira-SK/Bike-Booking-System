<%@ include file="navbar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container" style="max-width: 520px;">
    <div class="page-header">
        <h2><i class="bi bi-arrow-return-left"></i> Return Bike</h2>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <c:if test="${not empty rental}">
        <div class="card mb-4">
            <div class="card-header bg-dark text-white">Rental Details</div>
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
                        <i class="bi bi-arrow-return-left"></i> Confirm Return
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
                    <label class="form-label fw-semibold">Rental ID</label>
                    <input type="text" name="rentalId" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-warning w-100">Return Bike</button>
            </form>
        </div>
    </c:if>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body></html>