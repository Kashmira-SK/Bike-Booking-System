<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold" href="/bikes">&#x1F6B4; BikeRental</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMain">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navMain">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="/bikes">Browse Bikes</a>
                </li>
                <c:if test="${sessionScope.loggedInUser.role == 'SELLER' || sessionScope.loggedInUser.role == 'ADMIN'}">
                    <li class="nav-item">
                        <a class="nav-link" href="/bikes/mine">My Bikes</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/bikes/add">+ Add Bike</a>
                    </li>
                </c:if>
            </ul>
            <ul class="navbar-nav ms-auto">
                <c:choose>
                    <c:when test="${sessionScope.loggedInUser != null}">
                        <li class="nav-item">
                            <span class="nav-link text-light opacity-75">
                                ${sessionScope.loggedInUser.name}
                                <span class="badge bg-secondary ms-1">${sessionScope.loggedInUser.role}</span>
                            </span>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/logout">Logout</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item"><a class="nav-link" href="/login">Login</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>