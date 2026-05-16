<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>

<div class="container py-4" style="max-width:540px">
    <h2 class="fw-bold mb-4">Submit a Review</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="card">
        <div class="card-body p-4">
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
                <div class="mb-4">
                    <label class="form-label">Comment</label>
                    <textarea name="comment" class="form-control" rows="4" required></textarea>
                </div>
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-green flex-grow-1">Submit Review</button>
                    <a href="/reviews/my" class="btn btn-outline-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>