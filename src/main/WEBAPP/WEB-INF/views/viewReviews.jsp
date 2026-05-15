<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Reviews</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>All Reviews</h2>
        <a href="/reviews/submit" class="btn btn-primary">+ Write a Review</a>
    </div>

    <c:if test="${empty reviews}">
        <p class="text-muted">No reviews yet.</p>
    </c:if>

    <c:if test="${not empty reviews}">
        <table class="table table-bordered table-hover">
            <thead class="table-dark">
                <tr>
                    <th>Type</th>
                    <th>Target ID</th>
                    <th>Rating</th>
                    <th>Comment</th>
                    <th>Date</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="r" items="${reviews}">
                    <tr>
                        <td>${r.reviewType}</td>
                        <td>${r.targetId}</td>
                        <td>
                            <c:forEach begin="1" end="${r.rating}">⭐</c:forEach>
                        </td>
                        <td>${r.comment}</td>
                        <td>${r.timestamp}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</body>
</html>