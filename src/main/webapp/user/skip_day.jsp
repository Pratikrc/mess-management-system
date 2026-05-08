<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
if (session.getAttribute("email") == null) {

    response.sendRedirect("../login.jsp");

    return;
}

String email = (String) session.getAttribute("email");

String message = "";

String alertType = "info";

try (Connection con = DBConnection.getConnection()) {

    // 🔴 CHECK MESS CLOSURE
    PreparedStatement psClose = con.prepareStatement(

        "SELECT * FROM announcement " +
        "WHERE mess_closed='Yes' " +
        "AND CURDATE() BETWEEN close_start AND close_end " +
        "ORDER BY id DESC LIMIT 1"
    );

    ResultSet rsClose = psClose.executeQuery();

    if (rsClose.next()) {

        message = "Mess is currently closed. Skip option disabled.";

        alertType = "danger";

    } else {

        // 🔴 CHECK ATTENDANCE
        PreparedStatement psAttend = con.prepareStatement(

            "SELECT * FROM attendance " +
            "WHERE user_email=? AND meal_date=CURDATE()"
        );

        psAttend.setString(1, email);

        ResultSet rsAttend = psAttend.executeQuery();

        if (rsAttend.next()) {

            String mealType = rsAttend.getString("meal_type");

            message = mealType +
                    " attendance already marked today. " +
                    "You cannot skip this day!";

            alertType = "warning";

        } else {

            // 🔴 CHECK SKIP LIMIT
            PreparedStatement psCount = con.prepareStatement(

                "SELECT COUNT(*) FROM skip_days " +
                "WHERE user_email=? " +
                "AND MONTH(skip_date)=MONTH(CURDATE()) " +
                "AND YEAR(skip_date)=YEAR(CURDATE())"
            );

            psCount.setString(1, email);

            ResultSet rsCount = psCount.executeQuery();

            int used = 0;

            if (rsCount.next()) {

                used = rsCount.getInt(1);
            }

            // 🔴 CHECK ALREADY SKIPPED
            PreparedStatement psCheck = con.prepareStatement(

                "SELECT * FROM skip_days " +
                "WHERE user_email=? AND skip_date=CURDATE()"
            );

            psCheck.setString(1, email);

            ResultSet rsCheck = psCheck.executeQuery();

            if (rsCheck.next()) {

                message = "You already skipped today!";

                alertType = "warning";

            } else if (used >= 3) {

                message = "Skip limit reached (3 per month)";

                alertType = "danger";

            } else {

                // 🔴 INSERT SKIP
                PreparedStatement psInsert = con.prepareStatement(

                    "INSERT INTO skip_days(user_email, skip_date) " +
                    "VALUES(?, CURDATE())"
                );

                psInsert.setString(1, email);

                psInsert.executeUpdate();

                // 🔴 EXTEND SUBSCRIPTION
                PreparedStatement psUpdate = con.prepareStatement(

                    "UPDATE subscription " +
                    "SET end_date = DATE_ADD(end_date, INTERVAL 1 DAY) " +
                    "WHERE user_email=?"
                );

                psUpdate.setString(1, email);

                psUpdate.executeUpdate();

                message = "Day skipped successfully & subscription extended!";

                alertType = "success";
            }
        }
    }

} catch (Exception e) {

    e.printStackTrace();

    message = "Something went wrong!";

    alertType = "danger";
}
%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Skip Day</title>

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

    Skip Day

</span>

<a href="dashboard.jsp"
   class="btn btn-light btn-sm">

    Back

</a>

</div>

</nav>

<div class="container py-5">

<div class="row justify-content-center">

<div class="col-lg-6 col-md-8 col-sm-12">

<!-- 🔥 MAIN CARD -->

<div class="card shadow-sm border-0">

<div class="card-body p-4 text-center">

<h3 class="mb-4">

    ⏭️ Skip Today's Meal

</h3>

<!-- 🔔 MESSAGE -->

<div class="alert alert-<%= alertType %> shadow-sm">

    <%= message %>

</div>

<!-- INFO -->

<div class="card bg-light border-0 p-3 mb-4">

<p class="mb-2">

    ⚠ You can skip only
    <strong>3 days per month</strong>

</p>

<p class="mb-0">

    📅 Subscription will extend by
    <strong>1 day</strong>

</p>

</div>

<!-- BUTTON -->

<a href="dashboard.jsp"
   class="btn btn-primary w-100 py-2">

    Back to Dashboard

</a>

</div>

</div>

</div>

</div>

</div>

</body>
</html>