<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Rentals</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<%@ include file="navbar.jsp" %>
<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Manage Rentals</h2>
        <a href="/admin" class="btn btn-outline-secondary btn-sm">← Dashboard</a>
    </div>
    <div class="table-responsive">
        <table class="table table-bordered table-hover bg-white align-middle">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>User ID</th>
                    <th>Bike ID</th>
                    <th>Type</th>
                    <th>Status</th>
                    <th>Cost</th>
                    <th>Start Time</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="r" items="${rentals}">
                    <tr>
                        <td>${r.id}</td>
                        <td>${r.userId}</td>
                        <td>${r.bikeId}</td>
                        <td>${r.rentalType}</td>
                        <td>
                            <c:choose>
                                <c:when test="${r.status == 'ACTIVE'}">
                                    <span class="badge bg-success">ACTIVE</span>
                                </c:when>
                                <c:when test="${r.status == 'CANCELLED'}">
                                    <span class="badge bg-danger">CANCELLED</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary">${r.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>$${r.cost}</td>
                        <td>${r.startTime}</td>
                        <td>
                            <c:if test="${r.status == 'ACTIVE'}">
                                <form action="/admin/rentals/cancel/${r.id}" method="post" class="d-inline">
                                    <button type="submit" class="btn btn-warning btn-sm">Cancel</button>
                                </form>
                            </c:if>
                            <form action="/admin/rentals/delete/${r.id}" method="post" class="d-inline ms-1"
                                  onsubmit="return confirm('Delete rental ${r.id}?')">
                                <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty rentals}">
                    <tr><td colspan="8" class="text-center text-muted">No rentals found.</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>