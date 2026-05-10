<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Bike</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">
    <h2>Edit Bike</h2>

    <form action="/bikes/edit/${bike.id}" method="post">
        <div class="mb-3">
            <label class="form-label">Model Name</label>
            <input type="text" name="model" class="form-control" value="${bike.model}" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Price Per Hour ($)</label>
            <input type="number" name="pricePerHour" class="form-control" step="0.01" value="${bike.pricePerHour}" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Station ID</label>
            <input type="text" name="stationId" class="form-control" value="${bike.stationId}" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Status</label>
            <select name="status" class="form-select">
                <option value="AVAILABLE" ${bike.status == 'AVAILABLE' ? 'selected' : ''}>Available</option>
                <option value="RENTED"    ${bike.status == 'RENTED'    ? 'selected' : ''}>Rented</option>
                <option value="MAINTENANCE" ${bike.status == 'MAINTENANCE' ? 'selected' : ''}>Maintenance</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Save Changes</button>
        <a href="/bikes" class="btn btn-secondary ms-2">Cancel</a>
    </form>
</body>
</html>