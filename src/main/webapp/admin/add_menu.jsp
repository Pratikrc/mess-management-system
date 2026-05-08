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

<body class="bg-light">

<!-- 🔥 NAVBAR -->

<nav class="navbar navbar-dark bg-dark">

<div class="container-fluid">

<span class="navbar-brand">

    Manage Menu

</span>

<a href="dashboard.jsp"
   class="btn btn-light btn-sm">

    Back

</a>

</div>

</nav>

<div class="container py-4">

<div class="row">

<!-- ➕ ADD MENU -->

<div class="col-lg-4 col-md-5 col-sm-12 mb-4">

<div class="card shadow-sm border-0 h-100">

<div class="card-body">

<h4 class="mb-4 text-center">

    ➕ Add Menu

</h4>

<form action="<%=request.getContextPath()%>/addMenu"
      method="post">

<!-- MENU TYPE -->

<div class="mb-4">

<label class="form-label fw-bold">

    Select Menu Type

</label>

<select name="meal_type"
        class="form-select"
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

<label class="form-label fw-bold">

    Description

</label>

<textarea name="description"
          class="form-control"
          rows="5"
          placeholder="Enter menu description..."
          required></textarea>

</div>

<!-- BUTTON -->

<button type="submit"
        class="btn btn-success w-100 py-2">

    Add Menu

</button>

</form>

</div>

</div>

</div>

<!-- 📋 MENU LIST -->

<div class="col-lg-8 col-md-7 col-sm-12">

<div class="card shadow-sm border-0">

<div class="card-body">

<h4 class="mb-4 text-center text-md-start">

    📋 Menu List

</h4>

<div class="table-responsive">

<table class="table table-bordered table-striped table-hover align-middle">

<thead class="table-dark">

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

    <%= rs.getString("meal_date") %>

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

<td style="min-width:220px;">

    <%= rs.getString("description") %>

</td>

<!-- ACTION -->

<td>

<div class="d-grid gap-2">

<!-- EDIT -->

<a href="edit_menu.jsp?id=<%= rs.getInt("id") %>"
   class="btn btn-primary btn-sm">

    Edit

</a>

<!-- DELETE -->

<a href="<%=request.getContextPath()%>/deleteMenu?id=<%= rs.getInt("id") %>"
   class="btn btn-danger btn-sm"
   onclick="return confirm('Are you sure you want to delete this menu?');">

    Delete

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
    class="text-center text-danger py-4">

    No menu found

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