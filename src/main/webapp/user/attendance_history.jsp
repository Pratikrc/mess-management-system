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

int presentMeals = 0;

int absentMeals = 0;

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

    // 🔥 TOTAL MEALS

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

    // 🔥 PRESENT COUNT

    PreparedStatement psPresent = con.prepareStatement(

        "SELECT COUNT(*) FROM attendance " +
        "WHERE user_email=? " +
        "AND status='Present' " +
        "AND meal_date BETWEEN ? AND ?"
    );

    psPresent.setString(1, email);

    psPresent.setString(2, startDate);

    psPresent.setString(3, endDate);

    ResultSet rsPresent = psPresent.executeQuery();

    if (rsPresent.next()) {

        presentMeals = rsPresent.getInt(1);
    }

    // 🔥 ABSENT COUNT

    PreparedStatement psAbsent = con.prepareStatement(

        "SELECT COUNT(*) FROM attendance " +
        "WHERE user_email=? " +
        "AND status='Absent' " +
        "AND meal_date BETWEEN ? AND ?"
    );

    psAbsent.setString(1, email);

    psAbsent.setString(2, startDate);

    psAbsent.setString(3, endDate);

    ResultSet rsAbsent = psAbsent.executeQuery();

    if (rsAbsent.next()) {

        absentMeals = rsAbsent.getInt(1);
    }

} catch (Exception e) {

    e.printStackTrace();
}
%>
<%@ include file="auth_check.jsp" %>
<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Attendance History</title>

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
            🏠 Dashboard

        </a>

        <!-- VIEW MENU -->

        <a href="view_menu.jsp"
          class="btn btn-outline-light text-start">

            🍽️ View Menu

        </a>

        <!-- ATTENDANCE -->

        <a href="attendance.jsp"
          class="btn btn-outline-light text-start">
            📋 Attendance

        </a>

        <!-- ATTENDANCE HISTORY -->

        <a href="attendance_history.jsp"
           class="btn btn-outline-light text-start">

            📊 Attendance History

        </a>

        <!-- SUBSCRIPTION -->

        <a href="subscription.jsp"
           class="btn btn-outline-light text-start">

            🗓️ Subscription

        </a>

        <!-- PAYMENTS -->

        <a href="view_payment.jsp"
           class="btn btn-outline-light text-start">

            💳 Payments

        </a>

        <!-- SKIP DAY -->

        <a href="skip_day.jsp"
          class="btn btn-outline-light text-start">

            ⏭️ Skip Day

        </a>

        <!-- FEEDBACK -->

        <a href="feedback.jsp"
           class="btn btn-outline-light text-start">

            💬 Feedback

        </a>

        <!-- LOGOUT -->

        <a href="../logout"
           class="btn btn-danger text-start mt-3">

            🚪 Logout

        </a>

    </div>

</div>

<!-- ===================================
     MAIN CONTENT
=================================== -->

<div class="col-lg-10 col-md-9 p-4 main-content">

<!-- ===================================
     TOPBAR
=================================== -->

<div class="topbar d-flex justify-content-between align-items-center flex-wrap">

<div>

<h3 class="mb-1">

    📊 Attendance Analytics

</h3>

<p class="text-muted mb-0">

    Track your meal attendance records

</p>

</div>

<div class="mt-2 mt-md-0">

<span class="badge bg-gradient-primary p-3">

    Subscription Period

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

    🍛 Total Meals

</h5>

<h2>

    <%= totalMeals %>

</h2>

<p class="mb-0">

    Total recorded meals

</p>

</div>

</div>

</div>

<!-- PRESENT -->

<div class="col-lg-4 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-success h-100">

<div class="card-body">

<h5>

    ✅ Present Meals

</h5>

<h2>

    <%= presentMeals %>

</h2>

<p class="mb-0">

    Meals attended

</p>

</div>

</div>

</div>

<!-- ABSENT -->

<div class="col-lg-4 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-danger h-100">

<div class="card-body">

<h5>

    ❌ Absent Meals

</h5>

<h2>

    <%= absentMeals %>

</h2>

<p class="mb-0">

    Meals skipped

</p>

</div>

</div>

</div>

</div>

<!-- ===================================
     PERIOD CARD
=================================== -->

<div class="card glass-card mb-4">

<div class="card-body">

<div class="row align-items-center">

<div class="col-md-8">

<h4 class="mb-3">

    📅 Subscription Attendance Period

</h4>

<p class="text-muted mb-0">

    Your attendance history between:

</p>

<h5 class="mt-2">

    <%= startDate %>
    →
    <%= endDate %>

</h5>

</div>

<div class="col-md-4 text-md-end mt-3 mt-md-0">

<span class="badge bg-gradient-success p-3">

    Active Tracking

</span>

</div>

</div>

</div>

</div>

<!-- ===================================
     TABLE SECTION
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

        String mealType = rs.getString("meal_type");
%>

<tr>

<td class="fw-semibold">

    <%= count++ %>

</td>

<td>

    <%= rs.getString("meal_date") %>

</td>

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

<div style="font-size:60px;">

    📭

</div>

<h4 class="mt-3">

    No Attendance Records Found

</h4>

<p class="text-muted">

    No attendance records available for this subscription period.

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

<a href="attendance.jsp"
   class="btn btn-success w-100 py-3">

    📋 Mark Attendance

</a>

</div>

<div class="col-md-4 mb-3 mb-md-0">

<a href="view_menu.jsp"
   class="btn btn-dark w-100 py-3">

    🍽️ View Menu

</a>

</div>

<div class="col-md-4">

<a href="dashboard.jsp"
   class="btn btn-primary w-100 py-3">

    🏠 Dashboard

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