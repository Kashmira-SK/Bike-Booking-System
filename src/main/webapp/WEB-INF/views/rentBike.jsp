<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>

<div class="container py-4" style="max-width:620px">
    <h2 class="fw-bold mb-4">
        <i class="bi bi-key me-2"></i>Rent a Bike
    </h2>

    <c:if test="${not empty selectedBike}">
        <div class="card mb-4" style="border-color:rgba(82,183,136,0.50)!important">
            <div class="card-body d-flex justify-content-between align-items-center">
                <div>
                    <h5 class="mb-1">${selectedBike.model}</h5>
                    <span class="text-muted">${selectedBike.bikeType}</span>
                </div>
                <div class="text-end">
                    <div class="fw-bold fs-4" style="color:#74c69d;">
                        $${selectedBike.pricePerHour}/hr
                    </div>
                    <small class="text-muted">
                        $${selectedBike.pricePerHour * 8}/day
                    </small>
                </div>
            </div>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="card p-4">
        <form action="/rentals/rent" method="post">

            <!-- Bike Selection -->
            <div class="mb-3">
                <label class="form-label">Bike</label>
                <c:choose>
                    <c:when test="${not empty selectedBike}">
                        <input type="hidden" name="bikeId" value="${selectedBike.id}">
                        <input type="text"
                               class="form-control"
                               value="${selectedBike.model}"
                               disabled>
                    </c:when>
                    <c:otherwise>
                        <select name="bikeId"
                                id="bikeSelect"
                                class="form-select"
                                required>
                            <option value="">-- Select a bike --</option>
                            <c:forEach var="b" items="${availableBikes}">
                                <option value="${b.id}"
                                        data-price="${b.pricePerHour}">
                                    ${b.model} (${b.bikeType}) — $${b.pricePerHour}/hr
                                </option>
                            </c:forEach>
                        </select>
                    </c:otherwise>
                </c:choose>

                <!-- Hidden field for selected bike price when bike is preselected -->
                <c:if test="${not empty selectedBike}">
                    <input type="hidden"
                           id="selectedBikePrice"
                           value="${selectedBike.pricePerHour}">
                </c:if>
            </div>

            <!-- Pickup Station -->
            <div class="mb-3">
                <label class="form-label">Pickup Station</label>
                <select name="startStation" class="form-select" required>
                    <option value="">-- Select pickup station --</option>
                    <c:forEach var="s" items="${stations}">
                        <option value="${s.id}">
                            ${s.name} — ${s.city}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <!-- Drop-off Station -->
            <div class="mb-3">
                <label class="form-label">Drop-off Station</label>
                <select name="endStation" class="form-select" required>
                    <option value="">-- Select drop-off station --</option>
                    <c:forEach var="s" items="${stations}">
                        <option value="${s.id}">
                            ${s.name} — ${s.city}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <!-- Rental Type -->
            <div class="mb-3">
                <label class="form-label">Rental Type</label>
                <div class="d-flex gap-3">
                    <div class="form-check">
                        <input class="form-check-input"
                               type="radio"
                               name="type"
                               value="HOURLY"
                               id="hourly"
                               checked>
                        <label class="form-check-label" for="hourly">
                            Hourly
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input"
                               type="radio"
                               name="type"
                               value="DAILY"
                               id="daily">
                        <label class="form-check-label" for="daily">
                            Daily
                        </label>
                    </div>
                </div>
            </div>

            <!-- Planned Start Time -->
            <div class="mb-3">
                <label class="form-label">Planned Start Time</label>
                <input type="datetime-local"
                       class="form-control"
                       id="startTime"
                       name="startTime"
                       required>
            </div>

            <!-- Planned End Time -->
            <div class="mb-3">
                <label class="form-label">Planned End Time</label>
                <input type="datetime-local"
                       class="form-control"
                       id="endTime"
                       name="endTime"
                       required>
            </div>

            <!-- Estimated Duration -->
            <div class="mb-3">
                <label class="form-label">Estimated Duration</label>
                <input type="text"
                       class="form-control"
                       id="estimatedDuration"
                       readonly
                       placeholder="Select start and end times">
            </div>

            <!-- Estimated Cost -->
            <div class="mb-4">
                <label class="form-label">Estimated Cost</label>
                <input type="text"
                       class="form-control fw-bold"
                       id="estimatedCost"
                       readonly
                       placeholder="$0.00">
            </div>

            <!-- Hidden field for optional backend use -->
            <input type="hidden"
                   name="plannedHours"
                   id="plannedHours">

            <!-- Buttons -->
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-green flex-grow-1">
                    Confirm Rental
                </button>
                <a href="/bikes" class="btn btn-outline-secondary">
                    Cancel
                </a>
            </div>
        </form>
    </div>
</div>

<script>
function getPricePerHour() {
    // If a bike is preselected
    const selectedBikePrice = document.getElementById("selectedBikePrice");
    if (selectedBikePrice) {
        return parseFloat(selectedBikePrice.value);
    }

    // If bike is selected from dropdown
    const bikeSelect = document.getElementById("bikeSelect");
    if (bikeSelect && bikeSelect.selectedIndex > 0) {
        const option = bikeSelect.options[bikeSelect.selectedIndex];
        return parseFloat(option.dataset.price || 0);
    }

    return 0;
}

function updateEstimate() {
    const startValue = document.getElementById("startTime").value;
    const endValue = document.getElementById("endTime").value;

    const durationField = document.getElementById("estimatedDuration");
    const costField = document.getElementById("estimatedCost");
    const plannedHoursField = document.getElementById("plannedHours");

    if (!startValue || !endValue) {
        durationField.value = "";
        costField.value = "";
        plannedHoursField.value = "";
        return;
    }

    const start = new Date(startValue);
    const end = new Date(endValue);

    if (end <= start) {
        durationField.value = "End time must be after start time";
        costField.value = "";
        plannedHoursField.value = "";
        return;
    }

    const diffMs = end - start;
    const diffHours = diffMs / (1000 * 60 * 60);

    const rentalType =
        document.querySelector('input[name="type"]:checked').value;

    const pricePerHour = getPricePerHour();

    let units;
    let estimatedCost;

    if (rentalType === "HOURLY") {
        units = Math.ceil(diffHours);
        estimatedCost = units * pricePerHour;
        durationField.value =
            units + " hour(s)";
        plannedHoursField.value = units;
    } else {
        units = Math.ceil(diffHours / 24);
        estimatedCost = units * pricePerHour * 24;
        durationField.value =
            units + " day(s)";
        plannedHoursField.value = units * 24;
    }

    costField.value = "$" + estimatedCost.toFixed(2);
}

document.addEventListener("DOMContentLoaded", function() {
    const startInput = document.getElementById("startTime");
    const endInput = document.getElementById("endTime");
    const bikeSelect = document.getElementById("bikeSelect");
    const rentalTypeRadios =
        document.querySelectorAll('input[name="type"]');

    if (startInput) {
        startInput.addEventListener("change", updateEstimate);
        startInput.addEventListener("input", updateEstimate);
    }

    if (endInput) {
        endInput.addEventListener("change", updateEstimate);
        endInput.addEventListener("input", updateEstimate);
    }

    if (bikeSelect) {
        bikeSelect.addEventListener("change", updateEstimate);
    }

    rentalTypeRadios.forEach(function(radio) {
        radio.addEventListener("change", updateEstimate);
    });

    // Set minimum start time to current time
    const now = new Date();
    now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
    const minDateTime = now.toISOString().slice(0, 16);

    if (startInput) {
        startInput.min = minDateTime;
    }

    updateEstimate();
});
</script>

<%@ include file="footer.jsp" %>