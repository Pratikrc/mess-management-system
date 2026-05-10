<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Smart Mess Management System</title>

<!-- Bootstrap CSS -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet">

<!-- Bootstrap Icons -->

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<!-- Custom CSS -->

<link rel="stylesheet"
      href="css/style.css">

<style>

/* ===================================
   HERO SECTION
=================================== */

.hero{

    min-height:100vh;

    background:
    linear-gradient(
        135deg,
        #0f172a,
        #1e3a8a,
        #4f46e5
    );

    position:relative;

    overflow:hidden;

    display:flex;

    align-items:center;

    color:white;
}

/* GLOW EFFECT */

.hero::before{

    content:"";

    position:absolute;

    width:500px;
    height:500px;

    background:rgba(255,255,255,0.08);

    border-radius:50%;

    top:-120px;
    right:-120px;
}

/* NAVBAR */

.custom-navbar{

    position:absolute;

    top:0;

    width:100%;

    z-index:1000;

    padding:20px 0;
}

.brand-logo{

    font-size:28px;

    font-weight:700;

    color:white;

    text-decoration:none;
}

/* HERO TITLE */

.hero-title{

    font-size:64px;

    font-weight:700;

    line-height:1.15;
}

/* HERO TEXT */

.hero-text{

    font-size:20px;

    opacity:0.9;

    line-height:1.8;
}

/* HERO IMAGE */

.hero-image{

    max-width:420px;

    border-radius:30px;

    animation:float 4s ease-in-out infinite;
}

/* FLOAT */

@keyframes float{

0%{

    transform:translateY(0px);
}

50%{

    transform:translateY(-12px);
}

100%{

    transform:translateY(0px);
}
}

/* BUTTONS */

.hero-btn{

    padding:14px 32px;

    border-radius:14px;

    font-weight:600;

    transition:0.3s;
}

.hero-btn:hover{

    transform:translateY(-3px);
}

/* STATS */

.stats-section{

    margin-top:-70px;

    position:relative;

    z-index:10;
}

.stat-card{

    border:none;

    border-radius:22px;

    padding:35px;

    text-align:center;

    background:white;

    box-shadow:0 10px 30px rgba(0,0,0,0.08);
}

.stat-card h2{

    font-size:42px;

    font-weight:700;

    color:#4f46e5;
}

/* FEATURES */

.section-title{

    font-size:42px;

    font-weight:700;
}

.feature-card{

    border:none;

    border-radius:24px;

    padding:20px;

    transition:0.3s;

    height:100%;
}

.feature-card:hover{

    transform:translateY(-8px);
}

.feature-icon{

    width:80px;
    height:80px;

    border-radius:20px;

    display:flex;

    align-items:center;

    justify-content:center;

    font-size:36px;

    margin-bottom:25px;

    background:
    linear-gradient(
        135deg,
        #4f46e5,
        #3b82f6
    );

    color:white;
}

/* CTA SECTION */

.cta-section{

    background:
    linear-gradient(
        135deg,
        #4f46e5,
        #2563eb
    );

    border-radius:30px;

    color:white;
}

/* FOOTER */

.footer{

    background:#111827;

    color:white;

    padding:35px 0;
}

/* MOBILE */

@media(max-width:768px){

.hero{

    text-align:center;

    padding:120px 20px 70px;
}

.hero-title{

    font-size:42px;
}

.hero-text{

    font-size:17px;
}

.hero-image{

    margin-top:40px;

    max-width:280px;
}

.section-title{

    font-size:32px;
}
}

</style>

</head>

<body>

<!-- ===================================
     NAVBAR
=================================== -->

<nav class="custom-navbar">

<div class="container d-flex justify-content-between align-items-center">

<a href="index.jsp"
   class="brand-logo">

    🍛 Smart Mess

</a>

<div class="d-flex gap-3">

<a href="login.jsp"
   class="btn btn-light px-4">

    Login

</a>

<a href="register.jsp"
   class="btn btn-warning px-4">

    Register

</a>

</div>

</div>

</nav>

<!-- ===================================
     HERO SECTION
=================================== -->

<section class="hero">

<div class="container">

<div class="row align-items-center">

<!-- LEFT -->

<div class="col-lg-6">

<span class="badge bg-light text-dark px-3 py-2 mb-4">

    🚀 Modern Food Management Platform

</span>

<h1 class="hero-title">

    Smart Mess
    Management
    System

</h1>

<p class="hero-text mt-4 mb-4">

    Digitally manage mess attendance,
    subscriptions, meal verification,
    payments, reports, and student
    experiences with a modern
    responsive platform.

</p>

<div class="d-flex flex-wrap gap-3">

<a href="register.jsp"
   class="btn btn-warning hero-btn">

    Get Started

</a>

<a href="login.jsp"
   class="btn btn-outline-light hero-btn">

    Login Now

