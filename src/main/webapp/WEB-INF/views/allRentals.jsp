<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>

<div class="container py-4">
    <h2 class="fw-bold mb-4">All Rentals</h2>

    <c:if test="${empty rentals}">
        <div class="card p-4 text-center text-muted">No rentals found.</div>
    </c:if>

    <c:if test="${not empty rentals}">
        <div class="card">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead>
                            <tr>
                                <th>ID</th><th>User</th><th>Bike</th><th>Type</th>
                                <th>Start Station</th><th>End Station</th>
                                <th>Start Time</th><th>Cost</th><th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="r" items="${rentals}">
                                <tr>
                                    <td>${r.id}</td>
                                    <td>${r.userId}</td>
                                    <td>${r.bikeId}</td>
                                    <td>${r.rentalType}</td>
                                    <td>${r.startStation}</td>
                                    <td>${r.endStation}</td>
                                    <td>${r.startTime}</td>
                                    <td>${r.cost == 0 ? '-' : '$'.concat(r.cost)}</td>
                                    <td>
                                        <span class="badge ${r.status == 'ACTIVE' ? 'bg-success' : r.status == 'COMPLETED' ? 'bg-secondary' : 'bg-danger'}">
                                            ${r.status}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </c:if>
</div>

<%@ include file="footer.jsp" %>