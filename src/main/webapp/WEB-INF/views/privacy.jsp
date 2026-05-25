<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>

<style>
    .legal-prose h5 { font-weight: 700; margin-top: 2rem; margin-bottom: .6rem; color: #ffffff; }
    .legal-prose p  { color: rgba(255,255,255,0.75); line-height: 1.8; }
</style>

<div class="container py-4" style="max-width:780px">
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb small">
            <li class="breadcrumb-item"><a href="/home">Home</a></li>
            <li class="breadcrumb-item active">Privacy Policy</li>
        </ol>
    </nav>

    <div class="card p-4 p-md-5">
        <h1 class="fw-bold mb-1">Privacy Policy</h1>
        <p class="text-muted small mb-5">Last updated: January 1, 2025</p>
        <div class="legal-prose">
            <h5>1. Information We Collect</h5>
            <p>When you create a BikeRental account, we collect the information you provide directly, including your full name, email address, phone number, and password. When you complete a rental, we also collect transaction data such as the bike rented, pickup and return station, rental duration, and payment details. We may additionally collect device and usage information — such as browser type, IP address, and pages visited — to help us maintain and improve the platform.</p>

            <h5>2. How We Use Your Information</h5>
            <p>We use the information we collect to operate and provide the BikeRental service, process payments, send booking confirmations and service-related communications, and improve the platform's features and reliability. We may use anonymised, aggregated usage data for internal analytics. We will not use your personal information to send marketing communications without your explicit consent.</p>

            <h5>3. Information Sharing</h5>
            <p>BikeRental does not sell, rent, or trade your personal information to third parties. We may share limited data with trusted service providers who assist us in operating the platform — such as payment processors and infrastructure providers — solely to the extent necessary to perform those services. We may also disclose information when required by law or to protect the rights and safety of BikeRental, its users, or the public.</p>

            <h5>4. Data Retention and Your Rights</h5>
            <p>We retain your personal data for as long as your account is active or as needed to provide services. You may request access to, correction of, or deletion of your personal data at any time by contacting us at privacy@bikerental.example.com. Upon a valid deletion request, we will remove your personal data from our systems within 30 days, except where retention is required by law.</p>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>