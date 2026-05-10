<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
if (session.getAttribute("email") == null) {

    response.sendRedirect("../login.jsp");

    return;
}

String email = (String) session.getAttribute("email");

/* ===================================
   VARIABLES
=================================== */

String plan = "None";

String endDate = "";

boolean active = false;

String expiryMsg = "";

String expiryClass = "text-success";

int totalMeals = 0;

double totalPaid = 0;

long daysLeft = 0;

String announcementMsg = "";

String messClosed = "No";

String closeStart = "";

String closeEnd = "";

int skipUsed = 0;

int skipLimit = 3;

/* ===================================
   DATABASE
=================================== */

try {

    Connection con = DBConnection.getConnection();

    // SUBSCRIPTION

    PreparedStatement ps = con.prepareStatement(

        "SELECT * FROM subscription " +
        "WHERE user_email=? " +
        "ORDER BY end_date DESC LIMIT 1"
    );

    ps.setString(1, email);

    ResultSet rs = ps.executeQuery();

    if (rs.next()) {

        plan = rs.getString("plan_type");

        endDate = rs.getString("end_date");

        java.sql.Date ed = rs.getDate("end_date");

        long diff = ed.getTime() - System.currentTimeMillis();

        daysLeft = diff / (1000 * 60 * 60 * 24);

        if (daysLeft < 0) {

            expiryMsg = "Expired";

            expiryClass = "text-danger";

            active = false;

            daysLeft = 0;

        } else {

            active = true;

            if (daysLeft == 0) {

                expiryMsg = "Expires today";

                expiryClass = "text-danger";

            } else if (daysLeft == 1) {

                expiryMsg = "Expires in 1 day";

                expiryClass = "text-warning";

            } else if (daysLeft <= 2) {

                expiryMsg = "Expires in " + daysLeft + " days";

                expiryClass = "text-warning";

            } else {

                expiryMsg = "Expires in " + daysLeft + " days";

                expiryClass = "text-success";
            }
        }
    }

    // TOTAL MEALS

    PreparedStatement ps1 = con.prepareStatement(

        "SELECT COUNT(*) FROM attendance " +
        "WHERE user_email=?"
    );

    ps1.setString(1, email);

    ResultSet rs1 = ps1.executeQuery();

    if (rs1.next()) {

        totalMeals = rs1.getInt(1);
    }

    // TOTAL PAYMENT

    PreparedStatement ps2 = con.prepareStatement(

        "SELECT SUM(amount) FROM payments " +
        "WHERE user_email=? AND status='Paid'"
    );

    ps2.setString(1, email);

    ResultSet rs2 = ps2.executeQuery();

    if (rs2.next()) {

        totalPaid = rs2.getDouble(1);
    }

    // ANNOUNCEMENT

    PreparedStatement psAnn = con.prepareStatement(

        "SELECT * FROM announcement " +
        "ORDER BY created_at DESC LIMIT 1"
    );

    ResultSet rsAnn = psAnn.executeQuery();

    if (rsAnn.next()) {

        announcementMsg = rsAnn.getString("message");

        messClosed = rsAnn.getString("mess_closed");

        closeStart = rsAnn.getString("close_start");

        closeEnd = rsAnn.getString("close_end");
    }

    // SKIP COUNT

    PreparedStatement psSkip = con.prepareStatement(

        "SELECT COUNT(*) FROM skip_days " +
        "WHERE user_email=?"
    );

    psSkip.setString(1, email);

    ResultSet rsSkip = psSkip.executeQuery();

    if (rsSkip.next()) {

        skipUsed = rsSkip.getInt(1);
    }

} catch (Exception e) {

    e.printStackTrace();
}

/* ===================================
   BLOCK IF SUBSCRIPTION EXPIRED
=================================== */

