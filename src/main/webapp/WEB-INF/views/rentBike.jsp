<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Rent a Bike</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="mb-4">Rent a Bike</h2>

    <% if(request.getAttribute("success") != null) { %>
        <div class="alert alert-success">${success}</div>
    <% } %>
    <% if(request.getAttribute("error") != null) { %>
        <div class="alert alert-danger">${error}</div>
    <% } %>

    <div class="card p-4 shadow-sm">
        <form action="/rent" method="post">
            <div class="mb-3">
                <label class="form-label">User ID</label>
                <input type="text" class="form-control" name="userId" required placeholder="e.g. U001">
            </div>
            <div class="mb-3">
                <label class="form-label">Bike ID</label>
                <input type="text" class="form-control" name="bikeId" required placeholder="e.g. B001">
            </div>
            <div class="mb-3">
                <label class="form-label">Pickup Station ID</label>
                <input type="text" class="form-control" name="stationId" required placeholder="e.g. S001">
            </div>
            <div class="mb-3">
                <label class="form-label">Rental Type</label>
                <select class="form-select" name="type">
                    <option value="HOURLY">Hourly (Rs. 150/hr)</option>
                    <option value="DAILY">Daily (Rs. 800/day)</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Rent Bike</button>
            <a href="/rentals" class="btn btn-outline-secondary ms-2">View All Rentals</a>
        </form>
    </div>
</div>
</body>
</html>