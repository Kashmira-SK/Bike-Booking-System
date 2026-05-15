
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4" style="max-width: 480px;">
    <h2>Checkout</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="/payments/checkout" method="post">
        <div class="mb-3">
            <label class="form-label">Rental ID</label>
            <input type="text" name="rentalId" class="form-control"
                   value="${not empty rentalId ? rentalId : ''}" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Payment Method</label>
            <select name="method" class="form-select">
                <option value="CASH">Cash</option>
                <option value="CARD">Card</option>
            </select>
        </div>
        <button type="submit" class="btn btn-success">Pay Now</button>
        <a href="/rentals/history" class="btn btn-secondary ms-2">Cancel</a>
    </form>
</body>
</html>
