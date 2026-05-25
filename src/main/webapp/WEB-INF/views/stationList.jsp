<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold mb-0">All Stations</h2>
        <c:if test="${not empty sessionScope.loggedInUser and sessionScope.loggedInUser.role == 'ADMIN'}">
            <a href="/stations/add" class="btn btn-green"><i class="bi bi-plus-lg me-1"></i>Add Station</a>
        </c:if>
    </div>
    <c:if test="${empty stations}">
        <div class="card p-4 text-center text-muted">No stations found.</div>
    </c:if>
    <c:if test="${not empty stations}">
        <div class="card">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Name</th><th>City</th><th>Address</th>
                                <th>Type</th><th>Bikes</th><th>Capacity</th><th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="s" items="${stations}">
                                <tr>
                                    <td>${s.name}</td>
                                    <td>${s.city}</td>
                                    <td>${s.address}</td>
                                    <td>${s.stationType}</td>
                                    <td>${s.bikeCount}</td>
                                    <td>${s.capacity}</td>
                                    <td>
                                        <a href="/stations/${s.id}" class="btn btn-sm btn-outline-secondary">View</a>
                                        <c:if test="${not empty sessionScope.loggedInUser and
                                            sessionScope.loggedInUser.role == 'ADMIN'}">
                                            <form action="/stations/delete/${s.id}" method="post" class="d-inline ms-1"
                                                  onsubmit="return confirm('Delete this station?')">
                                                <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                                            </form>
                                        </c:if>
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