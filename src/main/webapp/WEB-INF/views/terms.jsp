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
            <li class="breadcrumb-item active">Terms of Service</li>
        </ol>
    </nav>

    <div class="card p-4 p-md-5">
        <h1 class="fw-bold mb-1">Terms of Service</h1>
        <p class="text-muted small mb-5">Last updated: January 1, 2025</p>
        <div class="legal-prose">
            <h5>1. Rental Liability</h5>
            <p>By renting a bike through BikeRental, you agree to assume full responsibility for the bicycle during the rental period. BikeRental shall not be held liable for any injuries, accidents, or losses sustained while operating a rental bike. Riders are solely responsible for obeying all applicable traffic laws, cycling regulations, and local ordinances. Any damage caused to third parties or property during the rental period is the sole financial responsibility of the renter.</p>

            <h5>2. Helmet Policy</h5>
            <p>A helmet is provided with every rental at no additional charge. Renters are required to wear the provided helmet at all times while operating a BikeRental bicycle. Failure to wear a helmet may result in immediate termination of the rental and forfeiture of any unused rental time without refund. BikeRental accepts no liability for head injuries sustained when a helmet is not worn or is worn incorrectly.</p>

            <h5>3. Damage Policy</h5>
            <p>Renters are responsible for returning the bicycle in the same condition as received, subject to normal wear and tear. Any damage beyond normal wear will be assessed by BikeRental staff upon return and the cost of repairs will be charged to the payment method on file. In the event of a total loss due to theft or irreparable damage, the renter may be charged the full replacement value of the bicycle.</p>

            <h5>4. Account and Payment Terms</h5>
            <p>A valid BikeRental account and payment method are required to initiate any rental. BikeRental reserves the right to suspend or terminate accounts that violate these terms. Refunds for shortened rentals are issued at BikeRental's sole discretion and are not guaranteed. BikeRental reserves the right to amend these Terms of Service at any time; continued use of the service following any changes constitutes acceptance of the revised terms.</p>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>