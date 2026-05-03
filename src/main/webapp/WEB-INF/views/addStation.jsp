<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Station</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="mb-4">Add a Station</h2>

    <% if(request.getAttribute("success") != null) { %>
        <div class="alert alert-success">${success}</div>
    <% } %>
    <% if(request.getAttribute("error") != null) { %>
        <div class="alert alert-danger">${error}</div>
    <% } %>

    <div class="card p-4 shadow-sm">
        <form action="/stations/add" method="post">
            <div class="mb-3">
                <label class="form-label">Station ID</label>
                <input type="text" class="form-control" name="stationId" required placeholder="e.g. S001">
            </div>
            <div class="mb-3">
                <label class="form-label">Name</label>
                <input type="text" class="form-control" name="name" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Address</label>
                <input type="text" class="form-control" name="address" required>
            </div>
            <div class="mb-3">
                <label class="form-label">City</label>
                <input type="text" class="form-control" name="city" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Capacity</label>
                <input type="number" class="form-control" name="capacity" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Type</label>
                <select class="form-select" name="type">
                    <option value="MAIN">Main Station</option>
                    <option value="SATELLITE">Satellite Station</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Add Station</button>
        </form>
    </div>
</div>
</body>
</html>