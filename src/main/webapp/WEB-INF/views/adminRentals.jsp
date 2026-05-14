<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold mb-0">Manage Rentals</h2>
        <a href="/admin" class="btn btn-outline-secondary btn-sm">← Dashboard</a>
    </div>
    <div class="card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th>ID</th><th>User ID</th><th>Bike ID</th><th>Type</th>
                            <th>Status</th><th>Cost</th><th>Start Time</th><th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="r" items="${rentals}">
                            <tr>
                                <td>${r.id}</td>
                                <td>${r.userId}</td>
                                <td>${r.bikeId}</td>
                                <td>${r.rentalType}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${r.status == 'ACTIVE'}">
                                            <span class="badge bg-success">ACTIVE</span>
                                        </c:when>
                                        <c:when test="${r.status == 'CANCELLED'}">
                                            <span class="badge bg-danger">CANCELLED</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${r.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>$${r.cost}</td>
                                <td>${r.startTime}</td>
                                <td>
                                    <c:if test="${r.status == 'ACTIVE'}">
                                        <form action="/admin/rentals/cancel/${r.id}" method="post" class="d-inline">
                                            <button type="submit" class="btn btn-warning btn-sm">Cancel</button>
                                        </form>
                                    </c:if>
                                    <form action="/admin/rentals/delete/${r.id}" method="post" class="d-inline ms-1"
                                          onsubmit="return confirm('Delete rental ${r.id}?')">
                                        <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty rentals}">
                            <tr><td colspan="8" class="text-center text-muted py-4">No rentals found.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>