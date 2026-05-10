<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment History</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">
    <h2 class="mb-3">Payment History</h2>

    <c:if test="${empty payments}">
        <p class="text-muted">No payments found.</p>
    </c:if>

    <c:if test="${not empty payments}">
        <table class="table table-bordered table-hover">
            <thead class="table-dark">
                <tr>
                    <th>Payment ID</th>
                    <th>Rental ID</th>
                    <th>Amount</th>
                    <th>Method</th>
                    <th>Status</th>
                    <th>Date</th>
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
    </c:if>
</body>
</html>