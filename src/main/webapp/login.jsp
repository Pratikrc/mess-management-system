<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Login - Smart Mess</title>

<style>
    body {
        font-family: Arial;
        background-color: #f4f4f4;
        text-align: center;
    }

    .container {
        width: 350px;
        margin: 80px auto;
        padding: 20px;
        background: white;
        border-radius: 10px;
        box-shadow: 0px 0px 10px gray;
    }

    input {
        width: 90%;
        padding: 10px;
        margin: 10px 0;
    }

    button {
        padding: 10px 20px;
        background-color: blue;
        color: white;
        border: none;
        cursor: pointer;
    }

    a {
        text-decoration: none;
        color: blue;
    }
</style>

</head>

<body>

<div class="container">
    <h2>User Login</h2>

```
<form action="<%=request.getContextPath()%>/login" method="post">
    <input type="email" name="email" placeholder="Enter Email" required>
    <input type="password" name="password" placeholder="Enter Password" required>

    <button type="submit">Login</button>
</form>

<br>
<p>New user? <a href="register.jsp">Register</a></p>
```

</div>

</body>
</html>
