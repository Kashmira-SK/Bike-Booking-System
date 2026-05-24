<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Stations</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>All Stations</h2>
        <a href="/stations/add" class="btn btn-primary">+ Add Station</a>
    </div>

    <c:if test="${empty stations}">
        <p class="text-muted">No stations found.</p>
    </c:if>

    <c:if test="${not empty stations}">
        <table class="table table-bordered table-hover">
            <thead class="table-dark">
                <tr>
                    <th>Name</th>
                    <th>City</th>
                    <th>Address</th>
                    <th>Type</th>
                    <th>Bikes</th>
                    <th>Capacity</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="s" items="${stations}">
                    <tr>
                        <td>${s.name}</td>
                        <td>${s.city}</td>
                        <td>${s.address}</td>
                        <td>${s.stationType}</td>
                        <td>${s.bikeCount}</td>
                        <td>${s.capacity}</td>
                        <td>
                            <a href="/stations/${s.id}" class="btn btn-sm btn-info">View</a>
                            <form action="/stations/delete/${s.id}" method="post" class="d-inline"
                                  onsubmit="return confirm('Delete this station?')">
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