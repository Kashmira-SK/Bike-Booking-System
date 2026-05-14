<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Receipt</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4" style="max-width: 480px;">
    <div class="alert alert-success">
        <h4>Payment Successful!</h4>
    </div>

    <table class="table table-bordered">
        <tr><th>Payment ID</th><td>${payment.id}</td></tr>
        <tr><th>Rental ID</th><td>${payment.rentalId}</td></tr>
        <tr><th>Amount</th><td>$${payment.amount}</td></tr>
        <tr><th>Method</th><td>${payment.paymentMethod}</td></tr>
        <tr><th>Status</th><td>${payment.status}</td></tr>
        <tr><th>Timestamp</th><td>${payment.timestamp}</td></tr>
    </table>

    <a href="/rentals/history" class="btn btn-primary">My Rentals</a>
    <a href="/payments/history" class="btn btn-secondary ms-2">Payment History</a>
</body>
</html>