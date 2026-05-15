<footer style="
    background: rgba(10, 25, 15, 0.85);
    border-top: 1px solid rgba(255,255,255,0.10);
    -webkit-backdrop-filter: blur(12px);
    backdrop-filter: blur(12px);
    color: rgba(255,255,255,0.75);
    margin-top: 4rem;
    position: relative;
    z-index: 1;
">
    <div class="container py-4">
        <div class="row gy-3 align-items-start">

            <!-- Column 1: Logo + tagline -->
            <div class="col-12 col-md-4">
                <div class="d-flex align-items-center mb-2">
                    <i class="bi bi-bicycle fs-4 me-2" style="color:#52b788;"></i>
                    <span style="color:#d8f3dc; font-weight:700; font-size:1.1rem;">BikeRental</span>
                </div>
                <p style="font-size:0.85rem; color:rgba(255,255,255,0.55); margin:0;">
                    Ride more. Worry less.<br>Your journey starts here.
                </p>
            </div>

            <!-- Column 2: Nav links -->
            <div class="col-6 col-md-4">
                <p style="color:#52b788; font-weight:600; font-size:0.8rem; text-transform:uppercase; letter-spacing:0.8px; margin-bottom:0.6rem;">
                    Navigate
                </p>
                <ul class="list-unstyled mb-0" style="font-size:0.88rem;">
                    <li class="mb-1"><a href="${pageContext.request.contextPath}/home"
                        style="color:rgba(255,255,255,0.65); text-decoration:none;"
                        onmouseover="this.style.color='#52b788'" onmouseout="this.style.color='rgba(255,255,255,0.65)'">
                        Home</a></li>
                    <li class="mb-1"><a href="${pageContext.request.contextPath}/bikes"
                        style="color:rgba(255,255,255,0.65); text-decoration:none;"
                        onmouseover="this.style.color='#52b788'" onmouseout="this.style.color='rgba(255,255,255,0.65)'">
                        Browse Bikes</a></li>
                    <li class="mb-1"><a href="${pageContext.request.contextPath}/bookings"
                        style="color:rgba(255,255,255,0.65); text-decoration:none;"
                        onmouseover="this.style.color='#52b788'" onmouseout="this.style.color='rgba(255,255,255,0.65)'">
                        My Bookings</a></li>
                    <li><a href="${pageContext.request.contextPath}/profile"
                        style="color:rgba(255,255,255,0.65); text-decoration:none;"
                        onmouseover="this.style.color='#52b788'" onmouseout="this.style.color='rgba(255,255,255,0.65)'">
                        Profile</a></li>
                </ul>
            </div>

            <!-- Column 3: Legal links -->
            <div class="col-6 col-md-4">
                <p style="color:#52b788; font-weight:600; font-size:0.8rem; text-transform:uppercase; letter-spacing:0.8px; margin-bottom:0.6rem;">
                    Legal
                </p>
                <ul class="list-unstyled mb-0" style="font-size:0.88rem;">
                    <li class="mb-1"><a href="${pageContext.request.contextPath}/terms"
                        style="color:rgba(255,255,255,0.65); text-decoration:none;"
                        onmouseover="this.style.color='#52b788'" onmouseout="this.style.color='rgba(255,255,255,0.65)'">
                        Terms of Service</a></li>
                    <li class="mb-1"><a href="${pageContext.request.contextPath}/privacy"
                        style="color:rgba(255,255,255,0.65); text-decoration:none;"
                        onmouseover="this.style.color='#52b788'" onmouseout="this.style.color='rgba(255,255,255,0.65)'">
                        Privacy Policy</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact"
                        style="color:rgba(255,255,255,0.65); text-decoration:none;"
                        onmouseover="this.style.color='#52b788'" onmouseout="this.style.color='rgba(255,255,255,0.65)'">
                        Cookie Policy</a></li>
                </ul>
            </div>
        </div>

        <hr style="border-color:rgba(255,255,255,0.10); margin:1.2rem 0 0.8rem;">
        <p style="text-align:center; font-size:0.78rem; color:rgba(255,255,255,0.35); margin:0;">
            &copy; 2026 SKU OOP Project BikeRental System. Group 44. All rights reserved.
        </p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>