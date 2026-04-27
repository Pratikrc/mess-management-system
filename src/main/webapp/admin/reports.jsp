<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
String email = (String) session.getAttribute("email");
String role = (String) session.getAttribute("role");

if (email == null || role == null || !role.equals("admin")) {
response.sendRedirect("../login.jsp");
}
%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Reports</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>

<body>

<!-- Navbar -->

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">Reports</span>
        <a href="dashboard.jsp" class="btn btn-light">Back</a>
    </div>
</nav>

<div class="container mt-4">

```
<div class="row">

    <!-- Payment Chart -->
    <div class="col-md-6">
        <div class="card shadow p-3 mb-4">
            <h5 class="text-center">Payment Report</h5>

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

            <canvas id="paymentChart"></canvas>
        </div>
    </div>

    <!-- Attendance Chart -->
    <div class="col-md-6">
        <div class="card shadow p-3 mb-4">
            <h5 class="text-center">Attendance Report</h5>

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

            <canvas id="attendanceChart"></canvas>
        </div>
    </div>

</div>
```

</div>

<script>
new Chart(document.getElementById("paymentChart"), {
    type: 'pie',
    data: {
        labels: ['Paid', 'Pending'],
        datasets: [{
            data: [<%=paid%>, <%=pending%>]
        }]
    }
});

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
