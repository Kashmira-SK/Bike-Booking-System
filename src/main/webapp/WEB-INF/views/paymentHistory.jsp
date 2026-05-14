<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>

<div class="container py-4">
    <h2 class="fw-bold mb-4">Payment History</h2>

    <c:if test="${empty payments}">
        <div class="card p-4 text-center text-muted">No payments found.</div>
    </c:if>

    <c:if test="${not empty payments}">
        <div class="card">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Payment ID</th><th>Rental ID</th><th>Amount</th>
                                <th>Method</th><th>Status</th><th>Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${payments}">
                                <tr>
                                    <td>${p.id}</td>
                                    <td>${p.rentalId}</td>
                                    <td>$${p.amount}</td>
                                    <td>${p.paymentMethod}</td>
                                    <td>
                                        <span class="badge ${p.status == 'COMPLETED' ? 'bg-success' : 'bg-danger'}">
                                            ${p.status}
                                        </span>
                                    </td>
                                    <td>${p.timestamp}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </c:if>
</div>

<%@ include file="footer.jsp" %>