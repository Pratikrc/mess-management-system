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

<!-- Bootstrap CSS -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet">

<!-- Custom CSS -->

<link rel="stylesheet"
      href="css/style.css">

</head>

<body class="bg-light">

<div class="container">

<div class="row justify-content-center align-items-center min-vh-100">

<div class="col-xl-4
            col-lg-5
            col-md-6
            col-sm-8
            col-11">

<div class="card shadow-lg p-4">

<!-- TITLE -->

<h3 class="text-center mb-4 fw-bold">

    Smart Mess Login

</h3>

<!-- ALERT MESSAGE -->

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

<!-- LOGIN FORM -->

<form action="login"
      method="post">

<!-- EMAIL -->

<div class="mb-3">

<label class="form-label fw-semibold">

    Email

</label>

<input type="email"
       name="email"
       class="form-control"
       placeholder="Enter Email"
       required>

</div>

<!-- PASSWORD -->

<div class="mb-3">

<label class="form-label fw-semibold">

    Password

</label>

<input type="password"
       name="password"
       class="form-control"
       placeholder="Enter Password"
       required>

</div>

<!-- LOGIN BUTTON -->

<button type="submit"
        class="btn btn-primary w-100 py-2">

    Login

</button>

</form>

<!-- REGISTER -->

<p class="mt-4 text-center mb-2">

    New user?

    <a href="register.jsp"
       class="fw-semibold text-decoration-none">

        Register

    </a>

</p>

<!-- FORGOT PASSWORD -->

<p class="text-center mb-0">

    <a href="forgot_password.jsp"
       class="text-decoration-none">

        Forgot Password?

    </a>

</p>

</div>

</div>

</div>

</div>

</body>
</html>