if (!active) {

    response.sendRedirect(
        "payment.jsp?msg=Please subscribe&type=error"
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

<title>User Dashboard</title>

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

            <!-- TOPBAR -->

            <div class="topbar d-flex justify-content-between align-items-center flex-wrap">

                <div>

                    <h3 class="mb-1">

                        Welcome,
                        <%= session.getAttribute("user") %>

                    </h3>

                    <p class="text-muted mb-0">

                        Smart Mess SaaS Dashboard

                    </p>

                </div>

                <div class="mt-2 mt-md-0">

                    <span class="badge bg-gradient-primary p-3">

                        Active Plan:
                        <%= plan %>

                    </span>

                </div>

            </div>

            <!-- ANNOUNCEMENT -->

            <% if (announcementMsg != null && !announcementMsg.isEmpty()) { %>

                <% if ("Yes".equals(messClosed)) { %>

                    <div class="alert alert-danger mb-4">

                        <h5 class="mb-3">

                            🚫 Mess Closed

                        </h5>

                        <p class="mb-2">

                            <strong>
                                <%= announcementMsg %>
                            </strong>

                        </p>

                        <p class="mb-2">

                            <b>Closed:</b>
                            <%= closeStart %>
                            →
                            <%= closeEnd %>

                        </p>

                    </div>

                <% } else { %>

                    <div class="alert alert-info mb-4">

                        <strong>
                            📢 Announcement:
                        </strong>

                        <%= announcementMsg %>

                    </div>

                <% } %>

            <% } %>

            <!-- ANALYTICS -->

            <div class="row mb-4">

                <div class="col-xl-4 col-md-6 mb-4">

                    <div class="card dashboard-card bg-gradient-primary h-100">

                        <div class="card-body">

                            <h5>🍛 Total Meals</h5>

                            <h2>

                                <%= totalMeals %>

                            </h2>

                            <p class="mb-0">

                                Meals consumed

                            </p>

                        </div>

                    </div>

                </div>

                <div class="col-xl-4 col-md-6 mb-4">

                    <div class="card dashboard-card bg-gradient-warning h-100">

                        <div class="card-body">

                            <h5>⏳ Days Remaining</h5>

                            <h2>

                                <%= daysLeft %>

                            </h2>

                            <p class="mb-0">

                                Subscription validity

                            </p>

                        </div>

                    </div>

                </div>

                <div class="col-xl-4 col-md-6 mb-4">

                    <div class="card dashboard-card bg-gradient-success h-100">

                        <div class="card-body">

                            <h5>💰 Total Paid</h5>

                            <h2>

                                ₹ <%= totalPaid %>

                            </h2>

                            <p class="mb-0">

                                Payment summary

                            </p>

                        </div>

                    </div>

                </div>

            </div>

            <!-- SUBSCRIPTION -->

            <div class="row mb-4">

                <div class="col-lg-8 mb-4">

                    <div class="card h-100">

                        <div class="card-body">

                            <h4 class="mb-4">

                                📅 Subscription Details

                            </h4>

                            <div class="row">

                                <div class="col-md-3 mb-3">

                                    <p class="text-muted mb-1">

                                        Plan

                                    </p>

                                    <h5>

                                        <%= plan %>

                                    </h5>

                                </div>

                                <div class="col-md-3 mb-3">

                                    <p class="text-muted mb-1">

                                        Expiry

                                    </p>

                                    <h5>

                                        <%= endDate %>

                                    </h5>

                                </div>

                                <div class="col-md-3 mb-3">

                                    <p class="text-muted mb-1">

                                        Status

                                    </p>

                                    <h5 class="<%= active ? "text-success" : "text-danger" %>">

                                        <%= active ? "Active" : "Expired" %>

                                    </h5>

                                </div>

                                <div class="col-md-3 mb-3">

                                    <p class="text-muted mb-1">

                                        Validity

                                    </p>

                                    <h5 class="<%= expiryClass %>">

                                        <%= expiryMsg %>

                                    </h5>

                                </div>

                            </div>

                        </div>

                    </div>

                </div>

                <!-- SKIP STATUS -->

                <div class="col-lg-4 mb-4">

                    <div class="card h-100">

                        <div class="card-body">

                            <h4 class="mb-4">

                                ⏭️ Skip Status

                            </h4>

                            <h2 class="mb-3">

                                <%= skipUsed %>/<%= skipLimit %>

                            </h2>

                            <div class="progress mb-3">

                                <div class="progress-bar bg-danger"
                                     style="width:<%= (skipUsed * 100) / skipLimit %>%">

                                </div>

                            </div>

                            <p class="text-muted mb-0">

                                Monthly skip usage

                            </p>

                        </div>

                    </div>

                </div>

            </div>

            <!-- QUICK ACTIONS -->

            <div class="card">

                <div class="card-body">

                    <h4 class="mb-4">

                        ⚡ Quick Actions

                    </h4>

                    <div class="row">

                        <div class="col-lg-4 col-md-6 mb-3">

                            <a href="view_menu.jsp"
                               class="btn btn-primary w-100 py-3">

                                View Menu

                            </a>

                        </div>

                        <div class="col-lg-4 col-md-6 mb-3">

                            <a href="attendance_history.jsp"
                               class="btn btn-dark w-100 py-3">

                                Attendance History

                            </a>

                        </div>

                        <div class="col-lg-4 col-md-6 mb-3">

                            <a href="payment.jsp"
                               class="btn btn-success w-100 py-3">

                                Payments

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