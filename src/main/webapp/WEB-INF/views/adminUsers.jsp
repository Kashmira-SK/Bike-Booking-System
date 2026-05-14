<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Users</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<%@ include file="navbar.jsp" %>
<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Manage Users</h2>
        <a href="/admin" class="btn btn-outline-secondary btn-sm">← Dashboard</a>
    </div>
    <div class="table-responsive">
        <table class="table table-bordered table-hover bg-white align-middle">
            <thead class="table-dark">
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Status</th>
                    <th>Actions</th>
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
                                    <span class="badge bg-danger">ADMIN</span>
                                </c:when>
                                <c:when test="${u.role == 'SELLER'}">
                                    <span class="badge bg-warning text-dark">SELLER</span>
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
                            <a href="/admin/users/${u.id}" class="btn btn-info btn-sm text-white me-1">View</a>

                            <form action="/admin/users/role" method="post" class="d-inline me-1">
                                <input type="hidden" name="userId" value="${u.id}">
                                <select name="newRole" class="form-select form-select-sm d-inline-block w-auto">
                                    <option value="REGULAR" ${u.role == 'REGULAR' ? 'selected' : ''}>REGULAR</option>
                                    <option value="SELLER"  ${u.role == 'SELLER'  ? 'selected' : ''}>SELLER</option>
                                    <option value="ADMIN"   ${u.role == 'ADMIN'   ? 'selected' : ''}>ADMIN</option>
                                </select>
                                <button type="submit" class="btn btn-primary btn-sm">Save</button>
                            </form>

                            <form action="/admin/users/delete/${u.id}" method="post" class="d-inline"
                                  onsubmit="return confirm('Delete user ${u.name}?')">
                                <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty users}">
                    <tr><td colspan="5" class="text-center text-muted">No users found.</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>