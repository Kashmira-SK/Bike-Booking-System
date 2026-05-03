<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Bike</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="mb-4">Add a Bike</h2>

    <% if(request.getAttribute("success") != null) { %>
        <div class="alert alert-success">${success}</div>
    <% } %>
    <% if(request.getAttribute("error") != null) { %>
        <div class="alert alert-danger">${error}</div>
    <% } %>

    <div class="card p-4 shadow-sm">
        <form action="/bikes/add" method="post">
            <div class="mb-3">
                <label class="form-label">Bike ID</label>
                <input type="text" class="form-control" name="bikeId" required placeholder="e.g. B001">
            </div>
            <div class="mb-3">
                <label class="form-label">Model</label>
                <input type="text" class="form-control" name="model" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Price Per Hour (Rs.)</label>
                <input type="number" class="form-control" name="pricePerHour" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Station ID</label>
                <input type="text" class="form-control" name="stationId" required placeholder="e.g. S001">
            </div>
            <div class="mb-3">
                <label class="form-label">Type</label>
                <select class="form-select" name="type">
                    <option value="ELECTRIC">Electric</option>
                    <option value="MANUAL">Manual</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Add Bike</button>
        </form>
    </div>
</div>
</body>
</html>