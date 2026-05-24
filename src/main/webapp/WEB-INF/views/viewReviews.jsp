<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold mb-0">All Reviews</h2>
        <a href="/reviews/submit" class="btn btn-green"><i class="bi bi-plus-lg me-1"></i>Write a Review</a>
    </div>

    <c:if test="${empty reviews}">
        <div class="card p-4 text-center text-muted">No reviews yet.</div>
    </c:if>

    <c:if test="${not empty reviews}">
        <div class="card">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Type</th><th>Target ID</th><th>Rating</th><th>Comment</th><th>Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="r" items="${reviews}">
                                <tr>
                                    <td>${r.reviewType}</td>
                                    <td>${r.targetId}</td>
                                    <td><c:forEach begin="1" end="${r.rating}">⭐</c:forEach></td>
                                    <td>${r.comment}</td>
                                    <td>${r.timestamp}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </c:if>
</div>

<%@ include file="footer.jsp" %>