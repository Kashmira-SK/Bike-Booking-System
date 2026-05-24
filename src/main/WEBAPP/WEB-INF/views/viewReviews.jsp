<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>

<div class="container py-4" style="max-width:540px">
    <h2 class="fw-bold mb-4">Edit Review</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="card">
        <div class="card-body p-4">
            <form action="/reviews/edit/${review.id}" method="post">
                <div class="mb-3">
                    <label class="form-label">Review Type</label>
                    <input type="text" class="form-control" value="${review.reviewType}" disabled>
                </div>
                <div class="mb-3">
                    <label class="form-label">Target ID</label>
                    <input type="text" class="form-control" value="${review.targetId}" disabled>
                </div>
                <div class="mb-3">
                    <label class="form-label">Rating (1–5)</label>
                    <select name="rating" class="form-select" required>
                        <option value="5" ${review.rating == 5 ? 'selected' : ''}>5 — Excellent</option>
                        <option value="4" ${review.rating == 4 ? 'selected' : ''}>4 — Good</option>
                        <option value="3" ${review.rating == 3 ? 'selected' : ''}>3 — Average</option>
                        <option value="2" ${review.rating == 2 ? 'selected' : ''}>2 — Poor</option>
                        <option value="1" ${review.rating == 1 ? 'selected' : ''}>1 — Terrible</option>
                    </select>
                </div>
                <div class="mb-4">
                    <label class="form-label">Comment</label>
                    <textarea name="comment" class="form-control" rows="4" required>${review.comment}</textarea>
                </div>
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-green flex-grow-1">Save Changes</button>
                    <a href="/reviews/my" class="btn btn-outline-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
