<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
String email = (String) session.getAttribute("email");

String role = (String) session.getAttribute("role");

if (email == null || role == null || !role.equals("admin")) {

    response.sendRedirect("../login.jsp");

    return;
}

// 📊 VARIABLES
int totalUsers = 0;
int activeSubs = 0;

int lunchToday = 0;
int dinnerToday = 0;

int totalMealsToday = 0;

double totalRevenue = 0;

int monthlyAttendance = 0;

// 📊 CHART VARIABLES
int paid = 0;
int pending = 0;

int present = 0;
int absent = 0;

try {

    Connection con = DBConnection.getConnection();

    Statement st = con.createStatement();

    // 👥 TOTAL USERS
    ResultSet rs1 = st.executeQuery(

        "SELECT COUNT(*) FROM users WHERE role='user'"
    );

    if (rs1.next()) {

        totalUsers = rs1.getInt(1);
    }

    // 💳 ACTIVE SUBSCRIPTIONS
    ResultSet rs2 = st.executeQuery(

        "SELECT COUNT(DISTINCT user_email) " +
        "FROM subscription " +
        "WHERE end_date >= CURDATE()"
    );

    if (rs2.next()) {

        activeSubs = rs2.getInt(1);
    }

    // 🍛 LUNCH TODAY
    ResultSet rs3 = st.executeQuery(

        "SELECT COUNT(*) FROM attendance " +
        "WHERE meal_type='Lunch' " +
        "AND status='Present' " +
        "AND meal_date=CURDATE()"
    );

    if (rs3.next()) {

        lunchToday = rs3.getInt(1);
    }

    // 🍽️ DINNER TODAY
    ResultSet rs4 = st.executeQuery(

        "SELECT COUNT(*) FROM attendance " +
        "WHERE meal_type='Dinner' " +
        "AND status='Present' " +
        "AND meal_date=CURDATE()"
    );

    if (rs4.next()) {

        dinnerToday = rs4.getInt(1);
    }

    totalMealsToday = lunchToday + dinnerToday;

    // 💰 TOTAL REVENUE
    ResultSet rs5 = st.executeQuery(

        "SELECT SUM(amount) FROM payments " +
        "WHERE status='Paid'"
    );

    if (rs5.next()) {

        totalRevenue = rs5.getDouble(1);
    }

    // 📅 MONTHLY ATTENDANCE
    ResultSet rs6 = st.executeQuery(

        "SELECT COUNT(*) FROM attendance " +
        "WHERE MONTH(meal_date)=MONTH(CURDATE()) " +
        "AND YEAR(meal_date)=YEAR(CURDATE())"
    );

    if (rs6.next()) {

        monthlyAttendance = rs6.getInt(1);
    }

    // 💳 PAYMENT REPORT
    ResultSet rs7 = st.executeQuery(

        "SELECT status, COUNT(*) as count " +
        "FROM payments GROUP BY status"
    );

    while (rs7.next()) {

        if ("Paid".equals(rs7.getString("status"))) {

            paid = rs7.getInt("count");

        } else {

            pending = rs7.getInt("count");
        }
    }

    // 📊 ATTENDANCE REPORT
    ResultSet rs8 = st.executeQuery(

        "SELECT status, COUNT(*) as count " +
        "FROM attendance GROUP BY status"
    );

    while (rs8.next()) {

        if ("Present".equals(rs8.getString("status"))) {

            present = rs8.getInt("count");

        } else {

            absent = rs8.getInt("count");
        }
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

<title>Reports Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet">

<link rel="stylesheet"
      href="../css/style.css">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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

<a href="manage_users.jsp"
   class="btn btn-outline-light text-start">

     Manage Users

</a>

<a href="add_menu.jsp"
   class="btn btn-outline-light text-start">

     Manage Menu

</a>

<a href="add_announcement.jsp"
   class="btn btn-outline-light text-start">

     Announcement

</a>

<a href="view_attendance.jsp"
   class="btn btn-outline-light text-start">

     Attendance

</a>

<a href="meal_verification.jsp"
   class="btn btn-outline-light text-start">

     Meal Verification

</a>

<a href="view_payments.jsp"
   class="btn btn-outline-light text-start">

     Payments

</a>

<a href="view_subscription.jsp"
   class="btn btn-outline-light text-start">

     Subscriptions

</a>

<a href="view_feedback.jsp"
   class="btn btn-outline-light text-start">

     Feedback

</a>

<a href="reports.jsp"
   class="btn btn-outline-light text-start">

     Reports

</a>

<a href="../logout"
   class="btn btn-danger text-start mt-3">

     Logout

</a>

</div>

</div>

<!-- ===================================
     MAIN CONTENT
=================================== -->

<div class="col-lg-10 col-md-9 p-4">
<!-- TOPBAR -->

<div class="topbar d-flex justify-content-between align-items-center flex-wrap">

<div>

<h3 class="mb-1">

     Analytics Dashboard

</h3>

<p class="text-muted mb-0">

    Smart Mess business insights and reports

</p>

</div>

<div class="mt-2 mt-md-0">

<span class="badge bg-gradient-primary p-3">

    Executive Analytics

</span>

</div>

</div>

<!-- ANALYTICS CARDS -->

<div class="row mb-4">

<div class="col-lg-3 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-primary h-100">

<div class="card-body">

<h5> Users</h5>

<h2><%= totalUsers %></h2>

<p class="mb-0">

    Registered students

</p>

</div>

</div>

</div>

<div class="col-lg-3 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-success h-100">

<div class="card-body">

<h5> Active Plans</h5>

<h2><%= activeSubs %></h2>

<p class="mb-0">

    Active subscriptions

</p>

</div>

</div>

</div>

<div class="col-lg-3 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-warning h-100">

<div class="card-body">

<h5> Meals Today</h5>

<h2><%= totalMealsToday %></h2>

<p class="mb-0">

    Total meals served

</p>

</div>

</div>

</div>

<div class="col-lg-3 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-danger h-100">

<div class="card-body">

<h5> Revenue</h5>

<h2> <%= totalRevenue %></h2>

<p class="mb-0">

    Total earnings

</p>

</div>

</div>

</div>

</div>

<!-- DAILY ANALYTICS -->

<div class="card border-0 mb-4">

<div class="card-body">

<div class="d-flex justify-content-between align-items-center flex-wrap mb-4">

<div>

<h4 class="mb-1">

     Analytics Summary

</h4>

<p class="text-muted mb-0">

    Daily and monthly system statistics

</p>

</div>

</div>

<div class="table-responsive">

<table class="table table-hover align-middle">

<thead>

<tr>

<th>Report Type</th>

<th>Value</th>

</tr>

</thead>

<tbody>

<tr>

<td> Lunch Attendance Today</td>

<td class="fw-bold"><%= lunchToday %></td>

</tr>

<tr>

<td> Dinner Attendance Today</td>

<td class="fw-bold"><%= dinnerToday %></td>

</tr>

<tr>

<td> Monthly Attendance</td>

<td class="fw-bold"><%= monthlyAttendance %></td>

</tr>

<tr>

<td> Total Revenue</td>

<td class="fw-bold text-success">

     <%= totalRevenue %>

</td>

</tr>

</tbody>

</table>

</div>

</div>

</div>

<!-- CHARTS -->

<div class="row">

<!-- PAYMENT -->

<div class="col-lg-6 mb-4">

<div class="card border-0 h-100">

<div class="card-body">

<h4 class="mb-4 text-center">

     Payment Analytics

</h4>

<div style="height:350px;">

<canvas id="paymentChart"></canvas>

</div>

</div>

</div>

</div>

<!-- ATTENDANCE -->

<div class="col-lg-6 mb-4">

<div class="card border-0 h-100">

<div class="card-body">

<h4 class="mb-4 text-center">

     Attendance Analytics

</h4>

<div style="height:350px;">

<canvas id="attendanceChart"></canvas>

</div>

</div>

</div>

</div>

</div>

<!-- QUICK ACTIONS -->

<div class="card border-0">

<div class="card-body">

<div class="row text-center">

<div class="col-md-4 mb-3 mb-md-0">

<a href="dashboard.jsp"
   class="btn btn-primary w-100 py-3">

     Dashboard

</a>

</div>

<div class="col-md-4 mb-3 mb-md-0">

<a href="view_payments.jsp"
   class="btn btn-success w-100 py-3">

     Payments

</a>

</div>

<div class="col-md-4">

<a href="manage_users.jsp"
   class="btn btn-dark w-100 py-3">

     Users

</a>

</div>

</div>

</div>

</div>

</div>

</div>

</div>

<!-- CHARTS -->

<script>

// PAYMENT CHART

new Chart(document.getElementById("paymentChart"), {

    type: 'doughnut',

    data: {

        labels: ['Paid', 'Pending'],

        datasets: [{

            data: [<%=paid%>, <%=pending%>]

        }]
    },

    options: {

        responsive: true,

        maintainAspectRatio: false
    }
});

// ATTENDANCE CHART

new Chart(document.getElementById("attendanceChart"), {

    type: 'bar',

    data: {

        labels: ['Present', 'Absent'],

        datasets: [{

            label: 'Attendance',

            data: [<%=present%>, <%=absent%>]

        }]
    },

    options: {

        responsive: true,

        maintainAspectRatio: false
    }
});

</script>

</body>
</html>