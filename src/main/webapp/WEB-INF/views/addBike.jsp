<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Bike</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">
    <h2>Add Bike</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="/bikes/add" method="post">
        <div class="mb-3">
            <label class="form-label">Type</label>
            <select name="type" class="form-select" required>
                <option value="MOUNTAIN">Mountain Bike</option>
                <option value="ROAD">Road Bike</option>
                <option value="ELECTRIC">Electric Bike</option>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label">Model Name</label>
            <input type="text" name="model" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Price Per Hour ($)</label>
            <input type="number" name="pricePerHour" class="form-control" step="0.01" min="0" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Station ID</label>
            <input type="text" name="stationId" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary">Add Bike</button>
        <a href="/bikes" class="btn btn-secondary ms-2">Cancel</a>
    </form>
</body>
</html>