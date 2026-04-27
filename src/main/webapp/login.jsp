<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Login - Smart Mess</title>

<!-- Bootstrap CSS -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">

<div class="container">
    <div class="row justify-content-center mt-5">
        <div class="col-md-4">

```
        <div class="card shadow p-4">

            <h3 class="text-center mb-3">User Login</h3>

            <%
            String msg = request.getParameter("msg");
            String type = request.getParameter("type");

            if (msg != null) {
            %>

            <div class="alert <%= type != null && type.equals("success") ? "alert-success" : "alert-danger" %>">
                <%= msg %>
            </div>

            <%
            }
            %>

            <form action="login" method="post">

                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" placeholder="Enter Email" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" placeholder="Enter Password" required>
                </div>

                <button type="submit" class="btn btn-primary w-100">Login</button>

            </form>

            <p class="mt-3 text-center">
                New user? <a href="register.jsp">Register</a>
            </p>

        </div>

    </div>
</div>
```

</div>

</body>
</html>
