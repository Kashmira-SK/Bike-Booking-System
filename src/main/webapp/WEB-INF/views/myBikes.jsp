<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>My Bikes</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<jsp:include page="navbar.jsp"/>

<div class="container pb-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold mb-0">My Bikes</h2>
        <a href="/bikes/add" class="btn btn-success">+ Add New Bike</a>
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
                        <div class="card h-100 shadow-sm">
                            <c:if test="${not empty bike.imageUrl}">
                                <img src="${bike.imageUrl}" class="card-img-top"
                                     alt="${bike.model}"
                                     style="height:200px;object-fit:cover;"
                                     onerror="this.style.display='none'">
                            </c:if>
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <h5 class="card-title mb-0">${bike.model}</h5>
                                    <c:choose>
                                        <c:when test="${bike.status == 'AVAILABLE'}">
                                            <span class="badge bg-success">${bike.status}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger">${bike.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <p class="text-muted small text-uppercase mb-1">${bike.type}</p>
                                <p class="fw-semibold mb-2">
                                    Rs. <fmt:formatNumber value="${bike.pricePerHour}" pattern="#,##0.00"/> / hr
                                </p>
                                <c:if test="${not empty bike.description}">
                                    <p class="card-text small text-muted">${bike.description}</p>
                                </c:if>

                                <c:set var="extras" value="${extrasMap[bike.id]}"/>
                                <c:if test="${not empty extras}">
                                    <hr class="my-2">
                                    <p class="small fw-semibold mb-1">Extras</p>
                                    <ul class="list-unstyled mb-0">
                                        <c:forEach var="extra" items="${extras}">
                                            <li class="small mb-1">
                                                <c:choose>
                                                    <c:when test="${extra.included}">
                                                        <span class="badge bg-secondary me-1">Free</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-warning text-dark me-1">
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
                            <div class="card-footer bg-white border-top d-flex gap-2">
                                <a href="/bikes/edit/${bike.id}" class="btn btn-sm btn-outline-primary w-50">Edit</a>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>