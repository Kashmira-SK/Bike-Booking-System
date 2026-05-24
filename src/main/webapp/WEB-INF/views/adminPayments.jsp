<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold mb-0">Pending Payments</h2>
        <a href="/admin" class="btn btn-outline-secondary btn-sm">← Dashboard</a>
    </div>
    <div class="card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th>ID</th><th>Rental ID</th><th>User ID</th>
                            <th>Amount</th><th>Method</th><th>Timestamp</th><th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${pendingPayments}">
                            <tr>
                                <td>${p.id}</td>
                                <td>${p.rentalId}</td>
                                <td>${p.userId}</td>
                                <td class="fw-bold" style="color:#74c69d;">$${p.amount}</td>
                                <td><span class="badge bg-secondary">${p.method}</span></td>
                                <td>${p.timestamp}</td>
                                <td>
                                    <form action="/admin/payments/approve/${p.id}" method="post" class="d-inline">
                                        <button type="submit" class="btn btn-green btn-sm">Approve</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty pendingPayments}">
                            <tr><td colspan="7" class="text-center text-muted py-4">No pending payments.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>