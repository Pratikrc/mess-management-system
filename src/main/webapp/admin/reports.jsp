<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
String email = (String) session.getAttribute("email");

String role = (String) session.getAttribute("role");

if (email == null || role == null || !role.equals("admin")) {

    response.sendRedirect("../login.jsp");
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

<title>Reports Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>

<body>

<!-- 🔥 NAVBAR -->

<nav class="navbar navbar-dark bg-dark">

    <div class="container-fluid">

        <span class="navbar-brand">
            📊 Smart Mess Reports
        </span>

        <a href="dashboard.jsp" class="btn btn-light">
            Back
        </a>

    </div>

</nav>

<div class="container mt-4">

<!-- 📊 SUMMARY CARDS -->

<div class="row">

<div class="col-md-3 mb-3">

    <div class="card shadow text-center bg-primary text-white">

        <div class="card-body">

            <h5>Total Users</h5>

            <h2><%= totalUsers %></h2>

        </div>

    </div>

</div>

<div class="col-md-3 mb-3">

    <div class="card shadow text-center bg-success text-white">

        <div class="card-body">

            <h5>Active Subscriptions</h5>

            <h2><%= activeSubs %></h2>

        </div>

    </div>

</div>

<div class="col-md-3 mb-3">

    <div class="card shadow text-center bg-warning text-dark">

        <div class="card-body">

            <h5>Total Meals Today</h5>

            <h2><%= totalMealsToday %></h2>

        </div>

    </div>

</div>

<div class="col-md-3 mb-3">

    <div class="card shadow text-center bg-danger text-white">

        <div class="card-body">

            <h5>Total Revenue</h5>

            <h2>₹ <%= totalRevenue %></h2>

        </div>

    </div>

</div>

</div>

<!-- 📋 REPORT TABLE -->

<div class="card shadow p-4 mb-4">

<h4 class="mb-3">
    📋 Daily & Monthly Analytics
</h4>

<table class="table table-bordered table-striped">

<thead class="table-dark">

<tr>

    <th>Report Type</th>

    <th>Value</th>

</tr>

</thead>

<tbody>

<tr>

    <td>🍛 Lunch Attendance Today</td>

    <td><%= lunchToday %></td>

</tr>

<tr>

    <td>🍽️ Dinner Attendance Today</td>

    <td><%= dinnerToday %></td>

</tr>

<tr>

    <td>📅 Monthly Attendance</td>

    <td><%= monthlyAttendance %></td>

</tr>

<tr>

    <td>💰 Total Revenue</td>

    <td>₹ <%= totalRevenue %></td>

</tr>

</tbody>

</table>

</div>

<!-- 📊 CHARTS -->

<div class="row">

<!-- PAYMENT CHART -->

<div class="col-md-6">

    <div class="card shadow p-3 mb-4">

        <h5 class="text-center">
            💳 Payment Report
        </h5>

        <canvas id="paymentChart"></canvas>

    </div>

</div>

<!-- ATTENDANCE CHART -->

<div class="col-md-6">

    <div class="card shadow p-3 mb-4">

        <h5 class="text-center">
            📊 Attendance Report
        </h5>

        <canvas id="attendanceChart"></canvas>

    </div>

</div>

</div>

</div>

<script>

// 💳 PAYMENT CHART

new Chart(document.getElementById("paymentChart"), {

    type: 'pie',

    data: {

        labels: ['Paid', 'Pending'],

        datasets: [{

            data: [<%=paid%>, <%=pending%>]

        }]
    }
});

// 📊 ATTENDANCE CHART

new Chart(document.getElementById("attendanceChart"), {

    type: 'bar',

    data: {

        labels: ['Present', 'Absent'],

        datasets: [{

            label: 'Attendance',

            data: [<%=present%>, <%=absent%>]

        }]
    }
});
</script>

</body>
</html>