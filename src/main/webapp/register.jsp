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

    Smart Mess Registration

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

<!-- REGISTER FORM -->

<form action="<%=request.getContextPath()%>/register"
      method="post">

<!-- NAME -->

<div class="mb-3">

<label class="form-label fw-semibold">

    Name

</label>

<input type="text"
       name="name"
       class="form-control"
       placeholder="Enter Full Name"
       required>

</div>

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

<!-- PHONE -->

<div class="mb-3">

<label class="form-label fw-semibold">

    Phone Number

</label>

<input type="text"
       name="phone"
       class="form-control"
       placeholder="Enter 10-digit Phone Number"
       pattern="[0-9]{10}"
       maxlength="10"
       required>

</div>

<!-- PASSWORD -->

<div class="mb-4">

<label class="form-label fw-semibold">

    Password

</label>

<input type="password"
       name="password"
       class="form-control"
       placeholder="Enter Password"
       required>

</div>

<!-- REGISTER BUTTON -->

<button type="submit"
        class="btn btn-success w-100 py-2">

    Register

</button>

</form>

<!-- LOGIN LINK -->

<p class="mt-4 text-center mb-0">

    Already have an account?

    <a href="login.jsp"
       class="fw-semibold text-decoration-none">

        Login

    </a>

</p>

</div>

</div>

</div>

</div>

</body>
</html>