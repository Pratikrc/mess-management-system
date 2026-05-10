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

int lunchCount = 0;

int dinnerCount = 0;

int totalAttendance = 0;

int presentCount = 0;

int absentCount = 0;

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

    // 📊 TOTAL ATTENDANCE

    ResultSet rs3 = st.executeQuery(

        "SELECT COUNT(*) FROM attendance"
    );

    if (rs3.next()) {

        totalAttendance = rs3.getInt(1);
    }

    // ✅ PRESENT COUNT

    ResultSet rs4 = st.executeQuery(

        "SELECT COUNT(*) FROM attendance " +
        "WHERE status='Present'"
    );

    if (rs4.next()) {

        presentCount = rs4.getInt(1);
    }

    // ❌ ABSENT COUNT

    ResultSet rs5 = st.executeQuery(

        "SELECT COUNT(*) FROM attendance " +
        "WHERE status='Absent'"
    );

    if (rs5.next()) {

        absentCount = rs5.getInt(1);
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

<title>View Attendance</title>

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

    📋 Attendance Analytics

</h3>

<p class="text-muted mb-0">

    Monitor user meal attendance records

</p>

</div>

<div class="mt-2 mt-md-0">

<span class="badge bg-gradient-primary p-3">

    Live Attendance Monitoring

</span>

</div>

</div>

<!-- ===================================
     ANALYTICS CARDS
=================================== -->

<div class="row mb-4">

<!-- TOTAL -->

<div class="col-lg-3 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-primary h-100">

<div class="card-body">

<h5>

    📊 Total Records

</h5>

<h2>

    <%= totalAttendance %>

</h2>

<p class="mb-0">

    All attendance entries

</p>

</div>

</div>

</div>

<!-- PRESENT -->

<div class="col-lg-3 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-success h-100">

<div class="card-body">

<h5>

    ✅ Present

</h5>

<h2>

    <%= presentCount %>

</h2>

<p class="mb-0">

    Total present meals

</p>

</div>

</div>

</div>

<!-- ABSENT -->

<div class="col-lg-3 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-danger h-100">

<div class="card-body">

<h5>

    ❌ Absent

</h5>

<h2>

    <%= absentCount %>

</h2>

<p class="mb-0">

    Total absent meals

</p>

</div>

</div>

</div>

<!-- TODAY -->

<div class="col-lg-3 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-warning h-100">

<div class="card-body">

<h5>

    📅 Today's Meals

</h5>

<h2>

    <%= lunchCount + dinnerCount %>

</h2>

<p class="mb-0">

    Today's present meals

</p>

</div>

</div>

</div>

</div>

<!-- ===================================
     TODAY SUMMARY
=================================== -->

<div class="row mb-4">

<!-- LUNCH -->

<div class="col-lg-6 col-md-6 mb-4">

<div class="card border-0 bg-gradient-success text-white h-100">

<div class="card-body text-center p-4">

<div style="font-size:60px;">

    🍛

</div>

<h4 class="mt-3">

    Lunch Attendance

</h4>

<h1 class="fw-bold">

    <%= lunchCount %>

</h1>

<p class="mb-0">

    Present students today

</p>

</div>

</div>

</div>

<!-- DINNER -->

<div class="col-lg-6 col-md-6 mb-4">

<div class="card border-0 bg-gradient-primary text-white h-100">

<div class="card-body text-center p-4">

<div style="font-size:60px;">

    🍽️

</div>

<h4 class="mt-3">

    Dinner Attendance

</h4>

<h1 class="fw-bold">

    <%= dinnerCount %>

</h1>

<p class="mb-0">

    Present students today

</p>

</div>

</div>

</div>

</div>

<!-- ===================================
     ACTION BAR
=================================== -->

<div class="card border-0 mb-4">

<div class="card-body">

<div class="d-flex justify-content-between align-items-center flex-wrap">

<div>

<h4 class="mb-1">

    📤 Export Attendance Data

</h4>

<p class="text-muted mb-0">

    Download attendance records as CSV

</p>

</div>

<div class="mt-3 mt-md-0">

<a href="../exportAttendance"
   class="btn btn-success px-4 py-3">

    📤 Export CSV

</a>

</div>

</div>

</div>

</div>

<!-- ===================================
     ATTENDANCE TABLE
=================================== -->

<div class="card border-0">

<div class="card-body">

<div class="d-flex justify-content-between align-items-center flex-wrap mb-4">

<div>

<h4 class="mb-1">

    📋 Attendance Records

</h4>

<p class="text-muted mb-0">

    Complete attendance history

</p>

</div>

</div>

<div class="table-responsive">

<table class="table table-hover align-middle">

<thead>

<tr>

<th>User</th>

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

        String userEmail = rs.getString("user_email");
%>

<tr>

<!-- USER -->

<td>

<div class="d-flex align-items-center">

<div class="me-3">

<div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center"
     style="width:42px; height:42px; font-weight:600;">

    <%= userEmail.substring(0,1).toUpperCase() %>

</div>

</div>

<div>

<h6 class="mb-0 fw-semibold">

    <%= userEmail %>

</h6>

<small class="text-muted">

    Smart Mess User

</small>

</div>

</div>

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

</tr>

<%
    }

    if (!hasData) {
%>

<tr>

<td colspan="4"
    class="text-center py-5">

<div style="font-size:70px;">

    📋

</div>

<h3 class="mt-3">

    No Attendance Records Found

</h3>

<p class="text-muted">

    No attendance data available yet.

</p>

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

<a href="reports.jsp"
   class="btn btn-success w-100 py-3">

    📊 Reports

</a>

</div>

<div class="col-md-4">

<a href="manage_users.jsp"
   class="btn btn-dark w-100 py-3">

    👥 Users

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