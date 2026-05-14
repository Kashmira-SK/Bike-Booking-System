<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>

<div class="container py-4" style="max-width:620px">
    <h2 class="fw-bold mb-4">${station.name}</h2>

    <div class="card">
        <div class="card-body">
            <table class="table table-sm mb-0">
                <tr><th>ID</th><td>${station.id}</td></tr>
                <tr><th>Address</th><td>${station.address}</td></tr>
                <tr><th>City</th><td>${station.city}</td></tr>
                <tr><th>Type</th><td>${station.stationType}</td></tr>
                <tr><th>Capacity</th><td>${station.capacity}</td></tr>
                <tr><th>Current Bikes</th><td>${station.bikeCount}</td></tr>
            </table>
        </div>
        <div class="card-footer">
            <a href="/stations" class="btn btn-outline-secondary">← Back to List</a>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>