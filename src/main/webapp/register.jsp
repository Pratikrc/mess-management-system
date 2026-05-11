<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Register - Smart Mess</title>

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
   REGISTER PAGE
=================================== */

.register-page{

    min-height:100vh;

    background:
    linear-gradient(
        135deg,
        #0f172a,
        #1e40af,
        #4f46e5
    );

    position:relative;

    overflow:hidden;
}

/* GLOW EFFECT */

.register-page::before{

    content:"";

    position:absolute;

    width:600px;
    height:600px;

    background:rgba(255,255,255,0.08);

    border-radius:50%;

    top:-200px;
    left:-150px;
}

/* LEFT SECTION */

.register-left{

    color:white;

    padding:60px;
}

.brand-logo{

    font-size:32px;

    font-weight:700;
}

.register-title{

    font-size:58px;

    font-weight:700;

    line-height:1.15;
}

.register-text{

    font-size:18px;

    opacity:0.9;

    line-height:1.8;
}

/* FEATURE */

.feature-item{

    display:flex;

    gap:15px;

    align-items:center;

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

/* RIGHT */

.register-right{

    display:flex;

    align-items:center;

    justify-content:center;

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

    box-shadow:0 10px 40px rgba(0,0,0,0.2);

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

.register-btn{

    height:58px;

    border-radius:15px;

    font-weight:600;

    font-size:17px;

    transition:0.3s;
}

.register-btn:hover{

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

.register-left{

    display:none;
}

.glass-card{

    padding:30px 24px;
}

.register-title{

    font-size:42px;
}
}

</style>

</head>

<body>

<div class="container-fluid register-page">

<div class="row min-vh-100">

<!-- ===================================
     LEFT SECTION
=================================== -->

<div class="col-lg-6 d-none d-lg-flex align-items-center">

<div class="register-left">

<div class="brand-logo mb-4">

    🍛 Smart Mess

</div>

<h1 class="register-title mb-4">

    Create Your
    Smart Mess
    Account

</h1>

<p class="register-text mb-5">

    Join the next-generation mess
    management platform with smart
    attendance, meal verification,
    subscriptions, analytics,
    and digital food management.

</p>

<!-- FEATURES -->

<div class="feature-item">

<div class="feature-icon">

    <i class="bi bi-person-check"></i>

</div>

<div>

<h5 class="mb-1">

    Easy Registration

</h5>

<p class="mb-0 opacity-75">

    Quick onboarding experience

</p>

</div>

</div>

<div class="feature-item">

<div class="feature-icon">

    <i class="bi bi-credit-card-2-front"></i>

</div>

<div>

<h5 class="mb-1">

    Smart Subscription

</h5>

<p class="mb-0 opacity-75">

    Modern payment & plan system

</p>

</div>

</div>

<div class="feature-item">

<div class="feature-icon">

    <i class="bi bi-phone"></i>

</div>

<div>

<h5 class="mb-1">

    Easy To Use

</h5>

<p class="mb-0 opacity-75">

    

</p>

</div>

</div>

</div>

</div>

<!-- ===================================
     RIGHT SECTION
=================================== -->

<div class="col-lg-6 register-right">

<div class="glass-card">

<!-- HEADER -->

<div class="text-center mb-4">

<h2 class="fw-bold mb-2">

    Create Account

</h2>

<p class="opacity-75 mb-0">

    Register to access Smart Mess

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

<form action="<%=request.getContextPath()%>/register"
      method="post">

<!-- NAME -->

<div class="mb-4">

<label class="form-label fw-semibold mb-2">

    Full Name

</label>

<div class="input-group">

<i class="bi bi-person input-icon"></i>

<input type="text"
       name="name"
       class="form-control"
       placeholder="Enter full name"
       required>

</div>

</div>

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
       placeholder="Enter email address"
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
       placeholder="Enter 10-digit phone number"
       pattern="[0-9]{10}"
       maxlength="10"
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
       placeholder="Create password"
       required>

</div>

</div>

<!-- REGISTER BUTTON -->

<button type="submit"
        class="btn btn-warning w-100 register-btn">

    <i class="bi bi-person-plus"></i>

    Create Account

</button>

</form>

<!-- LOGIN -->

<div class="text-center mt-4">

<p class="mb-0">

    Already have an account?

    <a href="login.jsp"
       class="auth-link">

        Login

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