<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold mb-0"><i class="bi bi-bicycle me-2"></i>Bikes</h2>
        <c:if test="${not empty sessionScope.loggedInUser and
            (sessionScope.loggedInUser.role == 'ADMIN' or sessionScope.loggedInUser.role == 'SELLER')}">
            <a href="/bikes/add" class="btn btn-green"><i class="bi bi-plus-lg me-1"></i>Add Bike</a>
        </c:if>
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
                            <span class="badge ${b.status == 'AVAILABLE' ? 'bg-success' : b.status == 'RENTED' ? 'bg-warning' : 'bg-secondary'}">
                                ${b.status}
                            </span>
                        </div>
                        <p class="text-muted mb-1"><i class="bi bi-tag me-1"></i>${b.bikeType}</p>
                        <p class="text-muted mb-1">
                            <i class="bi bi-geo-alt me-1"></i>
                            <c:choose>
                                <c:when test="${not empty stationNames[b.stationId]}">${stationNames[b.stationId]}</c:when>
                                <c:otherwise>Unknown Station</c:otherwise>
                            </c:choose>
                        </p>
                        <p class="fw-bold fs-5 mt-2" style="color:#74c69d;">$${b.pricePerHour}/hr</p>
                    </div>
                    <div class="card-footer d-flex gap-2">
                        <c:choose>
                            <c:when test="${b.status == 'AVAILABLE'}">
                                <a href="/rentals/rent?bikeId=${b.id}" class="btn btn-green flex-grow-1">
                                    <i class="bi bi-key me-1"></i>Rent This Bike
                                </a>
                            </c:when>
                            <c:otherwise>
                                <button class="btn btn-secondary flex-grow-1" disabled>Unavailable</button>
                            </c:otherwise>
                        </c:choose>
                        <c:if test="${not empty sessionScope.loggedInUser and
                            (sessionScope.loggedInUser.role == 'ADMIN' or
                             sessionScope.loggedInUser.id == b.sellerId)}">
                            <a href="/bikes/edit/${b.id}" class="btn btn-outline-secondary">
                                <i class="bi bi-pencil"></i>
                            </a>
                            <form action="/bikes/delete/${b.id}" method="post" class="d-inline"
                                  onsubmit="return confirm('Delete this bike?')">
                                <button type="submit" class="btn btn-outline-danger">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </form>
                        </c:if>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<%@ include file="footer.jsp" %>