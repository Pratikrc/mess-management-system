<%
if (session.getAttribute("email") == null) {

    response.sendRedirect("../login.jsp");

    return;
}

String message = request.getParameter("msg");

String type = request.getParameter("type");

if (type == null) {

    type = "info";
}
%>
<%@ include file="auth_check.jsp" %>
<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Mark Attendance</title>

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
             Dashboard

        </a>

        <!-- VIEW MENU -->

        <a href="view_menu.jsp"
          class="btn btn-outline-light text-start">

             View Menu

        </a>

        <!-- ATTENDANCE -->

        <a href="attendance.jsp"
          class="btn btn-outline-light text-start">
             Attendance

        </a>

        <!-- ATTENDANCE HISTORY -->

        <a href="attendance_history.jsp"
           class="btn btn-outline-light text-start">

             Attendance History

        </a>

        <!-- SUBSCRIPTION -->

        <a href="subscription.jsp"
           class="btn btn-outline-light text-start">

             Subscription

        </a>

        <!-- PAYMENTS -->

        <a href="view_payment.jsp"
           class="btn btn-outline-light text-start">

             Payments

        </a>

        <!-- SKIP DAY -->

        <a href="skip_day.jsp"
          class="btn btn-outline-light text-start">

             Skip Day

        </a>

        <!-- FEEDBACK -->

        <a href="feedback.jsp"
           class="btn btn-outline-light text-start">

             Feedback

        </a>

        <!-- LOGOUT -->

        <a href="../logout"
           class="btn btn-danger text-start mt-3">

             Logout

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

     Mark Attendance

</h3>

<p class="text-muted mb-0">

    Submit your meal attendance for today

</p>

</div>

<div class="mt-2 mt-md-0">

<span class="badge bg-gradient-primary p-3">

    Attendance Portal

</span>

</div>

</div>

<!-- ===================================
     MESSAGE ALERT
=================================== -->

<% if (message != null) { %>

<div class="alert alert-<%= type %> shadow-soft mb-4 text-center">

    <%= message %>

</div>

<% } %>

<!-- ===================================
     ATTENDANCE CARDS
=================================== -->

<div class="row">

<!-- ===================================
     LUNCH CARD
=================================== -->

<div class="col-xl-6 col-lg-6 col-md-12 mb-4">

<div class="card border-0 h-100 overflow-hidden">

<!-- HEADER -->

<div class="bg-gradient-success text-white p-4">

<div class="d-flex justify-content-between align-items-center">

<div>

<h3 class="mb-1">

     Lunch

</h3>

<p class="mb-0 opacity-75">

    Afternoon meal attendance

</p>

</div>

<div style="font-size:48px; opacity:0.2;">

    

</div>

</div>

</div>

<!-- BODY -->

<div class="card-body">

<form action="<%=request.getContextPath()%>/attendance"
      method="post">

<input type="hidden"
       name="meal_type"
       value="Lunch">

<!-- PRESENT OPTION -->

<label class="w-100 mb-3">

<div class="card border shadow-sm">

<div class="card-body d-flex justify-content-between align-items-center">

<div>

<h5 class="mb-1 text-success">

    Present

</h5>

<p class="text-muted mb-0">

    I will attend lunch today

</p>

</div>

<input class="form-check-input"
       type="radio"
       name="status"
       value="Present"
       required>

</div>

</div>

</label>

<!-- ABSENT OPTION -->

<label class="w-100 mb-4">

<div class="card border shadow-sm">

<div class="card-body d-flex justify-content-between align-items-center">

<div>

<h5 class="mb-1 text-danger">

    Absent

</h5>

<p class="text-muted mb-0">

    I will skip lunch today

</p>

</div>

<input class="form-check-input"
       type="radio"
       name="status"
       value="Absent"
       required>

</div>

</div>

</label>

<button type="submit"
        class="btn btn-success w-100 py-3">

    Submit Lunch Attendance

</button>

</form>

</div>

</div>

</div>

<!-- ===================================
     DINNER CARD
=================================== -->

<div class="col-xl-6 col-lg-6 col-md-12 mb-4">

<div class="card border-0 h-100 overflow-hidden">

<!-- HEADER -->

<div class="bg-gradient-primary text-white p-4">

<div class="d-flex justify-content-between align-items-center">

<div>

<h3 class="mb-1">

     Dinner

</h3>

<p class="mb-0 opacity-75">

    Evening meal attendance

</p>

</div>

<div style="font-size:48px; opacity:0.2;">

    

</div>

</div>

</div>

<!-- BODY -->

<div class="card-body">

<form action="<%=request.getContextPath()%>/attendance"
      method="post">

<input type="hidden"
       name="meal_type"
       value="Dinner">

<!-- PRESENT OPTION -->

<label class="w-100 mb-3">

<div class="card border shadow-sm">

<div class="card-body d-flex justify-content-between align-items-center">

<div>

<h5 class="mb-1 text-success">

    Present

</h5>

<p class="text-muted mb-0">

    I will attend dinner today

</p>

</div>

<input class="form-check-input"
       type="radio"
       name="status"
       value="Present"
       required>

</div>

</div>

</label>

<!-- ABSENT OPTION -->

<label class="w-100 mb-4">

<div class="card border shadow-sm">

<div class="card-body d-flex justify-content-between align-items-center">

<div>

<h5 class="mb-1 text-danger">

    Absent

</h5>

<p class="text-muted mb-0">

    I will skip dinner today

</p>

</div>

<input class="form-check-input"
       type="radio"
       name="status"
       value="Absent"
       required>

</div>

</div>

</label>

<button type="submit"
        class="btn btn-primary w-100 py-3">

    Submit Dinner Attendance

</button>

</form>

</div>

</div>

</div>

</div>

<!-- ===================================
     FOOTER ACTIONS
=================================== -->

<div class="card mt-2">

<div class="card-body">

<div class="row text-center">

<div class="col-md-4 mb-3 mb-md-0">

<a href="view_menu.jsp"
   class="btn btn-success w-100 py-3">

     View Menu

</a>

</div>

<div class="col-md-4 mb-3 mb-md-0">

<a href="attendance_history.jsp"
   class="btn btn-dark w-100 py-3">

     Attendance History

</a>

</div>

<div class="col-md-4">

<a href="dashboard.jsp"
   class="btn btn-primary w-100 py-3">

     Dashboard

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