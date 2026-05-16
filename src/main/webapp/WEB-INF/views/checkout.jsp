<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>

<div class="container py-4" style="max-width:540px">
    <h2 class="fw-bold mb-4"><i class="bi bi-credit-card me-2"></i>Checkout</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <c:if test="${not empty rental}">
        <div class="card mb-4">
            <div class="card-header fw-semibold"><i class="bi bi-receipt me-2"></i>Summary</div>
            <div class="card-body">
                <table class="table table-sm mb-0">
                    <tr><th>Rental ID</th><td>${rental.id}</td></tr>
                    <tr><th>Bike</th><td>${rental.bikeId}</td></tr>
                    <tr><th>Type</th><td>${rental.rentalType}</td></tr>
                    <tr><th>Duration</th><td>${rental.startTime} → ${rental.endTime}</td></tr>
                    <tr>
                        <th>Total</th>
                        <td class="fw-bold fs-5" style="color:#74c69d;">$${rental.cost}</td>
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
                        <label class="form-check-label" for="cash"><i class="bi bi-cash me-1"></i>Cash</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="method" value="CARD" id="card">
                        <label class="form-check-label" for="card"><i class="bi bi-credit-card me-1"></i>Card</label>
                    </div>
                </div>
            </div>
            <button type="submit" class="btn btn-green w-100 btn-lg">
                <i class="bi bi-check-circle me-2"></i>Complete Payment
            </button>
        </form>
    </div>
</div>

<%@ include file="footer.jsp" %>