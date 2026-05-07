<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<title>Register - Smart Mess</title>

<!-- Bootstrap CSS -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">

<div class="container">

    <div class="row justify-content-center mt-5">

        <div class="col-md-5">

            <div class="card shadow p-4">

                <h3 class="text-center mb-3">
                    User Registration
                </h3>

                <%
                String msg = request.getParameter("msg");

                String type = request.getParameter("type");

                if (msg != null) {
                %>

                <div class="alert <%= type != null && type.equals("success")
                        ? "alert-success"
                        : "alert-danger" %>">

                    <%= msg %>

                </div>

                <%
                }
                %>

                <form action="<%=request.getContextPath()%>/register"
                      method="post">

                    <!-- NAME -->

                    <div class="mb-3">

                        <label class="form-label">
                            Name
                        </label>

                        <input type="text"
                               name="name"
                               class="form-control"
                               placeholder="Enter Name"
                               required>

                    </div>

                    <!-- EMAIL -->

                    <div class="mb-3">

                        <label class="form-label">
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

                        <label class="form-label">
                            Phone Number
                        </label>

                        <input type="text"
                               name="phone"
                               class="form-control"
                               placeholder="Enter Phone Number"
                               pattern="[0-9]{10}"
                               maxlength="10"
                               required>

                    </div>

                    <!-- PASSWORD -->

                    <div class="mb-3">

                        <label class="form-label">
                            Password
                        </label>

                        <input type="password"
                               name="password"
                               class="form-control"
                               placeholder="Enter Password"
                               required>

                    </div>

                    <!-- BUTTON -->

                    <button type="submit"
                            class="btn btn-success w-100">

                        Register

                    </button>

                </form>

                <p class="mt-3 text-center">

                    Already have an account?

                    <a href="login.jsp">
                        Login
                    </a>

                </p>

            </div>

        </div>

    </div>

</div>

</body>
</html>