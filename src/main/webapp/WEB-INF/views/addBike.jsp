<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>

<div class="container py-4" style="max-width:700px">
    <h2 class="fw-bold mb-4">List My Bike</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="card">
        <div class="card-body p-4">
            <form action="/bikes/add" method="post">
                <div class="mb-3">
                    <label class="form-label">Bike Type</label>
                    <select name="type" class="form-select" required>
                        <option value="" disabled selected>Select type...</option>
                        <option value="MOUNTAIN">Mountain</option>
                        <option value="ROAD">Road</option>
                        <option value="ELECTRIC">Electric</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">Model Name</label>
                    <input type="text" name="model" class="form-control" required placeholder="e.g. Trek Marlin 7">
                </div>
                <div class="mb-3">
                    <label class="form-label">Price Per Hour (Rs.)</label>
                    <input type="number" name="pricePerHour" class="form-control" step="0.01" min="0" required placeholder="0.00">
                </div>
                <div class="mb-3">
                    <label class="form-label">Station</label>
                    <select name="stationId" class="form-select" required>
                        <option value="" disabled selected>Select station...</option>
                        <c:forEach var="station" items="${stations}">
                            <option value="${station.id}">${station.name} — ${station.city}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">Image URL <span class="text-muted fw-normal">(optional)</span></label>
                    <input type="text" name="imageUrl" class="form-control" placeholder="https://example.com/bike.jpg">
                </div>
                <div class="mb-4">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control" rows="3" placeholder="Briefly describe your bike..."></textarea>
                </div>
                <div class="d-grid mt-4">
                    <button type="submit" class="btn btn-green btn-lg">
                        <i class="bi bi-bicycle me-2"></i>List My Bike
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>