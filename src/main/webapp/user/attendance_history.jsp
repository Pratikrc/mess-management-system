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

String startDate = "";
String endDate = "";

int totalMeals = 0;

try {

    Connection con = DBConnection.getConnection();

    // 🔥 GET CURRENT SUBSCRIPTION
    PreparedStatement psSub = con.prepareStatement(

        "SELECT start_date, end_date " +
        "FROM subscription " +
        "WHERE user_email=? " +
        "ORDER BY end_date DESC LIMIT 1"
    );

    psSub.setString(1, email);

    ResultSet rsSub = psSub.executeQuery();

    if (rsSub.next()) {

        startDate = rsSub.getString("start_date");

        endDate = rsSub.getString("end_date");
    }

    // 🔥 COUNT TOTAL MEALS
    PreparedStatement psCount = con.prepareStatement(

        "SELECT COUNT(*) FROM attendance " +
        "WHERE user_email=? " +
        "AND meal_date BETWEEN ? AND ?"
    );

    psCount.setString(1, email);

    psCount.setString(2, startDate);

    psCount.setString(3, endDate);

    ResultSet rsCount = psCount.executeQuery();

    if (rsCount.next()) {

        totalMeals = rsCount.getInt(1);
    }

} catch (Exception e) {

    e.printStackTrace();
}
%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Attendance History</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet">

</head>

<body class="bg-light">

<!-- 🔥 NAVBAR -->

<nav class="navbar navbar-dark bg-dark">

    <div class="container-fluid">

        <span class="navbar-brand">
            Monthly Attendance
        </span>

        <a href="dashboard.jsp"
           class="btn btn-light btn-sm">

            Back

        </a>

    </div>

</nav>

<div class="container py-4">

<!-- 🔥 PAGE TITLE -->

<h3 class="mb-4 text-center">

    Subscription Period Attendance

</h3>

<!-- 🔥 SUMMARY CARD -->

<div class="card shadow-sm border-0 mb-4">

<div class="card-body text-center">

<h5 class="mb-3">

    Total Meals (This Subscription)

</h5>

<h2 class="text-primary">

    <%= totalMeals %>

</h2>

<p class="text-muted mb-0">

    <%= startDate %>
    to
    <%= endDate %>

</p>

</div>

</div>

<!-- 🔥 RESPONSIVE TABLE -->

<div class="card shadow-sm border-0">

<div class="card-body">

<div class="table-responsive">

<table class="table table-bordered table-striped table-hover text-center align-middle">

<thead class="table-dark">

<tr>

    <th>#</th>

    <th>Date</th>

    <th>Meal Type</th>

    <th>Status</th>

</tr>

</thead>

<tbody>

<%
try {

    Connection con = DBConnection.getConnection();

    PreparedStatement ps = con.prepareStatement(

        "SELECT * FROM attendance " +
        "WHERE user_email=? " +
        "AND meal_date BETWEEN ? AND ? " +
        "ORDER BY meal_date DESC"
    );

    ps.setString(1, email);

    ps.setString(2, startDate);

    ps.setString(3, endDate);

    ResultSet rs = ps.executeQuery();

    boolean hasData = false;

    int count = 1;

    while (rs.next()) {

        hasData = true;

        String status = rs.getString("status");
%>

<tr>

    <td>
        <%= count++ %>
    </td>

    <td>
        <%= rs.getString("meal_date") %>
    </td>

    <td>

        <%= rs.getString("meal_type").equals("Lunch")
            ? "🍛 Lunch"
            : "🍽️ Dinner" %>

    </td>

    <td>

        <span class="badge
            <%= status.equals("Present")
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

        No attendance records found for this subscription period

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