<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fn"  uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="navbar.jsp" %>

<style>
    .section-label {
        font-size: .73rem; font-weight: 700; letter-spacing: .14em;
        text-transform: uppercase; color: #52b788;
    }
    .how-icon {
        width: 60px; height: 60px; border-radius: 50%;
        background: rgba(82,183,136,0.20);
        display: flex; align-items: center; justify-content: center;
        font-size: 1.45rem; margin: 0 auto 1rem; color: #52b788;
    }
    .step-badge {
        display: inline-block; padding: .3em .8em; border-radius: 999px;
        background: rgba(82,183,136,0.20); color: #74c69d;
        font-size: .78rem; font-weight: 600; margin-bottom: .75rem;
    }
    .bike-emoji { font-size: 2.8rem; line-height: 1; }
    .pricing-featured-border { border-color: #52b788 !important; }
    .section-glass {
        background: rgba(255,255,255,0.04);
        border-radius: 24px;
        padding: 3rem 2rem;
        margin: 0.5rem 0;
    }
    .pricing-feature-item {
        padding: .55rem 0;
        border-bottom: 1px solid rgba(255,255,255,0.08);
        font-size: .94rem;
    }
    .pricing-feature-item:last-child { border-bottom: none; }
</style>

<%-- HERO --%>
<section style="min-height: 88vh; display: flex; align-items: center; padding: 4rem 0;">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-7">
                <span class="section-label d-inline-block mb-3">City · Mountain · Electric</span>
                <h1 class="display-3 fw-bold mb-3" style="letter-spacing:-1.5px;">
                    Rent a bike.<br>Explore freely.
                </h1>
                <p class="text-muted mb-4" style="font-size:1.15rem; max-width:480px;">
                    Hourly and daily rentals. Pick up at any station.
                </p>
                <div class="d-flex flex-wrap gap-3 mb-5">
                    <a href="/bikes" class="btn btn-green btn-lg px-4 fw-semibold">Browse Bikes</a>
                    <c:choose>
                        <c:when test="${not empty sessionScope.loggedInUser}">
                            <a href="/rentals/rent" class="btn btn-outline-secondary btn-lg px-4">Rent Now</a>
                        </c:when>
                        <c:otherwise>
                            <a href="/register" class="btn btn-outline-secondary btn-lg px-4">Get Started</a>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="d-flex gap-5">
                    <div>
                        <div style="font-size:1.4rem; font-weight:800;">500+</div>
                        <div class="text-muted" style="font-size:.78rem;">Bikes</div>
                    </div>
                    <div>
                        <div style="font-size:1.4rem; font-weight:800;">30+</div>
                        <div class="text-muted" style="font-size:.78rem;">Stations</div>
                    </div>
                    <div>
                        <div style="font-size:1.4rem; font-weight:800;">10k+</div>
                        <div class="text-muted" style="font-size:.78rem;">Happy riders</div>
                    </div>
                </div>
            </div>
            <div class="col-lg-5 d-none d-lg-flex justify-content-center">
                <div style="font-size:8.5rem; filter:drop-shadow(0 0 48px rgba(82,183,136,.35));">🚲</div>
            </div>
        </div>
    </div>
</section>

<%-- HOW IT WORKS --%>
<section style="padding: 4rem 0;">
    <div class="container">
        <div class="section-glass">
            <div class="text-center mb-5">
                <span class="section-label d-block mb-2">Simple process</span>
                <h2 class="fw-bold" style="font-size:2.2rem;">How it works</h2>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card h-100 text-center p-4">
                        <div class="card-body">
                            <div class="how-icon"><i class="bi bi-search"></i></div>
                            <span class="step-badge">Step 1</span>
                            <h5 class="fw-bold mb-2">Find a bike</h5>
                            <p class="text-muted mb-0 small">Browse the full fleet — city, mountain, and electric. Filter by type, price, and nearest station.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100 text-center p-4">
                        <div class="card-body">
                            <div class="how-icon"><i class="bi bi-geo-alt"></i></div>
                            <span class="step-badge">Step 2</span>
                            <h5 class="fw-bold mb-2">Pick up at a station</h5>
                            <p class="text-muted mb-0 small">Choose your pickup location from 30+ stations across the city. Unlock instantly with your account.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100 text-center p-4">
                        <div class="card-body">
                            <div class="how-icon"><i class="bi bi-arrow-repeat"></i></div>
                            <span class="step-badge">Step 3</span>
                            <h5 class="fw-bold mb-2">Ride and return</h5>
                            <p class="text-muted mb-0 small">Enjoy your ride, then drop off at any station when you're done. No need to return to the original spot.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<%-- FEATURED BIKES --%>
<section style="padding: 4rem 0;">
    <div class="container">
        <div class="d-flex justify-content-between align-items-end mb-5">
            <div>
                <span class="section-label d-block mb-2">Our fleet</span>
                <h2 class="fw-bold mb-0" style="font-size:2.2rem;">Featured bikes</h2>
            </div>
            <a href="/bikes" class="btn btn-outline-secondary">View all →</a>
        </div>
        <div class="row g-4">
            <c:choose>
                <c:when test="${not empty featuredBikes}">
                    <c:forEach var="bike" items="${featuredBikes}">
                        <div class="col-sm-6 col-lg-3">
                            <div class="card h-100">
                                <div class="card-body d-flex flex-column p-4">
                                    <div class="mb-3">
                                        <c:set var="bt" value="${fn:toUpperCase(bike.type)}"/>
                                        <c:choose>
                                            <c:when test="${bt == 'MOUNTAIN'}"><span class="bike-emoji">🚵</span></c:when>
                                            <c:when test="${bt == 'ROAD'}"><span class="bike-emoji">🚴</span></c:when>
                                            <c:when test="${bt == 'ELECTRIC'}"><span class="bike-emoji">⚡</span></c:when>
                                            <c:otherwise><span class="bike-emoji">🚲</span></c:otherwise>
                                        </c:choose>
                                    </div>
                                    <span class="badge bg-secondary text-capitalize mb-2 align-self-start">${bike.type}</span>
                                    <h6 class="fw-bold mb-1">${bike.model}</h6>
                                    <p class="text-muted small flex-grow-1 mb-3">${bike.description}</p>
                                    <div class="d-flex justify-content-between align-items-center pt-3" style="border-top:1px solid rgba(255,255,255,0.10)">
                                        <div>
                                            <span class="fw-bold fs-5" style="color:#74c69d;">
                                                $<fmt:formatNumber value="${bike.pricePerHour}" pattern="#,##0.00"/>
                                            </span>
                                            <span class="text-muted small">/hr</span>
                                        </div>
                                        <a href="/rentals/rent?bikeId=${bike.id}" class="btn btn-green btn-sm">Rent This</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12 text-center py-5 text-muted">
                        <div class="fs-1 mb-3">🚲</div>
                        <p>No bikes available right now. Check back soon!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</section>

<%-- REVIEWS --%>
<section style="padding: 4rem 0;">
    <div class="container">
        <div class="section-glass">
            <div class="text-center mb-5">
                <span class="section-label d-block mb-2">What riders say</span>
                <h2 class="fw-bold" style="font-size:2.2rem;">Recent reviews</h2>
            </div>
            <div class="row g-4">
                <c:choose>
                    <c:when test="${not empty recentReviews}">
                        <c:forEach var="review" items="${recentReviews}">
                            <div class="col-md-4">
                                <div class="card h-100 p-4">
                                    <div class="card-body d-flex flex-column">
                                        <div class="mb-3">
                                            <c:forEach begin="1" end="${review.rating}" var="s">⭐</c:forEach>
                                        </div>
                                        <p class="flex-grow-1 mb-3" style="font-size:.95rem; line-height:1.6;">"${review.comment}"</p>
                                        <div class="text-muted small">
                                            <i class="bi bi-clock me-1"></i>${review.timestamp}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-12 text-center py-5 text-muted">
                            <div class="fs-1 mb-3">⭐</div>
                            <p class="mb-3">No reviews yet. Be the first to ride and share your experience!</p>
                            <a href="/bikes" class="btn btn-green">Browse bikes</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="text-center mt-5">
                <a href="/reviews" class="btn btn-outline-secondary">Read all reviews</a>
            </div>
        </div>
    </div>
</section>

<%-- PRICING --%>
<section style="padding: 4rem 0;">
    <div class="container">
        <div class="text-center mb-5">
            <span class="section-label d-block mb-2">Simple pricing</span>
            <h2 class="fw-bold" style="font-size:2.2rem;">Hourly or daily — your call</h2>
            <p class="text-muted">No hidden fees. Pay only for what you use.</p>
        </div>
        <div class="row g-4 justify-content-center">
            <div class="col-md-5">
                <div class="card h-100 p-4">
                    <div class="card-body">
                        <div class="text-center mb-4">
                            <div class="fs-2 mb-2">⏱️</div>
                            <h4 class="fw-bold">Hourly</h4>
                            <div class="my-3" style="font-size:2.4rem; font-weight:800;">
                                From $3<span class="fs-6 text-muted fw-normal">/hr</span>
                            </div>
                            <p class="text-muted small">Best for short trips and errands</p>
                        </div>
                        <div class="mb-4">
                            <div class="pricing-feature-item"><i class="bi bi-check-circle-fill me-2" style="color:#52b788;"></i>Flexible — pay only for time used</div>
                            <div class="pricing-feature-item"><i class="bi bi-check-circle-fill me-2" style="color:#52b788;"></i>Billed per hour, rounded up</div>
                            <div class="pricing-feature-item"><i class="bi bi-check-circle-fill me-2" style="color:#52b788;"></i>Helmet included</div>
                            <div class="pricing-feature-item text-muted"><i class="bi bi-x-circle me-2"></i>Lock not included</div>
                        </div>
                        <a href="/bikes" class="btn btn-outline-secondary w-100 fw-semibold">Get started</a>
                    </div>
                </div>
            </div>
            <div class="col-md-5">
                <div class="card h-100 p-4 pricing-featured-border position-relative" style="border-width:2px!important">
                    <div class="position-absolute top-0 start-50 translate-middle">
                        <span class="badge bg-success px-3 py-2 rounded-pill" style="background:#52b788!important">Best value</span>
                    </div>
                    <div class="card-body">
                        <div class="text-center mb-4">
                            <div class="fs-2 mb-2">📅</div>
                            <h4 class="fw-bold">Daily</h4>
                            <div class="my-3" style="font-size:2.4rem; font-weight:800;">
                                From $18<span class="fs-6 text-muted fw-normal">/day</span>
                            </div>
                            <p class="text-muted small">Best for full-day adventures</p>
                        </div>
                        <div class="mb-4">
                            <div class="pricing-feature-item"><i class="bi bi-check-circle-fill me-2" style="color:#52b788;"></i>8-hour flat day rate</div>
                            <div class="pricing-feature-item"><i class="bi bi-check-circle-fill me-2" style="color:#52b788;"></i>No hourly surprises</div>
                            <div class="pricing-feature-item"><i class="bi bi-check-circle-fill me-2" style="color:#52b788;"></i>Helmet included</div>
                            <div class="pricing-feature-item"><i class="bi bi-check-circle-fill me-2" style="color:#52b788;"></i>Lock included</div>
                        </div>
                        <a href="/bikes" class="btn btn-green w-100 fw-semibold">Get started</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="footer.jsp" %>