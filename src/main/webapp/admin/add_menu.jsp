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

int totalMenus = 0;

int lunchMenus = 0;

int dinnerMenus = 0;

try {

    Connection con = DBConnection.getConnection();

    Statement st = con.createStatement();

    // TOTAL MENU

    ResultSet rs1 = st.executeQuery(

        "SELECT COUNT(*) FROM menu"
    );

    if (rs1.next()) {

        totalMenus = rs1.getInt(1);
    }

    // LUNCH

    ResultSet rs2 = st.executeQuery(

        "SELECT COUNT(*) FROM menu " +
        "WHERE meal_type='Lunch'"
    );

    if (rs2.next()) {

        lunchMenus = rs2.getInt(1);
    }

    // DINNER

    ResultSet rs3 = st.executeQuery(

        "SELECT COUNT(*) FROM menu " +
        "WHERE meal_type='Dinner'"
    );

    if (rs3.next()) {

        dinnerMenus = rs3.getInt(1);
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

<title>Manage Menu</title>

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

    🍛 Menu Management

</h3>

<p class="text-muted mb-0">

    Create and manage Smart Mess meal menus

</p>

</div>

<div class="mt-2 mt-md-0">

<span class="badge bg-gradient-success p-3">

    Restaurant Control Panel

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

    📋 Total Menus

</h5>

<h2>

    <%= totalMenus %>

</h2>

<p class="mb-0">

    Total created menus

</p>

</div>

</div>

</div>

<!-- LUNCH -->

<div class="col-lg-4 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-success h-100">

<div class="card-body">

<h5>

    🍛 Lunch Menus

</h5>

<h2>

    <%= lunchMenus %>

</h2>

<p class="mb-0">

    Lunch meal entries

</p>

</div>

</div>

</div>

<!-- DINNER -->

<div class="col-lg-4 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-warning h-100">

<div class="card-body">

<h5>

    🍽️ Dinner Menus

</h5>

<h2>

    <%= dinnerMenus %>

</h2>

<p class="mb-0">

    Dinner meal entries

</p>

</div>

</div>

</div>

</div>

<div class="row">

<!-- ===================================
     ADD MENU FORM
=================================== -->

<div class="col-lg-4 col-md-5 mb-4">

<div class="card border-0 overflow-hidden h-100">

<!-- HEADER -->

<div class="bg-gradient-success text-white p-4">

<div class="d-flex justify-content-between align-items-center">

<div>

<h3 class="mb-1">

    ➕ Add Menu

</h3>

<p class="mb-0 opacity-75">

    Create today's food menu

</p>

</div>

<div style="font-size:50px; opacity:0.2;">

    🍛

</div>

</div>

</div>

<!-- BODY -->

<div class="card-body p-4">

<form action="<%=request.getContextPath()%>/addMenu"
      method="post">

<!-- MEAL TYPE -->

<div class="mb-4">

<label class="form-label fw-bold mb-3">

    Select Menu Type

</label>

<select name="meal_type"
        class="form-select form-select-lg"
        required>

<option value="">

    -- Select Menu Type --

</option>

<option value="Lunch">

    🍛 Lunch

</option>

<option value="Dinner">

    🍽️ Dinner

</option>

<option value="Special Day">

    🎉 Special Day

</option>

</select>

</div>

<!-- DESCRIPTION -->

<div class="mb-4">

<label class="form-label fw-bold mb-3">

    Menu Description

</label>

<textarea name="description"
          class="form-control"
          rows="8"
          placeholder="Enter today's menu description..."
          required></textarea>

</div>

<!-- BUTTON -->

<button type="submit"
        class="btn btn-success w-100 py-3">

    🚀 Add Menu

</button>

</form>

</div>

</div>

</div>

<!-- ===================================
     MENU TABLE
=================================== -->

<div class="col-lg-8 col-md-7 mb-4">

<div class="card border-0">

<div class="card-body">

<div class="d-flex justify-content-between align-items-center flex-wrap mb-4">

<div>

<h4 class="mb-1">

    📋 Menu Records

</h4>

<p class="text-muted mb-0">

    Complete meal menu history

</p>

</div>

</div>

<div class="table-responsive">

<table class="table table-hover align-middle">

<thead>

<tr>

<th>Date</th>

<th>Meal Type</th>

<th>Description</th>

<th>Action</th>

</tr>

</thead>

<tbody>

<%
try {

    Connection con = DBConnection.getConnection();

    Statement st = con.createStatement();

    ResultSet rs = st.executeQuery(

        "SELECT * FROM menu " +
        "ORDER BY meal_date DESC"
    );

    boolean hasData = false;

    while (rs.next()) {

        hasData = true;

        String mealType = rs.getString("meal_type");
%>

<tr>

<!-- DATE -->

<td>

<div class="fw-semibold">

    <%= rs.getString("meal_date") %>

</div>

</td>

<!-- MEAL TYPE -->

<td>

<span class="badge
    <%= "Lunch".equals(mealType)
        ? "bg-success"
        : "Dinner".equals(mealType)
            ? "bg-primary"
            : "bg-warning text-dark" %>">

    <%= mealType %>

</span>

</td>

<!-- DESCRIPTION -->

<td style="min-width:250px;">

<div class="text-muted"
     style="line-height:1.7;">

    <%= rs.getString("description") %>

</div>

</td>

<!-- ACTION -->

<td>

<div class="d-grid gap-2">

<!-- EDIT -->

<a href="edit_menu.jsp?id=<%= rs.getInt("id") %>"
   class="btn btn-primary btn-sm">

    ✏️ Edit

</a>

<!-- DELETE -->

<a href="<%=request.getContextPath()%>/deleteMenu?id=<%= rs.getInt("id") %>"
   class="btn btn-danger btn-sm"
   onclick="return confirm('Are you sure you want to delete this menu?');">

    🗑️ Delete

</a>

</div>

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

    🍛

</div>

<h3 class="mt-3">

    No Menus Found

</h3>

<p class="text-muted">

    No menu entries available yet.

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

</div>

</div>

<!-- ===================================
     QUICK ACTIONS
=================================== -->

<div class="card mt-2">

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