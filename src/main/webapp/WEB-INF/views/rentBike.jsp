<%@ include file="navbar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container" style="max-width: 600px;">
    <div class="page-header">
        <h2><i class="bi bi-key"></i> Rent a Bike</h2>
    </div>

    <c:if test="${not empty selectedBike}">
        <div class="card mb-4 border-success">
            <div class="card-body d-flex justify-content-between align-items-center">
                <div>
                    <h5 class="mb-1">${selectedBike.model}</h5>
                    <span class="text-muted">${selectedBike.bikeType}</span>
                </div>
                <div class="text-end">
                    <div class="fw-bold text-success fs-4">$${selectedBike.pricePerHour}/hr</div>
                    <small class="text-muted">$${selectedBike.pricePerHour * 8}/day</small>
                </div>
            </div>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="card p-4">
        <form action="/rentals/rent" method="post">
            <div class="mb-3">
                <label class="form-label fw-semibold">Bike</label>
                <c:choose>
                    <c:when test="${not empty selectedBike}">
                        <input type="hidden" name="bikeId" value="${selectedBike.id}">
                        <input type="text" class="form-control" value="${selectedBike.model}" disabled>
                    </c:when>
                    <c:otherwise>
                        <select name="bikeId" class="form-select" required>
                            <option value="">-- Select a bike --</option>
                            <c:forEach var="b" items="${availableBikes}">
                                <option value="${b.id}">${b.model} (${b.bikeType}) — $${b.pricePerHour}/hr</option>
                            </c:forEach>
                        </select>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="mb-3">
                <label class="form-label fw-semibold">Pickup Station</label>
                <select name="startStation" class="form-select" required>
                    <option value="">-- Select pickup station --</option>
                    <c:forEach var="s" items="${stations}">
                        <option value="${s.id}">${s.name} — ${s.city}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label fw-semibold">Drop-off Station</label>
                <select name="endStation" class="form-select" required>
                    <option value="">-- Select drop-off station --</option>
                    <c:forEach var="s" items="${stations}">
                        <option value="${s.id}">${s.name} — ${s.city}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="mb-4">
                <label class="form-label fw-semibold">Rental Type</label>
                <div class="d-flex gap-3">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="type" value="HOURLY" id="hourly" checked>
                        <label class="form-check-label" for="hourly">Hourly</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="type" value="DAILY" id="daily">
                        <label class="form-check-label" for="daily">Daily</label>
                    </div>
                </div>
            </div>
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary flex-grow-1">Confirm Rental</button>
                <a href="/bikes" class="btn btn-outline-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body></html>