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

// ---------------- VARIABLES ----------------
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

// ---------------- DATABASE ----------------
try {

    Connection con = DBConnection.getConnection();

    // 🔵 SUBSCRIPTION
    PreparedStatement ps = con.prepareStatement(
        "SELECT * FROM subscription WHERE user_email=? ORDER BY end_date DESC LIMIT 1"
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

    // 🔵 TOTAL MEALS
    PreparedStatement ps1 = con.prepareStatement(
        "SELECT COUNT(*) FROM attendance WHERE user_email=?"
    );

    ps1.setString(1, email);

    ResultSet rs1 = ps1.executeQuery();

    if (rs1.next()) {

        totalMeals = rs1.getInt(1);
    }

    // 🔵 TOTAL PAYMENT
    PreparedStatement ps2 = con.prepareStatement(
        "SELECT SUM(amount) FROM payments WHERE user_email=? AND status='Paid'"
    );

    ps2.setString(1, email);

    ResultSet rs2 = ps2.executeQuery();

    if (rs2.next()) {

        totalPaid = rs2.getDouble(1);
    }

    // 🔵 ANNOUNCEMENT + MESS CLOSURE
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

    // 🔵 SKIP COUNT
    PreparedStatement psSkip = con.prepareStatement(
        "SELECT COUNT(*) FROM skip_days WHERE user_email=?"
    );

    psSkip.setString(1, email);

    ResultSet rsSkip = psSkip.executeQuery();

    if (rsSkip.next()) {

        skipUsed = rsSkip.getInt(1);
    }

} catch (Exception e) {

    e.printStackTrace();
}

// 🚫 BLOCK IF NOT ACTIVE
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

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet">

</head>

<body class="bg-light">

<!-- 🔥 NAVBAR -->

<nav class="navbar navbar-dark bg-dark">

    <div class="container-fluid">

        <span class="navbar-brand">
            Smart Mess - User
        </span>

        <a href="../logout"
           class="btn btn-danger btn-sm">

            Logout

        </a>

    </div>

</nav>

<div class="container py-4">

<!-- 👋 WELCOME -->

<h3 class="mb-4 text-center text-md-start">

    Welcome,
    <%= session.getAttribute("user") %>

</h3>

<!-- 🔔 ANNOUNCEMENT -->

<% if (announcementMsg != null && !announcementMsg.isEmpty()) { %>

    <% if ("Yes".equals(messClosed)) { %>

        <div class="alert alert-danger text-center shadow-sm">

            <h5>🚫 Mess Closed</h5>

            <p>
                <b><%= announcementMsg %></b>
            </p>

            <p>

                Closed From:
                <b><%= closeStart %></b>

                to

                <b><%= closeEnd %></b>

            </p>

            <p class="mb-0">

                Your subscription has been automatically extended.

            </p>

        </div>

    <% } else { %>

        <div class="alert alert-info text-center shadow-sm">

            <b>📢 Announcement:</b>

            <%= announcementMsg %>

        </div>

    <% } %>

<% } %>

<!-- 📦 SUBSCRIPTION STATUS -->

<div class="card shadow-sm border-0 mb-4">

<div class="card-body text-center">

<h5 class="mb-3">
    Subscription Status
</h5>

<p>
    <b>Plan:</b> <%= plan %>
</p>

<p>
    <b>Expiry Date:</b> <%= endDate %>
</p>

<p>

<b>Status:</b>

<span class="<%= active ? "text-success" : "text-danger" %>">

    <%= active ? "Active" : "Expired" %>

</span>

</p>

<p class="mb-0">

<b>Validity:</b>

<span class="<%= expiryClass %>">

    <%= expiryMsg %>

</span>

</p>

</div>

</div>

<!-- 📊 DASHBOARD SUMMARY -->

<div class="row text-center mb-4">

<div class="col-lg-4 col-md-4 col-sm-6 mb-3">

    <div class="card shadow-sm border-0 h-100">

        <div class="card-body">

            <h6>Total Meals</h6>

            <h3 class="text-primary">

                <%= totalMeals %>

            </h3>

        </div>

    </div>

</div>

<div class="col-lg-4 col-md-4 col-sm-6 mb-3">

    <div class="card shadow-sm border-0 h-100">

        <div class="card-body">

            <h6>Days Remaining</h6>

            <h3 class="<%= daysLeft <= 2 ? "text-warning" : "text-success" %>">

                <%= daysLeft %>

            </h3>

        </div>

    </div>

</div>

<div class="col-lg-4 col-md-4 col-sm-12 mb-3">

    <div class="card shadow-sm border-0 h-100">

        <div class="card-body">

            <h6>Total Paid</h6>

            <h3 class="text-success">

                ₹ <%= totalPaid %>

            </h3>

        </div>

    </div>

</div>

</div>

<!-- 🍽️ SKIP DAY -->

<div class="card shadow-sm border-0 mb-4">

<div class="card-body text-center">

<h5 class="mb-3">
    Skip Days
</h5>

<p>

Used:
<b><%= skipUsed %></b>
/
<b><%= skipLimit %></b>

</p>

<% if ("Yes".equals(messClosed)) { %>

    <button class="btn btn-secondary w-100" disabled>

        Mess Closed

    </button>

<% } else if (skipUsed < skipLimit) { %>

    <a href="skip_day.jsp"
       class="btn btn-danger w-100">

        Skip Today

    </a>

<% } else { %>

    <div class="text-danger fw-bold">

        Skip Limit Reached

    </div>

<% } %>

</div>

</div>

<!-- ⚙️ ACTION BUTTONS -->

<div class="row">

<div class="col-lg-4 col-md-6 col-sm-12 mb-3">

    <a href="view_menu.jsp"
       class="btn btn-primary w-100 py-2">

        View Menu

    </a>

</div>

<div class="col-lg-4 col-md-6 col-sm-12 mb-3">

<% if ("Yes".equals(messClosed)) { %>

    <button class="btn btn-secondary w-100 py-2"
            disabled>

        Mess Closed

    </button>

<% } else { %>

    <a href="attendance.jsp"
       class="btn btn-success w-100 py-2">

        Mark Attendance

    </a>

<% } %>

</div>

<div class="col-lg-4 col-md-6 col-sm-12 mb-3">

    <a href="attendance_history.jsp"
       class="btn btn-dark w-100 py-2">

        Attendance History

    </a>

</div>

<div class="col-lg-4 col-md-6 col-sm-12 mb-3">

    <a href="payment.jsp"
       class="btn btn-warning w-100 py-2">

        Subscription / Payment

    </a>

</div>

<div class="col-lg-4 col-md-6 col-sm-12 mb-3">

    <a href="view_payment.jsp"
       class="btn btn-info w-100 py-2">

        View Payments

    </a>

</div>

<div class="col-lg-4 col-md-6 col-sm-12 mb-3">

    <a href="feedback.jsp"
       class="btn btn-secondary w-100 py-2">

        Give Feedback

    </a>

</div>

</div>

</div>

</body>
</html>