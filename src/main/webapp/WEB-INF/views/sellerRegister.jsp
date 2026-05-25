<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>

<div class="container py-4" style="max-width:540px">
    <h2 class="fw-bold mb-4">Become a Seller</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="card">
        <div class="card-body p-4">
            <p class="text-muted mb-4">Fill in your details to start listing bikes on the platform.</p>
            <form action="/seller/register" method="post">
                <div class="mb-3">
                    <label class="form-label">Location</label>
                    <input type="text" name="location" class="form-control" required placeholder="e.g. Colombo Fort">
                </div>
                <div class="mb-4">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control" rows="4" required
                              placeholder="Tell us about yourself and the bikes you plan to offer..."></textarea>
                </div>
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-green flex-grow-1">Register as Seller</button>
                    <a href="/profile" class="btn btn-outline-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>