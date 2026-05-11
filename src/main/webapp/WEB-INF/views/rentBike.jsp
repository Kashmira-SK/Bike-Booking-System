<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Rent a Bike</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4" style="max-width: 520px;">
    <h2>Rent a Bike</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="/rentals/rent" method="post">
        <div class="mb-3">
            <label class="form-label">Bike ID</label>
            <input type="text" name="bikeId" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Start Station ID</label>
            <input type="text" name="startStation" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">End Station ID</label>
            <input type="text" name="endStation" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Rental Type</label>
            <select name="type" class="form-select">
                <option value="HOURLY">Hourly</option>
                <option value="DAILY">Daily</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Rent Now</button>
        <a href="/bikes" class="btn btn-secondary ms-2">Browse Bikes</a>
    </form>
</body>
</html>