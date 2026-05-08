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

<!-- Bootstrap -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet">

<!-- Custom CSS -->

<link rel="stylesheet"
      href="../css/style.css">

</head>

<body class="bg-light">

<!-- 🔥 NAVBAR -->

<nav class="navbar navbar-dark bg-dark">

<div class="container-fluid">

<span class="navbar-brand">

    Edit Menu

</span>

<a href="add_menu.jsp"
   class="btn btn-light btn-sm">

    Back

</a>

</div>

</nav>

<div class="container py-5">

<div class="row justify-content-center">

<div class="col-lg-5 col-md-7 col-sm-12">

<!-- 🔥 CARD -->

<div class="card shadow-sm border-0">

<div class="card-body p-4">

<h3 class="text-center mb-4">

    ✏️ Edit Menu

</h3>

<form action="<%=request.getContextPath()%>/editMenu"
      method="post">

<!-- ID -->

<input type="hidden"
       name="id"
       value="<%= id %>">

<!-- MEAL TYPE -->

<div class="mb-4">

<label class="form-label fw-bold d-block">

    Meal Type

</label>

<div class="form-check mb-2">

<input class="form-check-input"
       type="radio"
       name="meal_type"
       value="Lunch"
       <%= mealType.equals("Lunch")
            ? "checked"
            : "" %>>

<label class="form-check-label">

    🍛 Lunch

</label>

</div>

<div class="form-check">

<input class="form-check-input"
       type="radio"
       name="meal_type"
       value="Dinner"
       <%= mealType.equals("Dinner")
            ? "checked"
            : "" %>>

<label class="form-check-label">

    🍽️ Dinner

</label>

</div>

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
          required><%= description %></textarea>

</div>

<!-- BUTTON -->

<button type="submit"
        class="btn btn-success w-100 py-2">

    Update Menu

</button>

<!-- BACK BUTTON -->

<a href="add_menu.jsp"
   class="btn btn-secondary w-100 py-2 mt-3">

    Back to Menu

</a>

</form>

</div>

</div>

</div>

</div>

</div>

</body>
</html>