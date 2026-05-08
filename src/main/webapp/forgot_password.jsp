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

<div class="col-xl-5
            col-lg-6
            col-md-7
            col-sm-9
            col-11">

<div class="card shadow-lg p-4">

<!-- TITLE -->

<h3 class="text-center mb-4 fw-bold">

    Forgot Password

</h3>

<!-- ALERT MESSAGE -->

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

<div class="mb-3">

<label class="form-label fw-semibold">

    Email

</label>

<input type="email"
       name="email"
       class="form-control"
       placeholder="Enter Registered Email"
       required>

</div>

<!-- PHONE -->

<div class="mb-3">

<label class="form-label fw-semibold">

    Phone Number

</label>

<input type="text"
       name="phone"
       class="form-control"
       placeholder="Enter Registered Phone Number"
       pattern="[0-9]{10}"
       maxlength="10"
       required>

</div>

<!-- NEW PASSWORD -->

<div class="mb-4">

<label class="form-label fw-semibold">

    New Password

</label>

<input type="password"
       name="password"
       class="form-control"
       placeholder="Enter New Password"
       required>

</div>

<!-- BUTTON -->

<button type="submit"
        class="btn btn-primary w-100 py-2">

    Reset Password

</button>

</form>

<!-- LOGIN LINK -->

<p class="mt-4 text-center mb-0">

<a href="login.jsp"
   class="text-decoration-none fw-semibold">

    Back to Login

</a>

</p>

</div>

</div>

</div>

</div>

</body>
</html>