<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold mb-0">Manage Stations</h2>
        <div class="d-flex gap-2">
            <button class="btn btn-green btn-sm" data-bs-toggle="modal" data-bs-target="#addStationModal">
                <i class="bi bi-plus-lg me-1"></i>Add Station
            </button>
            <a href="/admin" class="btn btn-outline-secondary btn-sm">← Dashboard</a>
        </div>
    </div>

    <div class="card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th>Name</th><th>Address</th><th>City</th>
                            <th>Type</th><th>Capacity</th><th>Bikes</th><th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="s" items="${stations}">
                            <tr>
                                <td>${s.name}</td>
                                <td>${s.address}</td>
                                <td>${s.city}</td>
                                <td>${s.type}</td>
                                <td>${s.capacity}</td>
                                <td>${s.bikeCount}</td>
                                <td>
                                    <button class="btn btn-green btn-sm"
                                            data-bs-toggle="modal" data-bs-target="#editModal${s.id}">Edit</button>
                                    <form action="/admin/stations/delete/${s.id}" method="post" class="d-inline ms-1"
                                          onsubmit="return confirm('Delete station ${s.name}?')">
                                        <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty stations}">
                            <tr><td colspan="7" class="text-center text-muted py-4">No stations found.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%-- Edit modals --%>
<c:forEach var="s" items="${stations}">
    <div class="modal fade" id="editModal${s.id}" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Station</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="/admin/stations/edit/${s.id}" method="post">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Name</label>
                            <input type="text" name="name" class="form-control" value="${s.name}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Address</label>
                            <input type="text" name="address" class="form-control" value="${s.address}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">City</label>
                            <input type="text" name="city" class="form-control" value="${s.city}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Capacity</label>
                            <input type="number" name="capacity" class="form-control" value="${s.capacity}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Type</label>
                            <select name="type" class="form-select">
                                <option value="MAIN"      ${s.type == 'MAIN'      ? 'selected' : ''}>MAIN</option>
                                <option value="SATELLITE" ${s.type == 'SATELLITE' ? 'selected' : ''}>SATELLITE</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-green">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</c:forEach>

<%-- Add Station Modal --%>
<div class="modal fade" id="addStationModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Add Station</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="/admin/stations/add" method="post">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Name</label>
                        <input type="text" name="name" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Address</label>
                        <input type="text" name="address" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">City</label>
                        <input type="text" name="city" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Capacity</label>
                        <input type="number" name="capacity" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Type</label>
                        <select name="type" class="form-select">
                            <option value="MAIN">MAIN</option>
                            <option value="SATELLITE">SATELLITE</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-green">Add Station</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>