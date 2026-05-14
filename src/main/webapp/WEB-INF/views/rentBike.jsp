<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>

<div class="container py-4" style="max-width:620px">
    <h2 class="fw-bold mb-4"><i class="bi bi-key me-2"></i>Rent a Bike</h2>

    <c:if test="${not empty selectedBike}">
        <div class="card mb-4" style="border-color:rgba(82,183,136,0.50)!important">
            <div class="card-body d-flex justify-content-between align-items-center">
                <div>
                    <h5 class="mb-1">${selectedBike.model}</h5>
                    <span class="text-muted">${selectedBike.bikeType}</span>
                </div>
                <div class="text-end">
                    <div class="fw-bold fs-4" style="color:#74c69d;">$${selectedBike.pricePerHour}/hr</div>
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
                <label class="form-label">Bike</label>
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
                <label class="form-label">Pickup Station</label>
                <select name="startStation" class="form-select" required>
                    <option value="">-- Select pickup station --</option>
                    <c:forEach var="s" items="${stations}">
                        <option value="${s.id}">${s.name} — ${s.city}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Drop-off Station</label>
                <select name="endStation" class="form-select" required>
                    <option value="">-- Select drop-off station --</option>
                    <c:forEach var="s" items="${stations}">
                        <option value="${s.id}">${s.name} — ${s.city}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="mb-4">
                <label class="form-label">Rental Type</label>
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
                <button type="submit" class="btn btn-green flex-grow-1">Confirm Rental</button>
                <a href="/bikes" class="btn btn-outline-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>

<%@ include file="footer.jsp" %>