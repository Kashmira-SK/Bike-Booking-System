<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Submit Review</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="mb-4">Submit a Review</h2>

    <% if(request.getAttribute("success") != null) { %>
        <div class="alert alert-success">${success}</div>
    <% } %>
    <% if(request.getAttribute("error") != null) { %>
        <div class="alert alert-danger">${error}</div>
    <% } %>

    <div class="card p-4 shadow-sm">
        <form action="/reviews/add" method="post">
            <div class="mb-3">
                <label class="form-label">Review ID</label>
                <input type="text" class="form-control" name="reviewId" required placeholder="e.g. RV001">
            </div>
            <div class="mb-3">
                <label class="form-label">User ID</label>
                <input type="text" class="form-control" name="userId" required placeholder="e.g. U001">
            </div>
            <div class="mb-3">
                <label class="form-label">Bike ID / Rental ID</label>
                <input type="text" class="form-control" name="targetId" required placeholder="e.g. B001 or R001">
            </div>
            <div class="mb-3">
                <label class="form-label">Rating (1-5)</label>
                <select class="form-select" name="rating">
                    <option value="5">5 - Excellent</option>
                    <option value="4">4 - Good</option>
                    <option value="3">3 - Average</option>
                    <option value="2">2 - Poor</option>
                    <option value="1">1 - Terrible</option>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Review Type</label>
                <select class="form-select" name="type">
                    <option value="BIKE">Bike Review</option>
                    <option value="SERVICE">Service Review</option>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Comment</label>
                <textarea class="form-control" name="comment" rows="3" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Submit Review</button>
        </form>
    </div>
</div>
</body>
</html>