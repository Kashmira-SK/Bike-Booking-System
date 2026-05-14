<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Return a Bike</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4" style="max-width: 500px;">
    <h2>Return a Bike</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <c:if test="${not empty cost}">
        <div class="alert alert-success">
            Bike returned successfully! Total cost: <strong>$${cost}</strong>
        </div>
    </c:if>

    <form action="/rentals/return" method="post">
        <div class="mb-3">
            <label class="form-label">Rental ID</label>
            <input type="text" name="rentalId" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-warning">Return Bike</button>
        <a href="/rentals/history" class="btn btn-secondary ms-2">My Rentals</a>
    </form>
</body>
</html>