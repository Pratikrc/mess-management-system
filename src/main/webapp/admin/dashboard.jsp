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

// 📊 VARIABLES

int totalUsers = 0;

int activeSubs = 0;

int lunchCount = 0;

int dinnerCount = 0;

try {

    Connection con = DBConnection.getConnection();

    Statement st = con.createStatement();

    // 👥 TOTAL USERS

    ResultSet rs1 = st.executeQuery(

        "SELECT COUNT(*) FROM users " +
        "WHERE role='user'"
    );

    if (rs1.next()) {

        totalUsers = rs1.getInt(1);
    }

    // 💳 ACTIVE SUBSCRIPTIONS

    ResultSet rs2 = st.executeQuery(

        "SELECT COUNT(DISTINCT user_email) " +
        "FROM subscription " +
        "WHERE end_date >= CURDATE()"
    );

    if (rs2.next()) {

        activeSubs = rs2.getInt(1);
    }

    // 🍛 LUNCH COUNT

    ResultSet rs3 = st.executeQuery(

        "SELECT COUNT(*) FROM attendance " +
        "WHERE meal_type='Lunch' " +
        "AND status='Present' " +
        "AND meal_date=CURDATE()"
    );

    if (rs3.next()) {

        lunchCount = rs3.getInt(1);
    }

    // 🍽️ DINNER COUNT

    ResultSet rs4 = st.executeQuery(

        "SELECT COUNT(*) FROM attendance " +
        "WHERE meal_type='Dinner' " +
        "AND status='Present' " +
        "AND meal_date=CURDATE()"
    );

    if (rs4.next()) {

        dinnerCount = rs4.getInt(1);
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

<title>Admin Dashboard</title>

<!-- Bootstrap -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet">

<!-- Custom CSS -->

<link rel="stylesheet"
      href="../css/style.css">

</head>

<body class="bg-light">

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

<!-- 🔥 TOPBAR -->

<div class="d-flex justify-content-between align-items-center mb-4 flex-wrap">

<div>

<h3>

    Welcome,
    <%= session.getAttribute("user") %>

</h3>

<p class="text-muted mb-0">

    Admin Control Panel

</p>

</div>

</div>

<!-- ===================================
     DASHBOARD STATS
=================================== -->

<div class="row">

<!-- USERS -->

<div class="col-lg-3 col-md-6 col-sm-6 mb-4">

<div class="card dashboard-card bg-gradient-primary h-100">

<div class="card-body text-center">

<h5>

    👥 Total Users

</h5>

<h2>

    <%= totalUsers %>

</h2>

</div>

</div>

</div>

<!-- SUBSCRIPTIONS -->

<div class="col-lg-3 col-md-6 col-sm-6 mb-4">

<div class="card dashboard-card bg-gradient-success h-100">

<div class="card-body text-center">

<h5>

    💳 Active Subs

</h5>

<h2>

    <%= activeSubs %>

</h2>

</div>

</div>

</div>

<!-- LUNCH -->

<div class="col-lg-3 col-md-6 col-sm-6 mb-4">

<div class="card dashboard-card bg-gradient-warning h-100">

<div class="card-body text-center">

<h5>

    🍛 Lunch Count

</h5>

<h2>

    <%= lunchCount %>

</h2>

</div>

</div>

</div>

<!-- DINNER -->

<div class="col-lg-3 col-md-6 col-sm-6 mb-4">

<div class="card dashboard-card bg-gradient-danger h-100">

<div class="card-body text-center">

<h5>

    🍽️ Dinner Count

</h5>

<h2>

    <%= dinnerCount %>

</h2>

</div>

</div>

</div>

</div>

<!-- ===================================
     QUICK ACTIONS
=================================== -->

<div class="card shadow-sm border-0">

<div class="card-body">

<h4 class="mb-4">

    ⚡ Quick Actions

</h4>

<div class="row">

<!-- USERS -->

<div class="col-lg-4 col-md-6 col-sm-12 mb-3">

<a href="manage_users.jsp"
   class="btn btn-primary w-100 py-3">

    Manage Users

</a>

</div>

<!-- PAYMENTS -->

<div class="col-lg-4 col-md-6 col-sm-12 mb-3">

<a href="view_payments.jsp"
   class="btn btn-success w-100 py-3">

    View Payments

</a>

</div>

<!-- REPORTS -->

<div class="col-lg-4 col-md-6 col-sm-12 mb-3">

<a href="reports.jsp"
   class="btn btn-warning w-100 py-3">

    View Reports

</a>

</div>

<!-- MENU -->

<div class="col-lg-4 col-md-6 col-sm-12 mb-3">

<a href="add_menu.jsp"
   class="btn btn-info w-100 py-3">

    Manage Menu

</a>

</div>

<!-- ATTENDANCE -->

<div class="col-lg-4 col-md-6 col-sm-12 mb-3">

<a href="view_attendance.jsp"
   class="btn btn-dark w-100 py-3">

    Attendance

</a>

</div>

<!-- FEEDBACK -->

<div class="col-lg-4 col-md-6 col-sm-12 mb-3">

<a href="view_feedback.jsp"
   class="btn btn-secondary w-100 py-3">

    Feedback

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