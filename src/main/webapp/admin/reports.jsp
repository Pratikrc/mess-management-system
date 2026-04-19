<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
if (session.getAttribute("email") == null || 
    !session.getAttribute("role").equals("admin")) {
    response.sendRedirect("../login.jsp");
}
%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Reports</title>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>
<body>

<h2>Payment Report</h2>

<%
int paid = 0;
int pending = 0;

try {
Connection con = DBConnection.getConnection();
Statement st = con.createStatement();


ResultSet rs = st.executeQuery("SELECT status, COUNT(*) as count FROM payments GROUP BY status");

while (rs.next()) {
    if (rs.getString("status").equals("Paid")) {
        paid = rs.getInt("count");
    } else {
        pending = rs.getInt("count");
    }
}


} catch (Exception e) {
e.printStackTrace();
}
%>

<canvas id="paymentChart" width="400" height="200"></canvas>

<script>
var ctx = document.getElementById('paymentChart').getContext('2d');

var paymentChart = new Chart(ctx, {
    type: 'pie',
    data: {
        labels: ['Paid', 'Pending'],
        datasets: [{
            label: 'Payments',
            data: [<%=paid%>, <%=pending%>]
        }]
    }
});
</script>

<hr>

<h2>Attendance Report</h2>

<%
int present = 0;
int absent = 0;

try {
Connection con = DBConnection.getConnection();
Statement st = con.createStatement();


ResultSet rs = st.executeQuery("SELECT status, COUNT(*) as count FROM attendance GROUP BY status");

while (rs.next()) {
    if (rs.getString("status").equals("Present")) {
        present = rs.getInt("count");
    } else {
        absent = rs.getInt("count");
    }
}


} catch (Exception e) {
e.printStackTrace();
}
%>

<canvas id="attendanceChart" width="400" height="200"></canvas>

<script>
var ctx2 = document.getElementById('attendanceChart').getContext('2d');

var attendanceChart = new Chart(ctx2, {
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

<a href="dashboard.jsp">Back</a>

</body>
</html>
