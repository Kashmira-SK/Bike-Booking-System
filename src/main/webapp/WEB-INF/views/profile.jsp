<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>My Profile</h2>
        <a href="/logout" class="btn btn-outline-danger">Logout</a>
    </div>

    <table class="table table-bordered w-50">
        <tr><th>Name</th><td>${user.name}</td></tr>
        <tr><th>Email</th><td>${user.email}</td></tr>
        <tr><th>Phone</th><td>${user.phone}</td></tr>
        <tr><th>Role</th><td>${user.userRole}</td></tr>
        <tr><th>Status</th><td>${user.status}</td></tr>
    </table>

    <div class="mt-3">
        <a href="/rentals/history" class="btn btn-outline-primary me-2">My Rentals</a>
        <a href="/bikes" class="btn btn-outline-secondary me-2">Browse Bikes</a>
        <a href="/stations" class="btn btn-outline-secondary">Stations</a>
    </div>
</body>
</html>
