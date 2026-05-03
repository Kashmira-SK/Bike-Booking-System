<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="mb-4">Payment Checkout</h2>

    <% if(request.getAttribute("success") != null) { %>
        <div class="alert alert-success">${success}</div>
    <% } %>
    <% if(request.getAttribute("error") != null) { %>
        <div class="alert alert-danger">${error}</div>
    <% } %>

    <div class="card p-4 shadow-sm">
        <form action="/payments/add" method="post">
            <div class="mb-3">
                <label class="form-label">Payment ID</label>
                <input type="text" class="form-control" name="paymentId" required placeholder="e.g. P001">
            </div>
            <div class="mb-3">
                <label class="form-label">Rental ID</label>
                <input type="text" class="form-control" name="rentalId" required placeholder="e.g. R001">
            </div>
            <div class="mb-3">
                <label class="form-label">User ID</label>
                <input type="text" class="form-control" name="userId" required placeholder="e.g. U001">
            </div>
            <div class="mb-3">
                <label class="form-label">Amount (Rs.)</label>
                <input type="number" class="form-control" name="amount" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Payment Method</label>
                <select class="form-select" name="method">
                    <option value="CASH">Cash</option>
                    <option value="CARD">Card</option>
                </select>
            </div>
            <button type="submit" class="btn btn-success">Pay Now</button>
        </form>
    </div>
</div>
</body>
</html>