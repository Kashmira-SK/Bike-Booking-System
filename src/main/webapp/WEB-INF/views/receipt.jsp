<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>

<div class="container py-4 d-flex justify-content-center">
    <div style="width:100%;max-width:500px">
        <div class="alert alert-success mb-4">
            <h4 class="mb-0"><i class="bi bi-check-circle-fill me-2"></i>Payment Successful!</h4>
        </div>

        <div class="card">
            <div class="card-header fw-semibold"><i class="bi bi-receipt me-2"></i>Receipt</div>
            <div class="card-body">
                <table class="table table-sm mb-0">
                    <tr><th>Payment ID</th><td>${payment.id}</td></tr>
                    <tr><th>Rental ID</th><td>${payment.rentalId}</td></tr>
                    <tr><th>Amount</th><td class="fw-bold" style="color:#74c69d;">$${payment.amount}</td></tr>
                    <tr><th>Method</th><td>${payment.paymentMethod}</td></tr>
                    <tr><th>Status</th><td>${payment.status}</td></tr>
                    <tr><th>Timestamp</th><td>${payment.timestamp}</td></tr>
                </table>
            </div>
            <div class="card-footer d-flex gap-2">
                <a href="/rentals/history" class="btn btn-green flex-grow-1">My Rentals</a>
                <a href="/payments/history" class="btn btn-outline-secondary">Payment History</a>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>