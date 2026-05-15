<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="navbar.jsp" %>

<style>
    .contact-info-card {
        background: rgba(255,255,255,0.08);
        border: 1px solid rgba(255,255,255,0.15);
        border-radius: 16px;
        -webkit-backdrop-filter: blur(10px);
        backdrop-filter: blur(10px);
        transition: border-color 0.2s;
    }
    .contact-info-card:hover { border-color: rgba(82,183,136,0.50); }
    .contact-icon {
        width: 48px; height: 48px; border-radius: 12px;
        background: rgba(82,183,136,0.20);
        display: flex; align-items: center; justify-content: center;
        font-size: 1.2rem; flex-shrink: 0;
        color: #52b788;
    }
</style>

<div class="container py-4">
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb small">
            <li class="breadcrumb-item"><a href="/home">Home</a></li>
            <li class="breadcrumb-item active">Contact</li>
        </ol>
    </nav>

    <div class="row g-5">
        <div class="col-lg-5">
            <h1 class="fw-bold mb-2">Get in touch</h1>
            <p class="text-muted mb-5">Have a question or a problem with a rental? We're here to help.</p>

            <div class="d-flex flex-column gap-3">
                <div class="contact-info-card p-4">
                    <div class="d-flex align-items-start gap-3">
                        <div class="contact-icon"><i class="bi bi-geo-alt-fill"></i></div>
                        <div>
                            <div class="fw-semibold mb-1">Our address</div>
                            <div class="text-muted small">42 Main Road, Kandy, Sri Lanka<br>Springfield, CA 94102</div>
                        </div>
                    </div>
                </div>
                <div class="contact-info-card p-4">
                    <div class="d-flex align-items-start gap-3">
                        <div class="contact-icon"><i class="bi bi-envelope-fill"></i></div>
                        <div>
                            <div class="fw-semibold mb-1">Email us</div>
                            <div class="text-muted small">
                                <a href="mailto:hello@bikerental.example.com">hello@bikerental.example.com</a><br>
                                <a href="mailto:support@bikerental.example.com">support@bikerental.example.com</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="contact-info-card p-4">
                    <div class="d-flex align-items-start gap-3">
                        <div class="contact-icon"><i class="bi bi-telephone-fill"></i></div>
                        <div>
                            <div class="fw-semibold mb-1">Call us</div>
                            <div class="text-muted small">
                                Mon – Fri, 8 am – 6 pm PST<br>
                                <a href="tel:+14155550192">+1 (415) 555-0192</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-7">
            <div class="card p-4 p-md-5">
                <h4 class="fw-bold mb-1">Send us a message</h4>
                <p class="text-muted small mb-4">We'll get back to you within one business day.</p>
                <div class="row g-3">
                    <div class="col-sm-6">
                        <label class="form-label">First name</label>
                        <input type="text" class="form-control" placeholder="Alex">
                    </div>
                    <div class="col-sm-6">
                        <label class="form-label">Last name</label>
                        <input type="text" class="form-control" placeholder="Johnson">
                    </div>
                    <div class="col-12">
                        <label class="form-label">Email address</label>
                        <input type="email" class="form-control" placeholder="alex@example.com">
                    </div>
                    <div class="col-12">
                        <label class="form-label">Subject</label>
                        <select class="form-select">
                            <option value="" disabled selected>Select a topic…</option>
                            <option>Rental issue</option>
                            <option>Billing question</option>
                            <option>Lost or damaged bike</option>
                            <option>Station feedback</option>
                            <option>Account help</option>
                            <option>Other</option>
                        </select>
                    </div>
                    <div class="col-12">
                        <label class="form-label">Message</label>
                        <textarea class="form-control" rows="5" placeholder="Tell us how we can help…"></textarea>
                    </div>
                    <div class="col-12 pt-1">
                        <button type="button" class="btn btn-green px-5 fw-semibold">
                            Send message <i class="bi bi-send ms-1"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>