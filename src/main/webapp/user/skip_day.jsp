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

String icon = "ℹ️";

String title = "Information";

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

        icon = "🚫";

        title = "Mess Closed";

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

            icon = "";

            title = "Attendance Already Marked";

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

                icon = "";

                title = "Already Skipped";

            } else if (used >= 3) {

                message = "Skip limit reached (3 per month)";

                alertType = "danger";

                icon = "❌";

                title = "Limit Reached";

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

                icon = "✅";

                title = "Skip Successful";
            }
        }
    }

} catch (Exception e) {

    e.printStackTrace();

    message = "Something went wrong!";

    alertType = "danger";

    icon = "❌";

    title = "Error";
}
%>
<%@ include file="auth_check.jsp" %>
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

     Skip Day Portal

</h3>

<p class="text-muted mb-0">

    Manage your meal skip requests

</p>

</div>

<div class="mt-2 mt-md-0">

<span class="badge bg-gradient-warning p-3">

    Skip Management

</span>

</div>

</div>

<!-- ===================================
     MAIN CARD
=================================== -->

<div class="row justify-content-center">

<div class="col-lg-7 col-md-10">

<div class="card border-0 overflow-hidden">

<!-- HEADER -->

<div class="bg-gradient-warning text-dark p-4">

<div class="d-flex justify-content-between align-items-center">

<div>

<h3 class="mb-1">

    <%= icon %>
    <%= title %>

</h3>

<p class="mb-0 opacity-75">

    Smart Mess Skip Day System

</p>

</div>

<div style="font-size:55px; opacity:0.2;">

    

</div>

</div>

</div>

<!-- BODY -->

<div class="card-body p-5 text-center">

<!-- ICON -->

<div style="font-size:80px;"
     class="mb-4">

    <%= icon %>

</div>

<!-- ALERT -->

<div class="alert alert-<%= alertType %> shadow-soft mb-4 fs-5">

    <%= message %>

</div>

<!-- INFO CARDS -->

<div class="row mb-4">

<!-- LIMIT -->

<div class="col-md-6 mb-3">

<div class="card border-0 bg-light h-100">

<div class="card-body">

<div style="font-size:40px;">

    

</div>

<h5 class="mt-3">

    Monthly Limit

</h5>

<p class="text-muted mb-0">

    Maximum 3 skips per month

</p>

</div>

</div>

</div>

<!-- BENEFIT -->

<div class="col-md-6 mb-3">

<div class="card border-0 bg-light h-100">

<div class="card-body">

<div style="font-size:40px;">

    

</div>

<h5 class="mt-3">

    Subscription Benefit

</h5>

<p class="text-muted mb-0">

    Subscription extends by 1 day

</p>

</div>

</div>

</div>

</div>

<!-- ACTIONS -->

<div class="row">

<div class="col-md-6 mb-3 mb-md-0">

<a href="attendance.jsp"
   class="btn btn-dark w-100 py-3">

     Attendance

</a>

</div>

<div class="col-md-6">

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

</div>

</div>

</body>
</html>