<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<title>Forgot Password - Smart Mess</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">

<div class="container">

    <div class="row justify-content-center mt-5">

        <div class="col-md-5">

            <div class="card shadow p-4">

                <h3 class="text-center mb-4">
                    Forgot Password
                </h3>

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

                <form action="forgotPassword" method="post">

                    <!-- EMAIL -->

                    <div class="mb-3">

                        <label class="form-label">
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

                        <label class="form-label">
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

                    <div class="mb-3">

                        <label class="form-label">
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
                            class="btn btn-primary w-100">

                        Reset Password

                    </button>

                </form>

                <p class="mt-3 text-center">

                    <a href="login.jsp">

                        Back to Login

                    </a>

                </p>

            </div>

        </div>

    </div>

</div>

</body>
</html>