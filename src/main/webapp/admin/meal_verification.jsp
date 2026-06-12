<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
String role = (String) session.getAttribute("role");

if (role == null || !role.equals("admin")) {

    response.sendRedirect("../login.jsp");

    return;
}

String search = request.getParameter("search");

if (search == null) {

    search = "";
}

int todayMeals = 0;

int servedMeals = 0;

int pendingMeals = 0;

try {

    Connection con = DBConnection.getConnection();

    Statement st = con.createStatement();

    // TODAY MEALS

    ResultSet rs1 = st.executeQuery(

        "SELECT COUNT(*) FROM attendance " +
        "WHERE meal_date=CURDATE()"
    );

    if (rs1.next()) {

        todayMeals = rs1.getInt(1);
    }

    // SERVED

    ResultSet rs2 = st.executeQuery(

        "SELECT COUNT(*) FROM attendance " +
        "WHERE served='Yes' " +
        "AND meal_date=CURDATE()"
    );

    if (rs2.next()) {

        servedMeals = rs2.getInt(1);
    }

    // PENDING

    ResultSet rs3 = st.executeQuery(

        "SELECT COUNT(*) FROM attendance " +
        "WHERE served='No' " +
        "AND meal_date=CURDATE()"
    );

    if (rs3.next()) {

        pendingMeals = rs3.getInt(1);
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

<title>Meal Verification</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet">

<link rel="stylesheet"
      href="../css/style.css">

</head>

<body>

<div class="container-fluid">

<div class="row">

<!-- ===================================
     SIDEBAR
=================================== -->

<div class="col-lg-2 col-md-3 bg-dark text-white min-vh-100 p-3">

<h3 class="text-center mb-4">

    Smart Mess

</h3>

<hr class="bg-light">

<div class="d-grid gap-2">

<a href="dashboard.jsp"
   class="btn btn-outline-light text-start">

    📊 Dashboard

</a>

<a href="manage_users.jsp"
   class="btn btn-outline-light text-start">

    👥 Manage Users

</a>

<a href="add_menu.jsp"
   class="btn btn-outline-light text-start">

    🍽️ Manage Menu

</a>

<a href="add_announcement.jsp"
   class="btn btn-outline-light text-start">

    📢 Announcement

</a>

<a href="view_attendance.jsp"
   class="btn btn-outline-light text-start">

    📋 Attendance

</a>

<a href="meal_verification.jsp"
   class="btn btn-outline-light text-start">

    ✅ Meal Verification

</a>

<a href="view_payments.jsp"
   class="btn btn-outline-light text-start">

    💳 Payments

</a>

<a href="view_subscription.jsp"
   class="btn btn-outline-light text-start">

    📅 Subscriptions

</a>

<a href="view_feedback.jsp"
   class="btn btn-outline-light text-start">

    💬 Feedback

</a>

<a href="reports.jsp"
   class="btn btn-outline-light text-start">

    📈 Reports

</a>

<a href="../logout"
   class="btn btn-danger text-start mt-3">

    🚪 Logout

</a>

</div>

</div>

<!-- ===================================
     MAIN CONTENT
=================================== -->

<div class="col-lg-10 col-md-9 p-4">
<!-- ===================================
     TOPBAR
=================================== -->

<div class="topbar d-flex justify-content-between align-items-center flex-wrap">

<div>

<h3 class="mb-1">

    🍽️ Meal Verification Center

</h3>

<p class="text-muted mb-0">

    Verify and serve meals to users

</p>

</div>

<div class="mt-2 mt-md-0">

<span class="badge bg-gradient-success p-3">

    Live Meal Monitoring

</span>

</div>

</div>

<!-- ===================================
     ANALYTICS CARDS
=================================== -->

<div class="row mb-4">

<!-- TOTAL -->

<div class="col-lg-4 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-primary h-100">

<div class="card-body">

<h5>

    🍛 Today's Meals

</h5>

<h2>

    <%= todayMeals %>

</h2>

<p class="mb-0">

    Total meal records today

</p>

</div>

</div>

</div>

<!-- SERVED -->

<div class="col-lg-4 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-success h-100">

<div class="card-body">

<h5>

    ✅ Meals Served

</h5>

<h2>

    <%= servedMeals %>

</h2>

<p class="mb-0">

    Successfully served meals

</p>

</div>

</div>

</div>

<!-- PENDING -->

<div class="col-lg-4 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-warning h-100">

<div class="card-body">

<h5>

    ⏳ Pending Meals

</h5>

<h2>

    <%= pendingMeals %>

</h2>

<p class="mb-0">

    Meals awaiting verification

</p>

</div>

</div>

</div>

</div>

<!-- ===================================
     SEARCH SECTION
=================================== -->

<div class="card border-0 mb-4 overflow-hidden">

<!-- HEADER -->

<div class="bg-gradient-primary text-white p-4">

<div class="d-flex justify-content-between align-items-center flex-wrap">

<div>

<h3 class="mb-1">

    🔍 Search User Meals

</h3>

<p class="mb-0 opacity-75">

    Search by user email for today's meals

</p>

</div>

<div style="font-size:50px; opacity:0.2;">

    🍽️

</div>

</div>

</div>

<!-- BODY -->

<div class="card-body p-4">

<form method="get">

<div class="input-group">

<input type="text"
       name="search"
       class="form-control"
       placeholder="Enter user email address"
       value="<%= search %>"
       required>

<button class="btn btn-primary"
        type="submit">

    Search

</button>

</div>

</form>

</div>

</div>

<!-- ===================================
     VERIFICATION TABLE
=================================== -->

<div class="card border-0">

<div class="card-body">

<div class="d-flex justify-content-between align-items-center flex-wrap mb-4">

<div>

<h4 class="mb-1">

    📋 Meal Verification Results

</h4>

<p class="text-muted mb-0">

    Today's user meal attendance and serving status

</p>

</div>

</div>

<div class="table-responsive">

<table class="table table-hover align-middle">

<thead>

<tr>

<th>User</th>

<th>Email</th>

<th>Meal</th>

<th>Status</th>

<th>Served</th>

<th>Action</th>

</tr>

</thead>

<tbody>

<%
if (!search.isEmpty()) {

    try {

        Connection con = DBConnection.getConnection();

        PreparedStatement ps = con.prepareStatement(

            "SELECT a.*, u.name " +
            "FROM attendance a " +
            "JOIN users u ON a.user_email=u.email " +
            "WHERE a.user_email=? " +
            "AND a.meal_date=CURDATE()"
        );

        ps.setString(1, search);

        ResultSet rs = ps.executeQuery();

        boolean found = false;

        while (rs.next()) {

            found = true;

            String mealType = rs.getString("meal_type");

            String status = rs.getString("status");

            String served = rs.getString("served");

            String userName = rs.getString("name");
%>

<tr>

<!-- USER -->

<td>

<div class="d-flex align-items-center">

<div class="me-3">

<div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center"
     style="width:45px; height:45px; font-weight:600;">

    <%= userName.substring(0,1).toUpperCase() %>

</div>

</div>

<div>

<h6 class="mb-0 fw-semibold">

    <%= userName %>

</h6>

<small class="text-muted">

    Verified User

</small>

</div>

</div>

</td>

<!-- EMAIL -->

<td>

    <%= rs.getString("user_email") %>

</td>

<!-- MEAL -->

<td>

<span class="badge
    <%= "Lunch".equals(mealType)
        ? "bg-success"
        : "bg-primary" %>">

    <%= "Lunch".equals(mealType)
        ? "🍛 Lunch"
        : "🍽️ Dinner" %>

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

<!-- SERVED -->

<td>

<%
if ("Yes".equals(served)) {
%>

<span class="badge bg-success">

    ✅ Served

</span>

<%
} else {
%>

<span class="badge bg-danger">

    ❌ Not Served

</span>

<%
}
%>

</td>

<!-- ACTION -->

<td>

<%
if ("No".equals(served)) {
%>

<a href="../serveMeal?id=<%= rs.getInt("id") %>"
   class="btn btn-success btn-sm px-3">

    🍽️ Serve Meal

</a>

<%
} else {
%>

<button class="btn btn-outline-success btn-sm"
        disabled>

    Served

</button>

<%
}
%>

</td>

</tr>

<%
        }

        if (!found) {
%>

<tr>

<td colspan="6"
    class="text-center py-5">

<div style="font-size:70px;">

    🔍

</div>

<h3 class="mt-3">

    No Attendance Found

</h3>

<p class="text-muted">

    No meal attendance found for today.

</p>

</td>

</tr>

<%
        }

    } catch (Exception e) {

        e.printStackTrace();
    }

} else {
%>

<tr>

<td colspan="6"
    class="text-center py-5">

<div style="font-size:70px;">

    🍽️

</div>

<h3 class="mt-3">

    Search User to Verify Meals

</h3>

<p class="text-muted">

    Enter a user email above to verify today's meals.

</p>

</td>

</tr>

<%
}
%>

</tbody>

</table>

</div>

</div>

</div>

<!-- ===================================
     QUICK ACTIONS
=================================== -->

<div class="card mt-4">

<div class="card-body">

<div class="row text-center">

<div class="col-md-4 mb-3 mb-md-0">

<a href="dashboard.jsp"
   class="btn btn-primary w-100 py-3">

    🏠 Dashboard

</a>

</div>

<div class="col-md-4 mb-3 mb-md-0">

<a href="view_attendance.jsp"
   class="btn btn-success w-100 py-3">

    📋 Attendance

</a>

</div>

<div class="col-md-4">

<a href="reports.jsp"
   class="btn btn-dark w-100 py-3">

    📊 Reports

</a>

</div>

</div>

</div>

</div>

</div>

</div>

</div>

</body>
</html>