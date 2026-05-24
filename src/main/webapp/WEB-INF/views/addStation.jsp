<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>

<div class="container py-4" style="max-width:620px">
    <h2 class="fw-bold mb-4">Add Station</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="card">
        <div class="card-body p-4">
            <form action="/stations/add" method="post">
                <div class="mb-3">
                    <label class="form-label">Station Name</label>
                    <input type="text" name="name" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Address</label>
                    <input type="text" name="address" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">City</label>
                    <input type="text" name="city" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Capacity</label>
                    <input type="number" name="capacity" class="form-control" min="1" required>
                </div>
                <div class="mb-4">
                    <label class="form-label">Type</label>
                    <select name="type" class="form-select">
                        <option value="MAIN">Main Station</option>
                        <option value="SATELLITE">Satellite Station</option>
                    </select>
                </div>
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-green flex-grow-1">Add Station</button>
                    <a href="/stations" class="btn btn-outline-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>