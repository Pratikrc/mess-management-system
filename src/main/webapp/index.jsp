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

/* HERO SECTION */

.hero{

    min-height:100vh;
    display:flex;
    align-items:center;

    background:
    linear-gradient(
        135deg,
        #4f46e5,
        #3b82f6
    );

    color:white;
}

/* HERO TITLE */

.hero h1{

    font-size:58px;
    font-weight:700;
    line-height:1.2;
}

/* HERO TEXT */

.hero p{

    font-size:20px;
    opacity:0.95;
}

/* HERO IMAGE */

.hero img{

    border-radius:20px;
}

/* FEATURE ICON */

.feature-icon{

    font-size:50px;
    color:#4f46e5;
}

/* FEATURE CARD */

.feature-card{

    border-radius:20px;
}

/* FOOTER */

.footer{

    background:#111827;
    color:white;
    padding:25px 0;
}

/* MOBILE */

@media(max-width:768px){

.hero{

    text-align:center;
    padding:60px 20px;
}

.hero h1{

    font-size:38px;
}

.hero p{

    font-size:16px;
}
}

</style>

</head>

<body>

<!-- =========================
     HERO SECTION
========================= -->

<section class="hero">

<div class="container">

<div class="row align-items-center">

<!-- LEFT CONTENT -->

<div class="col-lg-6 col-md-12 mb-5">

<h1>

    Smart Mess
    Management System

</h1>

<p class="mt-4 mb-4">

    A modern digital platform for
    managing mess subscriptions,
    attendance, payments,
    announcements, reports,
    and meal verification.

</p>

<!-- BUTTONS -->

<div class="d-flex flex-wrap gap-3">

<a href="login.jsp"
   class="btn btn-light btn-lg px-4">

    Login

</a>

<a href="register.jsp"
   class="btn btn-warning btn-lg px-4">

    Register

</a>

</div>

</div>

<!-- RIGHT IMAGE -->

<div class="col-lg-6 col-md-12 text-center">

<img src="images/qr.png"
     alt="Smart Mess"
     class="img-fluid shadow-lg"
     style="max-width:380px;">

</div>

</div>

</div>

</section>

<!-- =========================
     FEATURES SECTION
========================= -->

<section class="py-5 bg-light">

<div class="container">

<!-- TITLE -->

<div class="text-center mb-5">

<h2>

    Why Choose Smart Mess?

</h2>

<p class="text-muted">

    Powerful features for students
    and mess administrators

</p>

</div>

<!-- FEATURES -->

<div class="row">

<!-- FEATURE 1 -->

<div class="col-lg-4 col-md-6 col-sm-12 mb-4">

<div class="card feature-card shadow-sm h-100">

<div class="card-body text-center">

<div class="feature-icon mb-3">

<i class="bi bi-calendar-check"></i>

</div>

<h4>

    Attendance Tracking

</h4>

<p>

    Easily mark lunch and dinner
    attendance with real-time tracking.

</p>

</div>

</div>

</div>

<!-- FEATURE 2 -->

<div class="col-lg-4 col-md-6 col-sm-12 mb-4">

<div class="card feature-card shadow-sm h-100">

<div class="card-body text-center">

<div class="feature-icon mb-3">

<i class="bi bi-cash-stack"></i>

</div>

<h4>

    Subscription & Payments

</h4>

<p>

    Manage mess subscriptions,
    online payments,
    and payment approvals.

</p>

</div>

</div>

</div>

<!-- FEATURE 3 -->

<div class="col-lg-4 col-md-6 col-sm-12 mb-4">

<div class="card feature-card shadow-sm h-100">

<div class="card-body text-center">

<div class="feature-icon mb-3">

<i class="bi bi-bar-chart-line"></i>

</div>

<h4>

    Reports & Analytics

</h4>

<p>

    Visualize attendance,
    subscriptions,
    and payments through reports.

</p>

</div>

</div>

</div>

<!-- FEATURE 4 -->

<div class="col-lg-4 col-md-6 col-sm-12 mb-4">

<div class="card feature-card shadow-sm h-100">

<div class="card-body text-center">

<div class="feature-icon mb-3">

<i class="bi bi-megaphone"></i>

</div>

<h4>

    Announcements

</h4>

<p>

    Admin can instantly notify
    users about holidays,
    closures, and updates.

</p>

</div>

</div>

</div>

<!-- FEATURE 5 -->

<div class="col-lg-4 col-md-6 col-sm-12 mb-4">

<div class="card feature-card shadow-sm h-100">

<div class="card-body text-center">

<div class="feature-icon mb-3">

<i class="bi bi-emoji-smile"></i>

</div>

<h4>

    Feedback System

</h4>

<p>

    Users can submit feedback
    to improve the mess experience.

</p>

</div>

</div>

</div>

<!-- FEATURE 6 -->

<div class="col-lg-4 col-md-6 col-sm-12 mb-4">

<div class="card feature-card shadow-sm h-100">

<div class="card-body text-center">

<div class="feature-icon mb-3">

<i class="bi bi-phone"></i>

</div>

<h4>

    Fully Responsive

</h4>

<p>

    Works perfectly on mobile,
    tablet,
    and desktop devices.

</p>

</div>

</div>

</div>

</div>

</div>

</section>

<!-- =========================
     FOOTER
========================= -->

<footer class="footer text-center">

<div class="container">

<h5>

    Smart Mess Management System

</h5>

<p class="mb-0">

    Final Year Project • Responsive Web Application

</p>

</div>

</footer>

</body>
</html>