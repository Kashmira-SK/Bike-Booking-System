<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Rentals</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>My Rentals</h2>
        <a href="/rentals/rent" class="btn btn-primary">+ Rent a Bike</a>
    </div>

    <c:if test="${empty rentals}">
        <p class="text-muted">No rental history found.</p>
    </c:if>

    <c:if test="${not empty rentals}">
        <table class="table table-bordered table-hover">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Bike</th>
                    <th>Type</th>
                    <th>Start</th>
                    <th>End</th>
                    <th>Cost</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="r" items="${rentals}">
                    <tr>
                        <td>${r.id}</td>
                        <td>${r.bikeId}</td>
                        <td>${r.type}</td>
                        <td>${r.startTime}</td>
                        <td>${empty r.endTime ? '-' : r.endTime}</td>
                        <td>${r.cost == 0 ? '-' : '$'.concat(r.cost)}</td>
                        <td>
                            <span class="badge ${r.status == 'ACTIVE' ? 'bg-success' : r.status == 'COMPLETED' ? 'bg-secondary' : 'bg-danger'}">
                                ${r.status}
                            </span>
                        </td>
                        <td>
                            <c:if test="${r.status == 'ACTIVE'}">
                                <a href="/rentals/return" class="btn btn-sm btn-warning">Return</a>
                                <form action="/rentals/cancel/${r.id}" method="post" class="d-inline">
                                    <button type="submit" class="btn btn-sm btn-danger">Cancel</button>
                                </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</body>
</html>