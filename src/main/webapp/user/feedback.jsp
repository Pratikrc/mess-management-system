<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%
if (session.getAttribute("email") == null) {

    response.sendRedirect("../login.jsp");

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

<title>Feedback</title>

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

    💬 Feedback Center

</h3>

<p class="text-muted mb-0">

    Share your experience and suggestions

</p>

</div>

<div class="mt-2 mt-md-0">

<span class="badge bg-gradient-primary p-3">

    Support Portal

</span>

</div>

</div>

<!-- ===================================
     CONTENT
=================================== -->

<div class="row justify-content-center">

<!-- FEEDBACK FORM -->

<div class="col-lg-7 col-md-10 mb-4">

<div class="card border-0 overflow-hidden">

<!-- HEADER -->

<div class="bg-gradient-primary text-white p-4">

<div class="d-flex justify-content-between align-items-center">

<div>

<h3 class="mb-1">

    💬 Give Feedback

</h3>

<p class="mb-0 opacity-75">

    Help us improve your mess experience

</p>

</div>

<div style="font-size:50px; opacity:0.2;">

    💬

</div>

</div>

</div>

<!-- BODY -->

<div class="card-body p-4">

<!-- MESSAGE -->

<%
String msg = request.getParameter("msg");

String type = request.getParameter("type");

if (msg != null) {
%>

<div class="alert
    <%= "success".equals(type)
        ? "alert-success"
        : "alert-danger" %> shadow-soft mb-4">

    <%= msg %>

</div>

<%
}
%>

<!-- FORM -->

<form action="<%=request.getContextPath()%>/feedback"
      method="post">

<div class="mb-4">

<label class="form-label fw-bold mb-3">

    Your Feedback

</label>

<textarea name="message"
          class="form-control"
          rows="8"
          placeholder="Write your suggestions, issues, or experience here..."
          required></textarea>

<p class="text-muted mt-2 mb-0">

    Your feedback helps improve Smart Mess services.

</p>

</div>

<button type="submit"
        class="btn btn-primary w-100 py-3">

    🚀 Submit Feedback

</button>

</form>

</div>

</div>

</div>

<!-- SIDE INFO -->

<div class="col-lg-4 col-md-10 mb-4">

<!-- SUPPORT CARD -->

<div class="card border-0 mb-4">

<div class="card-body text-center">

<div style="font-size:60px;">

    ⭐

</div>

<h4 class="mt-3 mb-3">

    We Value Feedback

</h4>

<p class="text-muted">

    Your suggestions help us improve meal quality,
    attendance systems, and overall experience.

</p>

</div>

</div>

<!-- QUICK ACTIONS -->

<div class="card border-0">

<div class="card-body">

<h4 class="mb-4">

    ⚡ Quick Actions

</h4>

<div class="d-grid gap-3">

<a href="dashboard.jsp"
   class="btn btn-primary py-3">

    🏠 Dashboard

</a>

<a href="view_menu.jsp"
   class="btn btn-success py-3">

    🍽️ View Menu

</a>

<a href="attendance.jsp"
   class="btn btn-dark py-3">

    📋 Attendance

</a>

</div>

</div>

</div>

</div>

</div>

</div>

</div>

</div>

</body>
</html>