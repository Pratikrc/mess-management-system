<%@ page language="java"
         contentType="text/html; charset=UTF-8"
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

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>View Attendance</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet">

</head>

<body class="bg-light">

<!-- 🔥 NAVBAR -->

<nav class="navbar navbar-dark bg-dark">

<div class="container-fluid">

<span class="navbar-brand">

    Attendance

</span>

<a href="dashboard.jsp"
   class="btn btn-light btn-sm">

    Back

</a>

</div>

</nav>

<div class="container py-4">

<!-- 🔥 PAGE TITLE -->

<h3 class="mb-4 text-center text-md-start">

    📋 Attendance Records

</h3>

<!-- 🔥 TODAY COUNT -->

<%
int lunchCount = 0;

int dinnerCount = 0;

try {

    Connection con = DBConnection.getConnection();

    Statement st = con.createStatement();

    // 🍛 LUNCH COUNT
    ResultSet rs1 = st.executeQuery(

        "SELECT COUNT(*) FROM attendance " +
        "WHERE meal_type='Lunch' " +
        "AND status='Present' " +
        "AND meal_date=CURDATE()"
    );

    if (rs1.next()) {

        lunchCount = rs1.getInt(1);
    }

    // 🍽️ DINNER COUNT
    ResultSet rs2 = st.executeQuery(

        "SELECT COUNT(*) FROM attendance " +
        "WHERE meal_type='Dinner' " +
        "AND status='Present' " +
        "AND meal_date=CURDATE()"
    );

    if (rs2.next()) {

        dinnerCount = rs2.getInt(1);
    }

} catch (Exception e) {

    e.printStackTrace();
}
%>

<!-- 📊 SUMMARY CARDS -->

<div class="row mb-4">

<!-- LUNCH -->

<div class="col-lg-6 col-md-6 col-sm-12 mb-3">

<div class="card shadow-sm border-0 bg-success text-white">

<div class="card-body text-center">

<h5>

    🍛 Lunch Present

</h5>

<h2>

    <%= lunchCount %>

</h2>

</div>

</div>

</div>

<!-- DINNER -->

<div class="col-lg-6 col-md-6 col-sm-12 mb-3">

<div class="card shadow-sm border-0 bg-primary text-white">

<div class="card-body text-center">

<h5>

    🍽️ Dinner Present

</h5>

<h2>

    <%= dinnerCount %>

</h2>

</div>

</div>

</div>

</div>

<!-- 📤 EXPORT BUTTON -->

<div class="mb-4">

<a href="../exportAttendance"
   class="btn btn-success w-100 w-md-auto">

    📤 Export CSV

</a>

</div>

<!-- 📋 ATTENDANCE TABLE -->

<div class="card shadow-sm border-0">

<div class="card-body">

<div class="table-responsive">

<table class="table table-bordered table-striped table-hover align-middle">

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

        "SELECT * FROM attendance " +
        "ORDER BY meal_date DESC"
    );

    boolean hasData = false;

    while (rs.next()) {

        hasData = true;

        String mealType = rs.getString("meal_type");

        String status = rs.getString("status");
%>

<tr>

<!-- EMAIL -->

<td>

    <%= rs.getString("user_email") %>

</td>

<!-- DATE -->

<td>

    <%= rs.getString("meal_date") %>

</td>

<!-- MEAL TYPE -->

<td>

<span class="badge
    <%= "Lunch".equals(mealType)
        ? "bg-success"
        : "bg-primary" %>">

    <%= mealType %>

</span>

</td>

<!-- STATUS -->

<td>

<span class="badge
    <%= "Present".equals(status)
        ? "bg-success"
        : "bg-danger" %>">

    <%= status %>

</span>

</td>

</tr>

<%
    }

    if (!hasData) {
%>

<tr>

<td colspan="4"
    class="text-center text-danger py-4">

    No attendance records found

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

</div>

</div>

</div>

<!-- 🔙 BACK BUTTON -->

<div class="text-center mt-4">

<a href="dashboard.jsp"
   class="btn btn-secondary w-100 w-md-auto px-4">

    Back to Dashboard

</a>

</div>

</div>

</body>
</html>