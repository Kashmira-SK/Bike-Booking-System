<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>

<div class="container py-5 d-flex justify-content-center">
    <div style="width:100%;max-width:440px">
        <h2 class="fw-bold mb-4 text-center">Welcome back</h2>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <div class="card">
            <div class="card-body p-4">
                <form action="/login" method="post">
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-control" required placeholder="you@example.com">
                    </div>
                    <div class="mb-4">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" class="form-control" required placeholder="••••••••">
                    </div>
                    <button type="submit" class="btn btn-green w-100 btn-lg">Login</button>
                    <p class="mt-3 text-center text-muted small mb-0">
                        No account? <a href="/register">Register</a>
                    </p>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>