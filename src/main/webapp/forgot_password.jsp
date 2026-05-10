<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Forgot Password - Smart Mess</title>

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
   FORGOT PASSWORD PAGE
=================================== */

.forgot-page{

    min-height:100vh;

    background:
    linear-gradient(
        135deg,
        #0f172a,
        #1d4ed8,
        #4f46e5
    );

    overflow:hidden;

    position:relative;
}

/* GLOW EFFECT */

.forgot-page::before{

    content:"";

    position:absolute;

    width:550px;
    height:550px;

    background:rgba(255,255,255,0.08);

    border-radius:50%;

    bottom:-180px;
    right:-140px;
}

/* LEFT SECTION */

.forgot-left{

    color:white;

    padding:60px;
}

.brand-logo{

    font-size:32px;

    font-weight:700;
}

.forgot-title{

    font-size:58px;

    font-weight:700;

    line-height:1.15;
}

.forgot-text{

    font-size:18px;

    opacity:0.9;

    line-height:1.8;
}

/* FEATURES */

.feature-item{

    display:flex;

    align-items:center;

    gap:15px;

    margin-bottom:22px;
}

.feature-icon{

    width:52px;
    height:52px;

    border-radius:15px;

    background:rgba(255,255,255,0.15);

    display:flex;

    align-items:center;

    justify-content:center;

    font-size:22px;
}

/* RIGHT SECTION */

.forgot-right{

    display:flex;

    justify-content:center;

    align-items:center;

    padding:30px;
}

/* GLASS CARD */

.glass-card{

    width:100%;

    max-width:500px;

    background:rgba(255,255,255,0.15);

    backdrop-filter:blur(18px);

    border:1px solid rgba(255,255,255,0.2);

    border-radius:30px;

    padding:40px;

    box-shadow:0 10px 40px rgba(0,0,0,0.25);

    color:white;
}

/* FORM */

.form-control{

    height:56px;

    border:none;

    border-radius:14px;

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

    left:15px;
    top:17px;

    z-index:10;

    color:white;
}

/* BUTTON */

.reset-btn{

    height:58px;

    border-radius:15px;

    font-weight:600;

    font-size:17px;

    transition:0.3s;
}

.reset-btn:hover{

    transform:translateY(-3px);
}

/* LINK */

.auth-link{

    color:white;

    font-weight:600;

    text-decoration:none;
}

.auth-link:hover{

    color:#facc15;
}

/* MOBILE */

@media(max-width:991px){

.forgot-left{

    display:none;
}

.glass-card{

    padding:30px 24px;
}

.forgot-title{

    font-size:42px;
}
}

</style>

</head>

<body>

<div class="container-fluid forgot-page">

<div class="row min-vh-100">

<!-- ===================================
     LEFT SECTION
=================================== -->

<div class="col-lg-6 d-none d-lg-flex align-items-center">

<div class="forgot-left">

<div class="brand-logo mb-4">

    🔐 Smart Mess

</div>

<h1 class="forgot-title mb-4">

    Recover Your
    Smart Mess
    Account

</h1>

<p class="forgot-text mb-5">

    Securely reset your password and
    regain access to attendance,
    subscriptions, meal tracking,
    analytics, and your Smart Mess dashboard.

</p>

<!-- FEATURES -->

<div class="feature-item">

<div class="feature-icon">

    <i class="bi bi-shield-lock"></i>

</div>

<div>

<h5 class="mb-1">

    Secure Recovery

</h5>

<p class="mb-0 opacity-75">

    Safe password reset process

</p>

</div>

</div>

<div class="feature-item">

<div class="feature-icon">

    <i class="bi bi-phone"></i>

</div>

<div>

<h5 class="mb-1">

    Phone Verification

</h5>

<p class="mb-0 opacity-75">

    Verify registered phone number

</p>

</div>

</div>

<div class="feature-item">

<div class="feature-icon">

    <i class="bi bi-lightning-charge"></i>

</div>

<div>

<h5 class="mb-1">

    Instant Access

</h5>

<p class="mb-0 opacity-75">

    Quickly restore account access

</p>

</div>

</div>

</div>

</div>

<!-- ===================================
     RIGHT SECTION
=================================== -->

<div class="col-lg-6 forgot-right">

<div class="glass-card">

<!-- HEADER -->

<div class="text-center mb-4">

<h2 class="fw-bold mb-2">

    Reset Password

</h2>

<p class="opacity-75 mb-0">

    Recover access to your account

</p>

</div>

<!-- ALERT -->

<%
String msg = request.getParameter("msg");

String type = request.getParameter("type");

if (msg != null) {
%>

<div class="alert
    <%= "success".equals(type)
        ? "alert-success"
        : "alert-danger" %>">

    <%= msg %>

</div>

<%
}
%>

<!-- FORM -->

<form action="forgotPassword"
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
       placeholder="Enter registered email"
       required>

</div>

</div>

<!-- PHONE -->

<div class="mb-4">

<label class="form-label fw-semibold mb-2">

    Phone Number

</label>

<div class="input-group">

<i class="bi bi-telephone input-icon"></i>

<input type="text"
       name="phone"
       class="form-control"
       placeholder="Enter registered phone number"
       pattern="[0-9]{10}"
       maxlength="10"
       required>

</div>

</div>

<!-- PASSWORD -->

<div class="mb-4">

<label class="form-label fw-semibold mb-2">

    New Password

</label>

<div class="input-group">

<i class="bi bi-lock input-icon"></i>

<input type="password"
       name="password"
       class="form-control"
       placeholder="Create new password"
       required>

</div>

</div>

<!-- BUTTON -->

<button type="submit"
        class="btn btn-warning w-100 reset-btn">

    <i class="bi bi-arrow-repeat"></i>

    Reset Password

</button>

</form>

<!-- LOGIN -->

<div class="text-center mt-4">

<p class="mb-0">

<a href="login.jsp"
   class="auth-link">

    ← Back to Login

</a>

</p>

</div>

<!-- HOME -->

<div class="text-center mt-4">

<a href="index.jsp"
   class="btn btn-outline-light w-100 py-3 rounded-4">

    🏠 Back to Home

</a>

</div>

</div>

</div>

</div>

</div>

</body>
</html>