<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
String email = (String) session.getAttribute("email");
String role = (String) session.getAttribute("role");

if (email == null || role == null || !role.equals("admin")) {
response.sendRedirect("../login.jsp");
return;
}
%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>View Attendance</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">Attendance</span>
        <a href="dashboard.jsp" class="btn btn-light">Back</a>
    </div>
</nav>

<div class="container mt-4">

```
<h3 class="mb-3">Attendance Records</h3>

<!-- 🔥 TODAY COUNT -->
<%
int lunchCount = 0;
int dinnerCount = 0;

try {
    Connection con = DBConnection.getConnection();
    Statement st = con.createStatement();

    ResultSet rs1 = st.executeQuery(
        "SELECT COUNT(*) FROM attendance WHERE meal_type='Lunch' AND status='Present' AND meal_date=CURDATE()"
    );
    if (rs1.next()) {
        lunchCount = rs1.getInt(1);
    }

    ResultSet rs2 = st.executeQuery(
        "SELECT COUNT(*) FROM attendance WHERE meal_type='Dinner' AND status='Present' AND meal_date=CURDATE()"
    );
    if (rs2.next()) {
        dinnerCount = rs2.getInt(1);
    }

} catch (Exception e) {
    e.printStackTrace();
}
%>

<div class="row mb-3">
    <div class="col-md-6">
        <div class="alert alert-success text-center">
            Lunch Present: <strong><%= lunchCount %></strong>
        </div>
    </div>
    <div class="col-md-6">
        <div class="alert alert-primary text-center">
            Dinner Present: <strong><%= dinnerCount %></strong>
        </div>
    </div>
</div>

<a href="../exportAttendance" class="btn btn-success mb-3">Export CSV</a>

<table class="table table-bordered table-striped table-hover">

    <thead class="table-dark">
        <tr>
            <th>Email</th>
            <th>Date</th>
            <th>Meal Type</th>
            <th>Status</th>
        </tr>
    </thead>

    <tbody>

    <%
    try {
        Connection con = DBConnection.getConnection();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(
            "SELECT * FROM attendance ORDER BY meal_date DESC"
        );

        while (rs.next()) {
    %>

    <tr>
        <td><%= rs.getString("user_email") %></td>
        <td><%= rs.getString("meal_date") %></td>
        <td><%= rs.getString("meal_type") %></td>
        <td><%= rs.getString("status") %></td>
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
