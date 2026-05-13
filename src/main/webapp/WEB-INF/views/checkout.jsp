<%@ include file="navbar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container" style="max-width: 520px;">
    <div class="page-header">
        <h2><i class="bi bi-credit-card"></i> Checkout</h2>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <c:if test="${not empty rental}">
        <div class="card mb-4">
            <div class="card-header bg-dark text-white">Summary</div>
            <div class="card-body">
                <table class="table table-sm mb-0">
                    <tr><th>Rental ID</th><td>${rental.id}</td></tr>
                    <tr><th>Bike</th><td>${rental.bikeId}</td></tr>
                    <tr><th>Type</th><td>${rental.type}</td></tr>
                    <tr><th>Duration</th><td>${rental.startTime} → ${rental.endTime}</td></tr>
                    <tr>
                        <th>Total</th>
                        <td class="fw-bold text-success fs-5">$${rental.cost}</td>
                    </tr>
                </table>
            </div>
        </div>
    </c:if>

    <div class="card p-4">
        <form action="/payments/checkout" method="post">
            <input type="hidden" name="rentalId" value="${rentalId}">
            <div class="mb-4">
                <label class="form-label fw-semibold">Payment Method</label>
                <div class="d-flex gap-3">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="method" value="CASH" id="cash" checked>
                        <label class="form-check-label" for="cash"><i class="bi bi-cash"></i> Cash</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="method" value="CARD" id="card">
                        <label class="form-check-label" for="card"><i class="bi bi-credit-card"></i> Card</label>
                    </div>
                </div>
            </div>
            <button type="submit" class="btn btn-success w-100 btn-lg">
                <i class="bi bi-check-circle"></i> Complete Payment
            </button>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body></html>