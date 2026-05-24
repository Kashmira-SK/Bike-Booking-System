<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>

<div class="container py-4" style="max-width:620px">
    <h2 class="fw-bold mb-4">Edit Bike</h2>

    <div class="card">
        <div class="card-body p-4">
            <form action="/bikes/edit/${bike.id}" method="post">
                <div class="mb-3">
                    <label class="form-label">Model Name</label>
                    <input type="text" name="model" class="form-control" value="${bike.model}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Price Per Hour ($)</label>
                    <input type="number" name="pricePerHour" class="form-control" step="0.01" value="${bike.pricePerHour}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Image URL</label>
                    <input type="text" name="imageUrl" class="form-control" value="${bike.imageUrl}">
                </div>
                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control" rows="3">${bike.description}</textarea>
                </div>
                <div class="mb-3">
                    <label class="form-label">Station</label>
                    <select name="stationId" class="form-select" required>
                        <c:forEach var="station" items="${stations}">
                            <option value="${station.id}" ${bike.stationId == station.id ? 'selected' : ''}>
                                ${station.name} — ${station.city}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="mb-4">
                    <label class="form-label">Status</label>
                    <select name="status" class="form-select">
                        <option value="AVAILABLE"    ${bike.status == 'AVAILABLE'    ? 'selected' : ''}>Available</option>
                        <option value="RENTED"       ${bike.status == 'RENTED'       ? 'selected' : ''}>Rented</option>
                        <option value="MAINTENANCE"  ${bike.status == 'MAINTENANCE'  ? 'selected' : ''}>Maintenance</option>
                    </select>
                </div>
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-green flex-grow-1">Save Changes</button>
                    <a href="/bikes" class="btn btn-outline-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>