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

<body class="bg-light">

<!-- 🔥 NAVBAR -->

<nav class="navbar navbar-dark bg-dark">

    <div class="container-fluid">

        <span class="navbar-brand">
            Today's Menu
        </span>

        <a href="dashboard.jsp"
           class="btn btn-light btn-sm">

            Back

        </a>

    </div>

</nav>

<div class="container py-4">

<!-- 🔥 PAGE TITLE -->

<h3 class="mb-4 text-center">

    🍽️ Today's Menu

</h3>

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

        if ("Lunch".equalsIgnoreCase(mealType)) {

            cardColor = "success";

            emoji = "🍛";

        } else if ("Dinner".equalsIgnoreCase(mealType)) {

            cardColor = "primary";

            emoji = "🍽️";

        } else if ("Special".equalsIgnoreCase(mealType)) {

            cardColor = "warning";

            emoji = "🎉";
        }
%>

<!-- 🔥 MENU CARD -->

<div class="col-lg-6 col-md-6 col-sm-12 mb-4">

<div class="card shadow-sm border-0 h-100">

<div class="card-header bg-<%= cardColor %> text-white text-center">

<h4 class="mb-0">

    <%= emoji %>
    <%= mealType %>

</h4>

</div>

<div class="card-body">

<p class="mb-0 fs-5">

    <%= description %>

</p>

</div>

</div>

</div>

<%
    }

    if (!hasData) {
%>

<div class="col-12">

<div class="alert alert-danger text-center shadow-sm">

    No menu available for today

</div>

</div>

<%
    }

} catch (Exception e) {

    e.printStackTrace();
}
%>

</div>

<!-- 🔙 BACK BUTTON -->

<div class="text-center mt-3">

<a href="dashboard.jsp"
   class="btn btn-secondary w-100 w-md-auto px-4">

    Back to Dashboard

</a>

</div>

</div>

</body>
</html>