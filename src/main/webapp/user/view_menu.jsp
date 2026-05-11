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

        "SELECT * FROM subscription " +
        "WHERE user_email=? " +
        "ORDER BY end_date DESC LIMIT 1"
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

    response.sendRedirect(
        "subscription.jsp?msg=Please subscribe to continue&type=error"
    );

    return;
}
%>
<%@ include file="auth_check.jsp" %>
<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Today's Menu</title>

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

    🍽️ Today's Menu

</h3>

<p class="text-muted mb-0">

    Explore today's delicious meals

</p>

</div>

<div class="mt-2 mt-md-0">

<span class="badge bg-gradient-success p-3">

    Fresh Meals Available

</span>

</div>

</div>

<!-- ===================================
     MENU SECTION
=================================== -->

<div class="row">

<%
try {

    Connection con = DBConnection.getConnection();

    PreparedStatement ps = con.prepareStatement(

        "SELECT * FROM menu " +
        "WHERE meal_date = CURDATE()"
    );

    ResultSet rs = ps.executeQuery();

    boolean hasData = false;

    while (rs.next()) {

        hasData = true;

        String mealType = rs.getString("meal_type");

        String description = rs.getString("description");

        String cardColor = "primary";

        String emoji = "🍽️";

        String gradient = "bg-gradient-primary";

        if ("Lunch".equalsIgnoreCase(mealType)) {

            cardColor = "success";

            gradient = "bg-gradient-success";

            emoji = "🍛";

        } else if ("Dinner".equalsIgnoreCase(mealType)) {

            cardColor = "primary";

            gradient = "bg-gradient-primary";

            emoji = "🍽️";

        } else if ("Special".equalsIgnoreCase(mealType)) {

            cardColor = "warning";

            gradient = "bg-gradient-warning";

            emoji = "🎉";
        }
%>

<!-- ===================================
     MENU CARD
=================================== -->

<div class="col-xl-6 col-lg-6 col-md-12 mb-4">

<div class="card border-0 h-100 overflow-hidden">

<!-- CARD HEADER -->

<div class="<%= gradient %> text-white p-4">

<div class="d-flex justify-content-between align-items-center">

<div>

<h3 class="mb-1">

    <%= emoji %>
    <%= mealType %>

</h3>

<p class="mb-0 opacity-75">

    Freshly prepared for today

</p>

</div>

<div style="font-size:48px; opacity:0.2;">

    <%= emoji %>

</div>

</div>

</div>

<!-- CARD BODY -->

<div class="card-body d-flex flex-column justify-content-between">

<div>

<h5 class="mb-3">

    Meal Description

</h5>

<p class="text-muted fs-6 lh-lg">

    <%= description %>

</p>

</div>

<!-- FOOTER -->

<div class="mt-4">

<div class="d-flex justify-content-between align-items-center flex-wrap">

<span class="badge bg-light text-dark border px-3 py-2">

    Today's Special

</span>

<span class="text-success fw-semibold mt-2 mt-md-0">

    ✔ Available Today

</span>

</div>

</div>

</div>

</div>

</div>

<%
    }

    if (!hasData) {
%>

<div class="col-12">

<div class="card border-0 shadow-soft">

<div class="card-body text-center py-5">

<div style="font-size:70px;">

    🍽️

</div>

<h3 class="mt-3 mb-3">

    No Menu Available

</h3>

<p class="text-muted mb-4">

    Today's menu has not been updated yet.

</p>

<a href="dashboard.jsp"
   class="btn btn-primary px-4">

    Back to Dashboard

</a>

</div>

</div>

</div>

<%
    }

} catch (Exception e) {

    e.printStackTrace();
}
%>

</div>

<!-- ===================================
     FOOTER ACTIONS
=================================== -->

<div class="card mt-2">

<div class="card-body">

<div class="row text-center">

<div class="col-md-4 mb-3 mb-md-0">

<a href="attendance.jsp"
   class="btn btn-success w-100 py-3">

    📋 Mark Attendance

</a>

</div>

<div class="col-md-4 mb-3 mb-md-0">

<a href="subscription.jsp"
   class="btn btn-dark w-100 py-3">

    📅 View Subscription

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