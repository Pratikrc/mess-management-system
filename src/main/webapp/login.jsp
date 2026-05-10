<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Login - Smart Mess</title>

<!-- Bootstrap -->

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
   LOGIN PAGE
=================================== */

.login-page{

    min-height:100vh;

    background:
    linear-gradient(
        135deg,
        #0f172a,
        #1e3a8a,
        #4f46e5
    );

    overflow:hidden;

    position:relative;
}

/* BACKGROUND GLOW */

.login-page::before{

    content:"";

    position:absolute;

    width:500px;
    height:500px;

    background:rgba(255,255,255,0.08);

    border-radius:50%;

    top:-150px;
    right:-120px;
}

/* LEFT SIDE */

.login-left{

    color:white;

    padding:60px;
}

.brand-logo{

    font-size:32px;

    font-weight:700;
}

.login-title{

    font-size:58px;

    font-weight:700;

    line-height:1.15;
}

.login-text{

    font-size:18px;

    opacity:0.9;

    line-height:1.8;
}

/* FEATURES */

.feature-item{

    display:flex;

    align-items:center;

    gap:15px;

    margin-bottom:20px;
}

.feature-icon{

    width:50px;
    height:50px;

    border-radius:14px;

    background:rgba(255,255,255,0.15);

    display:flex;

    align-items:center;

    justify-content:center;

    font-size:22px;
}

/* RIGHT SIDE */

.login-right{

    display:flex;

    justify-content:center;

    align-items:center;

    padding:30px;
}

/* GLASS CARD */

.glass-card{

    width:100%;

    max-width:460px;

    background:rgba(255,255,255,0.15);

    backdrop-filter:blur(16px);

    border:1px solid rgba(255,255,255,0.2);

    border-radius:30px;

    padding:40px;

    box-shadow:0 10px 40px rgba(0,0,0,0.2);

    color:white;
}

/* FORM */

.form-control{

    height:56px;

    border-radius:14px;

    border:none;

    background:rgba(255,255,255,0.15);

    color:white;

    padding-left:45px;
}

.form-control::placeholder{

    color:rgba(255,255,255,0.7);
}

.form-control:focus{

    background:rgba(255,255,255,0.2);

    color:white;

    box-shadow:none;
}

/* INPUT ICON */

.input-group{

    position:relative;
}

.input-icon{

    position:absolute;

    top:17px;
    left:15px;

    z-index:10;

    color:white;
}

/* BUTTON */

.login-btn{

    height:56px;

    border-radius:14px;

    font-weight:600;

    font-size:17px;

    transition:0.3s;
}

.login-btn:hover{

    transform:translateY(-3px);
}

/* LINKS */

.auth-link{

    color:#fff;

    text-decoration:none;

    font-weight:500;
}

.auth-link:hover{

    color:#facc15;
}

/* MOBILE */

@media(max-width:991px){

.login-left{

    display:none;
}

.login-right{

    padding:20px;
}

.glass-card{

    padding:30px 25px;
}

.login-title{

    font-size:40px;
}
}

</style>

</head>

<body>

<div class="container-fluid login-page">

<div class="row min-vh-100">

<!-- ===================================
     LEFT SECTION
=================================== -->

<div class="col-lg-6 d-none d-lg-flex align-items-center">

<div class="login-left">

<div class="brand-logo mb-4">

    🍛 Smart Mess

</div>

<h1 class="login-title mb-4">

    Welcome Back
    to Smart Mess

</h1>

<p class="login-text mb-5">

    Digitally manage attendance,
    subscriptions, payments,
    meal verification, analytics,
    and the complete mess ecosystem
    with a modern platform.

</p>

<!-- FEATURES -->

<div class="feature-item">

<div class="feature-icon">

    <i class="bi bi-calendar-check"></i>

</div>

<div>

<h5 class="mb-1">

    Smart Attendance

</h5>

<p class="mb-0 opacity-75">

    Real-time meal attendance system

</p>

</div>

</div>

<div class="feature-item">

<div class="feature-icon">

    <i class="bi bi-credit-card"></i>

</div>

<div>

<h5 class="mb-1">

    Easy Payments

</h5>

<p class="mb-0 opacity-75">

    Subscription and payment tracking

</p>

</div>

</div>

<div class="feature-item">

<div class="feature-icon">

    <i class="bi bi-bar-chart"></i>

</div>

<div>

<h5 class="mb-1">

    Analytics Dashboard

</h5>

<p class="mb-0 opacity-75">

    Powerful reporting system

</p>

</div>

</div>

</div>

</div>

<!-- ===================================
     RIGHT SECTION
=================================== -->

<div class="col-lg-6 login-right">

<div class="glass-card">

<!-- TITLE -->

<div class="text-center mb-4">

<h2 class="fw-bold mb-2">

    Login Account

</h2>

<p class="opacity-75 mb-0">

    Access your Smart Mess dashboard

</p>

</div>

<!-- ALERT -->

<%
String msg = request.getParameter("msg");

String type = request.getParameter("type");

if (msg != null) {
%>

<div class="alert
    <%= type != null && type.equals("success")
        ? "alert-success"
        : "alert-danger" %>">

    <%= msg %>

</div>

<%
}
%>

<!-- FORM -->

<form action="login"
      method="post">

<!-- EMAIL -->

<div class="mb-4">

<label class="form-label fw-semibold mb-2">

    Email Address

</label>

<div class="input-group">

<i class="bi bi-envelope input-icon"></i>

<input type="email"
       name="email"
       class="form-control"
       placeholder="Enter your email"
       required>

</div>

</div>

<!-- PASSWORD -->

<div class="mb-4">

<label class="form-label fw-semibold mb-2">

    Password

</label>

<div class="input-group">

<i class="bi bi-lock input-icon"></i>

<input type="password"
       name="password"
       class="form-control"
       placeholder="Enter your password"
       required>

</div>

</div>

<!-- LOGIN BUTTON -->

<button type="submit"
        class="btn btn-warning w-100 login-btn">

    <i class="bi bi-box-arrow-in-right"></i>

    Login Now

</button>

</form>

<!-- LINKS -->

<div class="text-center mt-4">

<p class="mb-2">

    New User?

    <a href="register.jsp"
       class="auth-link">

        Create Account

    </a>

</p>

<p class="mb-0">

    <a href="forgot_password.jsp"
       class="auth-link">

        Forgot Password?

    </a>

</p>

</div>

<!-- BACK -->

<div class="text-center mt-4">

<a href="index.jsp"
   class="btn btn-outline-light w-100 py-3 rounded-4">

    ← Back to Home

</a>

</div>

</div>

</div>

</div>

</div>

</body>
</html>