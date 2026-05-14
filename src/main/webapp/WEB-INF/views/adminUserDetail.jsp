<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Detail</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<%@ include file="navbar.jsp" %>
<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>User Detail</h2>
        <a href="/admin/users" class="btn btn-outline-secondary btn-sm">← Back to Users</a>
    </div>

    <div class="card mb-4">
        <div class="card-header bg-dark text-white">User Info</div>
        <div class="card-body">
            <p><strong>ID:</strong> ${user.id}</p>
            <p><strong>Name:</strong> ${user.name}</p>
            <p><strong>Email:</strong> ${user.email}</p>
            <p><strong>Phone:</strong> ${user.phone}</p>
            <p><strong>Role:</strong> ${user.role}</p>
            <p class="mb-0"><strong>Status:</strong> ${user.status}</p>
        </div>
    </div>

    <h4 class="mb-3">Rental History</h4>
    <div class="table-responsive mb-4">
        <table class="table table-bordered bg-white">
            <thead class="table-secondary">
                <tr>
                    <th>Rental ID</th>
                    <th>Bike ID</th>
                    <th>Type</th>
                    <th>Status</th>
                    <th>Cost</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="r" items="${rentals}">
                    <tr>
                        <td>${r.id}</td>
                        <td>${r.bikeId}</td>
                        <td>${r.rentalType}</td>
                        <td>${r.status}</td>
                        <td>$${r.cost}</td>
                        <td>${r.startTime}</td>
                        <td>${r.endTime}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty rentals}">
                    <tr><td colspan="7" class="text-center text-muted">No rentals found.</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <h4 class="mb-3">Payment History</h4>
    <div class="table-responsive">
        <table class="table table-bordered bg-white">
            <thead class="table-secondary">
                <tr>
                    <th>Payment ID</th>
                    <th>Rental ID</th>
                    <th>Amount</th>
                    <th>Method</th>
                    <th>Status</th>
                    <th>Timestamp</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="p" items="${payments}">
                    <tr>
                        <td>${p.id}</td>
                        <td>${p.rentalId}</td>
                        <td>$${p.amount}</td>
                        <td>${p.method}</td>
                        <td>${p.status}</td>
                        <td>${p.timestamp}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty payments}">
                    <tr><td colspan="6" class="text-center text-muted">No payments found.</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>