</a>

</div>

</div>

<!-- RIGHT -->

<div class="col-lg-6 text-center">

<img src="images/qr.png"
     class="img-fluid hero-image shadow-lg"
     alt="Smart Mess">

</div>

</div>

</div>

</section>

<!-- ===================================
     STATS
=================================== -->

<section class="stats-section">

<div class="container">

<div class="row">

<div class="col-lg-4 col-md-6 mb-4">

<div class="stat-card">

<h2>

    24/7

</h2>

<p class="mb-0 text-muted">

    Smart Digital Access

</p>

</div>

</div>

<div class="col-lg-4 col-md-6 mb-4">

<div class="stat-card">

<h2>

    100%

</h2>

<p class="mb-0 text-muted">

    Responsive Experience

</p>

</div>

</div>

<div class="col-lg-4 col-md-12 mb-4">

<div class="stat-card">

<h2>

    Fast

</h2>

<p class="mb-0 text-muted">

    Attendance & Payment Tracking

</p>

</div>

</div>

</div>

</div>

</section>

<!-- ===================================
     FEATURES
=================================== -->

<section class="py-5">

<div class="container py-5">

<div class="text-center mb-5">

<h2 class="section-title">

    Powerful Features

</h2>

<p class="text-muted mt-3">

    Everything needed for a modern
    mess management system

</p>

</div>

<div class="row g-4">

<!-- FEATURE 1 -->

<div class="col-lg-4 col-md-6">

<div class="card feature-card shadow-sm">

<div class="card-body">

<div class="feature-icon">

<i class="bi bi-calendar-check"></i>

</div>

<h4>

    Attendance Tracking

</h4>

<p class="text-muted">

    Real-time lunch and dinner
    attendance management.

</p>

</div>

</div>

</div>

<!-- FEATURE 2 -->

<div class="col-lg-4 col-md-6">

<div class="card feature-card shadow-sm">

<div class="card-body">

<div class="feature-icon">

<i class="bi bi-cash-stack"></i>

</div>

<h4>

    Payments & Plans

</h4>

<p class="text-muted">

    Subscription management with
    payment tracking and approvals.

</p>

</div>

</div>

</div>

<!-- FEATURE 3 -->

<div class="col-lg-4 col-md-6">

<div class="card feature-card shadow-sm">

<div class="card-body">

<div class="feature-icon">

<i class="bi bi-bar-chart-line"></i>

</div>

<h4>

    Analytics Dashboard

</h4>

<p class="text-muted">

    Visual reports and insights for
    attendance and revenue.

</p>

</div>

</div>

</div>

<!-- FEATURE 4 -->

<div class="col-lg-4 col-md-6">

<div class="card feature-card shadow-sm">

<div class="card-body">

<div class="feature-icon">

<i class="bi bi-megaphone"></i>

</div>

<h4>

    Smart Announcements

</h4>

<p class="text-muted">

    Instantly notify users about
    holidays, closures, and updates.

</p>

</div>

</div>

</div>

<!-- FEATURE 5 -->

<div class="col-lg-4 col-md-6">

<div class="card feature-card shadow-sm">

<div class="card-body">

<div class="feature-icon">

<i class="bi bi-emoji-smile"></i>

</div>

<h4>

    Feedback System

</h4>

<p class="text-muted">

    Improve the mess experience
    with student feedback collection.

</p>

</div>

</div>

</div>

<!-- FEATURE 6 -->

<div class="col-lg-4 col-md-6">

<div class="card feature-card shadow-sm">

<div class="card-body">

<div class="feature-icon">

<i class="bi bi-phone"></i>

</div>

<h4>

    Fully Responsive

</h4>

<p class="text-muted">

    Optimized for mobile,
    tablets, and desktops.

</p>

</div>

</div>

</div>

</div>

</div>

</section>

<!-- ===================================
     CTA SECTION
=================================== -->

<section class="pb-5">

<div class="container">

<div class="cta-section p-5 text-center shadow-lg">

<h2 class="fw-bold mb-4">

    Ready to Transform Your Mess System?

</h2>

<p class="mb-4 opacity-75">

    Start managing attendance,
    subscriptions, and meals smarter.

</p>

<div class="d-flex justify-content-center flex-wrap gap-3">

<a href="register.jsp"
   class="btn btn-light btn-lg px-4">

    Create Account

</a>

<a href="login.jsp"
   class="btn btn-outline-light btn-lg px-4">

    Login

</a>

</div>

</div>

</div>

</section>

<!-- ===================================
     FOOTER
=================================== -->

<footer class="footer text-center">

<div class="container">

<h4 class="mb-3">

    🍛 Smart Mess Management System

</h4>

<p class="mb-0 text-light opacity-75">

    Final Year Project • Modern Responsive Web Application

</p>

</div>

</footer>

</body>
</html>