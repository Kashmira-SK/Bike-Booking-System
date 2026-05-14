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
                <input type="hidden" name="sellerId" value="${sessionScope.loggedInUser.id}">

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

                <hr>

                <div class="mb-3">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <span class="fw-semibold">Extras</span>
                        <button type="button" class="btn btn-sm btn-outline-secondary" id="addExtraBtn">
                            <i class="bi bi-plus-lg me-1"></i>Add Extra
                        </button>
                    </div>
                    <div id="extrasContainer"></div>
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

<script>
    let extraIndex = 0;
    document.getElementById('addExtraBtn').addEventListener('click', function () {
        const container = document.getElementById('extrasContainer');
        const row = document.createElement('div');
        row.className = 'glass-card p-3 mb-2 position-relative';
        row.id = 'extraRow_' + extraIndex;
        row.innerHTML = `
            <button type="button" class="btn-close position-absolute top-0 end-0 m-2"
                    onclick="removeExtra(${extraIndex})" style="filter:invert(1)"></button>
            <div class="row g-2 align-items-end">
                <div class="col-sm-5">
                    <label class="form-label small mb-1">Name</label>
                    <input type="text" name="extraName_${extraIndex}" class="form-control form-control-sm"
                           placeholder="e.g. Helmet" required>
                </div>
                <div class="col-sm-4">
                    <label class="form-label small mb-1">Price (Rs.)</label>
                    <input type="number" name="extraPrice_${extraIndex}" class="form-control form-control-sm"
                           step="0.01" min="0" value="0.00">
                </div>
                <div class="col-sm-3 d-flex align-items-center" style="padding-top:1.6rem">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" name="extraIncluded_${extraIndex}" id="inc_${extraIndex}">
                        <label class="form-check-label small" for="inc_${extraIndex}">Free</label>
                    </div>
                </div>
            </div>
        `;
        container.appendChild(row);
        extraIndex++;
    });

    function removeExtra(index) {
        const row = document.getElementById('extraRow_' + index);
        if (row) row.remove();
    }
</script>

<%@ include file="footer.jsp" %>