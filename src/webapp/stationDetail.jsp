<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Station Detail</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">
    <h2>${station.name}</h2>
    <table class="table table-bordered w-50">
        <tr><th>ID</th><td>${station.id}</td></tr>
        <tr><th>Address</th><td>${station.address}</td></tr>
        <tr><th>City</th><td>${station.city}</td></tr>
        <tr><th>Type</th><td>${station.stationType}</td></tr>
        <tr><th>Capacity</th><td>${station.capacity}</td></tr>
        <tr><th>Current Bikes</th><td>${station.bikeCount}</td></tr>
    </table>
    <a href="/stations" class="btn btn-secondary">Back to List</a>
</body>
</html>