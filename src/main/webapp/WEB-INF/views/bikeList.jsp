<%@ include file="navbar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container">
    <div class="page-header d-flex justify-content-between align-items-center">
        <h2><i class="bi bi-bicycle"></i> Bikes</h2>
        <a href="/bikes/add" class="btn btn-primary"><i class="bi bi-plus-lg"></i> Add Bike</a>
    </div>

    <c:if test="${empty bikes}">
        <div class="card p-5 text-center text-muted">No bikes found. Add one to get started.</div>
    </c:if>

    <div class="row g-4">
        <c:forEach var="b" items="${bikes}">
            <div class="col-md-4">
                <div class="card h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-start mb-2">
                            <h5 class="card-title mb-0">${b.model}</h5>
                            <span class="badge ${b.status == 'AVAILABLE' ? 'bg-success' : b.status == 'RENTED' ? 'bg-warning text-dark' : 'bg-secondary'}">
                                ${b.status}
                            </span>
                        </div>
                        <p class="text-muted mb-1"><i class="bi bi-tag"></i> ${b.bikeType}</p>
                        <p class="text-muted mb-1"><i class="bi bi-geo-alt"></i>
                            <c:choose>
                                <c:when test="${not empty stationNames[b.stationId]}">${stationNames[b.stationId]}</c:when>
                                <c:otherwise>Unknown Station</c:otherwise>
                            </c:choose>
                        </p>
                        <p class="fw-bold text-success fs-5 mt-2">$${b.pricePerHour}/hr</p>
                    </div>
                    <div class="card-footer bg-transparent d-flex gap-2">
                        <c:if test="${b.status == 'AVAILABLE'}">
                            <a href="/rentals/rent?bikeId=${b.id}" class="btn btn-primary flex-grow-1">
                                <i class="bi bi-key"></i> Rent This Bike
                            </a>
                        </c:if>
                        <c:if test="${b.status != 'AVAILABLE'}">
                            <button class="btn btn-secondary flex-grow-1" disabled>Unavailable</button>
                        </c:if>
                        <a href="/bikes/edit/${b.id}" class="btn btn-outline-secondary">
                            <i class="bi bi-pencil"></i>
                        </a>
                        <form action="/bikes/delete/${b.id}" method="post" class="d-inline"
                              onsubmit="return confirm('Delete this bike?')">
                            <button type="submit" class="btn btn-outline-danger">
                                <i class="bi bi-trash"></i>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body></html>