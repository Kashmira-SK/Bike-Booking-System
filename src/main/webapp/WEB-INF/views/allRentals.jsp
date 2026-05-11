<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Rentals</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">
    <h2 class="mb-3">All Rentals</h2>

    <c:if test="${empty rentals}">
        <p class="text-muted">No rentals found.</p>
    </c:if>

    <c:if test="${not empty rentals}">
        <table class="table table-bordered table-hover">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>User</th>
                    <th>Bike</th>
                    <th>Type</th>
                    <th>Start Station</th>
                    <th>End Station</th>
                    <th>Start Time</th>
                    <th>Cost</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="r" items="${rentals}">
                    <tr>
                        <td>${r.id}</td>
                        <td>${r.userId}</td>
                        <td>${r.bikeId}</td>
                        <td>${r.type}</td>
                        <td>${r.startStation}</td>
                        <td>${r.endStation}</td>
                        <td>${r.startTime}</td>
                        <td>${r.cost == 0 ? '-' : '$'.concat(r.cost)}</td>
                        <td>
                            <span class="badge ${r.status == 'ACTIVE' ? 'bg-success' : r.status == 'COMPLETED' ? 'bg-secondary' : 'bg-danger'}">
                                ${r.status}
                            </span>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</body>
</html>