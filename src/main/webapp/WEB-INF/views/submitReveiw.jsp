<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Submit Review</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4" style="max-width: 520px;">
    <h2>Submit a Review</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="/reviews/submit" method="post">
        <div class="mb-3">
            <label class="form-label">Review Type</label>
            <select name="type" class="form-select" required>
                <option value="BIKE"    ${type == 'BIKE'    ? 'selected' : ''}>Bike Review</option>
                <option value="SERVICE" ${type == 'SERVICE' ? 'selected' : ''}>Service Review</option>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label">Target ID (Bike ID or Rental ID)</label>
            <input type="text" name="targetId" class="form-control"
                   value="${not empty targetId ? targetId : ''}" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Rating (1–5)</label>
            <select name="rating" class="form-select" required>
                <option value="5">5 — Excellent</option>
                <option value="4">4 — Good</option>
                <option value="3">3 — Average</option>
                <option value="2">2 — Poor</option>
                <option value="1">1 — Terrible</option>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label">Comment</label>
            <textarea name="comment" class="form-control" rows="4" required></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Submit Review</button>
        <a href="/reviews/my" class="btn btn-secondary ms-2">Cancel</a>
    </form>
</body>
</html>