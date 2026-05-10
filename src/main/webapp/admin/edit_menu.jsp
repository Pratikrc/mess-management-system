<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
String role = (String) session.getAttribute("role");

if (role == null || !role.equals("admin")) {

    response.sendRedirect("../login.jsp");

    return;
}

int id = Integer.parseInt(request.getParameter("id"));

String mealType = "";

String description = "";

try {

    Connection con = DBConnection.getConnection();

    PreparedStatement ps = con.prepareStatement(

        "SELECT * FROM menu WHERE id=?"
    );

    ps.setInt(1, id);

    ResultSet rs = ps.executeQuery();

    if (rs.next()) {

        mealType = rs.getString("meal_type");

        description = rs.getString("description");
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

<title>Edit Menu</title>

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

    ✏️ Edit Menu

</h3>

<p class="text-muted mb-0">

    Update and manage existing food menu

</p>

</div>

<div class="mt-2 mt-md-0">

<span class="badge bg-gradient-warning p-3">

    Menu Editor

</span>

</div>

</div>

<!-- ===================================
     PAGE LAYOUT
=================================== -->

<div class="row justify-content-center">

<div class="col-lg-8 col-xl-7">

<!-- ===================================
     EDIT CARD
=================================== -->

<div class="card border-0 overflow-hidden">

<!-- HEADER -->

<div class="bg-gradient-warning p-4 text-dark">

<div class="d-flex justify-content-between align-items-center flex-wrap">

<div>

<h2 class="fw-bold mb-1">

    🍽️ Update Menu

</h2>

<p class="mb-0">

    Modify meal type and menu description

</p>

</div>

<div style="font-size:60px; opacity:0.25;">

    🍛

</div>

</div>

</div>

<!-- BODY -->

<div class="card-body p-4 p-lg-5">

<form action="<%=request.getContextPath()%>/editMenu"
      method="post">

<!-- HIDDEN ID -->

<input type="hidden"
       name="id"
       value="<%= id %>">

<!-- ===================================
     CURRENT MENU PREVIEW
=================================== -->

<div class="card bg-light border-0 mb-4">

<div class="card-body">

<h5 class="mb-3">

    📋 Current Menu Information

</h5>

<div class="row">

<div class="col-md-6 mb-3 mb-md-0">

<p class="mb-2 text-muted">

    Current Meal Type

</p>

<span class="badge
    <%= "Lunch".equals(mealType)
        ? "bg-success"
        : "Dinner".equals(mealType)
            ? "bg-primary"
            : "bg-warning text-dark" %>">

    <%= mealType %>

</span>

</div>

<div class="col-md-6">

<p class="mb-2 text-muted">

    Menu ID

</p>

<h6 class="fw-bold">

    #<%= id %>

</h6>

</div>

</div>

</div>

</div>

<!-- ===================================
     MEAL TYPE
=================================== -->

<div class="mb-4">

<label class="form-label fw-bold fs-5 mb-3">

    🍽️ Select Meal Type

</label>

<div class="row">

<!-- LUNCH -->

<div class="col-md-6 mb-3">

<label class="w-100">

<input class="form-check-input d-none"
       type="radio"
       name="meal_type"
       value="Lunch"
       <%= mealType.equals("Lunch")
            ? "checked"
            : "" %>>

<div class="card border-2 h-100
     <%= mealType.equals("Lunch")
            ? "border-success"
            : "" %>">

<div class="card-body text-center">

<div style="font-size:50px;">

    🍛

</div>

<h5 class="mt-3 fw-bold">

    Lunch

</h5>

<p class="text-muted mb-0">

    Afternoon meal menu

</p>

</div>

</div>

</label>

</div>

<!-- DINNER -->

<div class="col-md-6 mb-3">

<label class="w-100">

<input class="form-check-input d-none"
       type="radio"
       name="meal_type"
       value="Dinner"
       <%= mealType.equals("Dinner")
            ? "checked"
            : "" %>>

<div class="card border-2 h-100
     <%= mealType.equals("Dinner")
            ? "border-primary"
            : "" %>">

<div class="card-body text-center">

<div style="font-size:50px;">

    🍽️

</div>

<h5 class="mt-3 fw-bold">

    Dinner

</h5>

<p class="text-muted mb-0">

    Evening meal menu

</p>

</div>

</div>

</label>

</div>

</div>

</div>

<!-- ===================================
     DESCRIPTION
=================================== -->

<div class="mb-4">

<label class="form-label fw-bold fs-5 mb-3">

    📝 Menu Description

</label>

<textarea name="description"
          class="form-control"
          rows="8"
          placeholder="Enter updated menu description..."
          required><%= description %></textarea>

<div class="form-text mt-2">

    Add food items, special dishes, desserts, drinks, etc.

</div>

</div>

<!-- ===================================
     ACTION BUTTONS
=================================== -->

<div class="row">

<!-- UPDATE -->

<div class="col-md-6 mb-3">

<button type="submit"
        class="btn btn-success w-100 py-3">

    🚀 Update Menu

</button>

</div>

<!-- BACK -->

<div class="col-md-6 mb-3">

<a href="add_menu.jsp"
   class="btn btn-secondary w-100 py-3">

    ↩️ Back to Menu

</a>

</div>

</div>

</form>

</div>

</div>

<!-- ===================================
     QUICK ACTIONS
=================================== -->

<div class="card mt-4 border-0">

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

</div>

</div>

</body>
</html>