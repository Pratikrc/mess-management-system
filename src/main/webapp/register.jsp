<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Register - Smart Mess</title>

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
        background-color: green;
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
    <h2>User Registration</h2>

```
<form action="register" method="post">
    <input type="text" name="name" placeholder="Enter Name" required>
    <input type="email" name="email" placeholder="Enter Email" required>
    <input type="password" name="password" placeholder="Enter Password" required>

    <button type="submit">Register</button>
</form>

<br>
<p>Already have an account? <a href="login.jsp">Login</a></p>
```

</div>

</body>
</html>
