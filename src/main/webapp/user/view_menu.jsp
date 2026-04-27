<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
if (session.getAttribute("email") == null) {
response.sendRedirect("../login.jsp");
return;
}

String email = (String) session.getAttribute("email");

boolean allowed = false;

try {
Connection con = DBConnection.getConnection();


PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM subscription WHERE user_email=? ORDER BY end_date DESC LIMIT 1"
);

ps.setString(1, email);
ResultSet rs = ps.executeQuery();

if (rs.next()) {
    java.sql.Date endDate = rs.getDate("end_date");

    if (endDate.getTime() >= System.currentTimeMillis()) {
        allowed = true;
    }
}


} catch (Exception e) {
e.printStackTrace();
}

if (!allowed) {
response.sendRedirect("subscription.jsp?msg=Please subscribe to continue&type=error");
return;
}
%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Today's Menu</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">Today's Menu</span>
        <a href="dashboard.jsp" class="btn btn-light">Back</a>
    </div>
</nav>

<div class="container mt-4">

```
<h3 class="mb-3">Today's Menu</h3>

<table class="table table-bordered table-striped">

    <thead class="table-dark">
        <tr>
            <th>Meal Type</th>
            <th>Description</th>
        </tr>
    </thead>

    <tbody>

    <%
    try {
        Connection con = DBConnection.getConnection();

        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM menu WHERE meal_date = CURDATE()"
        );

        ResultSet rs = ps.executeQuery();

        boolean hasData = false;

        while (rs.next()) {
            hasData = true;
    %>

    <tr>
        <td><%= rs.getString("meal_type") %></td>
        <td><%= rs.getString("description") %></td>
    </tr>

    <%
        }

        if (!hasData) {
    %>

    <tr>
        <td colspan="2" class="text-center text-danger">
            No menu available for today
        </td>
    </tr>

    <%
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
    %>

    </tbody>

</table>
```

</div>

</body>
</html>
