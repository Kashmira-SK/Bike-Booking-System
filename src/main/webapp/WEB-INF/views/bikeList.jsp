<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bikes</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>All Bikes</h2>
        <a href="/bikes/add" class="btn btn-primary">+ Add Bike</a>
    </div>

    <c:if test="${empty bikes}">
        <p class="text-muted">No bikes found.</p>
    </c:if>

    <c:if test="${not empty bikes}">
        <table class="table table-bordered table-hover">
            <thead class="table-dark">
                <tr>
                    <th>Model</th>
                    <th>Type</th>
                    <th>Price/Hour</th>
                    <th>Station</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="b" items="${bikes}">
                    <tr>
                        <td>${b.model}</td>
                        <td>${b.bikeType}</td>
                        <td>$${b.pricePerHour}</td>
                        <td>${b.stationId}</td>
                        <td>
                            <span class="badge ${b.status == 'AVAILABLE' ? 'bg-success' : b.status == 'RENTED' ? 'bg-warning text-dark' : 'bg-secondary'}">
                                ${b.status}
                            </span>
                        </td>
                        <td>
                            <a href="/bikes/edit/${b.id}" class="btn btn-sm btn-info">Edit</a>
                            <form action="/bikes/delete/${b.id}" method="post" class="d-inline"
                                  onsubmit="return confirm('Delete this bike?')">
                                <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</body>
</html>