<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold mb-0">Manage Users</h2>
        <a href="/admin" class="btn btn-outline-secondary btn-sm">← Dashboard</a>
    </div>
    <div class="card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th>Name</th><th>Email</th><th>Role</th><th>Status</th><th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="u" items="${users}">
                            <tr>
                                <td>${u.name}</td>
                                <td>${u.email}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.role == 'ADMIN'}">
                                            <span class="badge bg-warning">ADMIN</span>
                                        </c:when>
                                        <c:when test="${u.role == 'SELLER'}">
                                            <span class="badge bg-success">SELLER</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">REGULAR</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.status == 'ACTIVE'}">
                                            <span class="badge bg-success">ACTIVE</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${u.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="d-flex flex-wrap gap-1 align-items-center">
                                        <a href="/admin/users/${u.id}" class="btn btn-outline-secondary btn-sm">View</a>
                                        <form action="/admin/users/role" method="post" class="d-inline">
                                            <input type="hidden" name="userId" value="${u.id}">
                                            <select name="newRole" class="form-select form-select-sm d-inline-block"
                                                    style="width:auto;display:inline-block!important">
                                                <option value="REGULAR" ${u.role == 'REGULAR' ? 'selected' : ''}>REGULAR</option>
                                                <option value="SELLER"  ${u.role == 'SELLER'  ? 'selected' : ''}>SELLER</option>
                                                <option value="ADMIN"   ${u.role == 'ADMIN'   ? 'selected' : ''}>ADMIN</option>
                                            </select>
                                            <button type="submit" class="btn btn-green btn-sm">Save</button>
                                        </form>
                                        <form action="/admin/users/delete/${u.id}" method="post" class="d-inline"
                                              onsubmit="return confirm('Delete user ${u.name}?')">
                                            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty users}">
                            <tr><td colspan="5" class="text-center text-muted py-4">No users found.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>