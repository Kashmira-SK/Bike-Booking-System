<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="navbar.jsp" %>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold mb-0">My Bikes</h2>
        <a href="/bikes/add" class="btn btn-green"><i class="bi bi-plus-lg me-1"></i>Add New Bike</a>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <c:choose>
        <c:when test="${empty bikes}">
            <div class="alert alert-info">You have no bikes listed yet.</div>
        </c:when>
        <c:otherwise>
            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                <c:forEach var="bike" items="${bikes}">
                    <div class="col">
                        <div class="card h-100">
                            <c:if test="${not empty bike.imageUrl}">
                                <img src="${bike.imageUrl}" class="card-img-top"
                                     alt="${bike.model}"
                                     style="height:200px;object-fit:cover;border-radius:16px 16px 0 0;"
                                     onerror="this.style.display='none'">
                            </c:if>
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <h5 class="card-title mb-0">${bike.model}</h5>
                                    <span class="badge ${bike.status == 'AVAILABLE' ? 'bg-success' : 'bg-danger'}">${bike.status}</span>
                                </div>
                                <p class="text-muted small text-uppercase mb-1">${bike.type}</p>
                                <p class="fw-semibold mb-2" style="color:#74c69d;">
                                    Rs. <fmt:formatNumber value="${bike.pricePerHour}" pattern="#,##0.00"/> / hr
                                </p>
                                <c:if test="${not empty bike.description}">
                                    <p class="card-text small text-muted">${bike.description}</p>
                                </c:if>

                                <c:set var="extras" value="${extrasMap[bike.id]}"/>
                                <c:if test="${not empty extras}">
                                    <hr>
                                    <p class="small fw-semibold mb-1">Extras</p>
                                    <ul class="list-unstyled mb-0">
                                        <c:forEach var="extra" items="${extras}">
                                            <li class="small mb-1">
                                                <c:choose>
                                                    <c:when test="${extra.included}">
                                                        <span class="badge bg-secondary me-1">Free</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-warning me-1">
                                                            +Rs.<fmt:formatNumber value="${extra.pricePerRental}" pattern="#,##0.00"/>
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                                ${extra.name}
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </c:if>
                            </div>
                            <div class="card-footer d-flex gap-2">
                                <a href="/bikes/edit/${bike.id}" class="btn btn-sm btn-outline-secondary w-50">Edit</a>
                                <form action="/bikes/delete/${bike.id}" method="post" class="w-50"
                                      onsubmit="return confirm('Delete ${bike.model}? This cannot be undone.')">
                                    <button type="submit" class="btn btn-sm btn-outline-danger w-100">Delete</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="footer.jsp" %>