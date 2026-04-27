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
<title>View Payments</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">Payments</span>
        <a href="dashboard.jsp" class="btn btn-light">Back</a>
    </div>
</nav>

<div class="container mt-4">

```
<h3 class="mb-3">All Payments</h3>

<a href="../exportPayments" class="btn btn-success mb-3">Export CSV</a>

<table class="table table-bordered table-striped table-hover">

    <thead class="table-dark">
        <tr>
            <th>Email</th>
            <th>Amount</th>
            <th>Status</th>
            <th>Date</th>
        </tr>
    </thead>

    <tbody>

    <%
    try {
        Connection con = DBConnection.getConnection();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM payments");

        while (rs.next()) {
    %>

    <tr>
        <td><%= rs.getString("user_email") %></td>
        <td><%= rs.getString("amount") %></td>
        <td><%= rs.getString("status") %></td>
        <td><%= rs.getString("payment_date") %></td>
    </tr>

    <%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    %>

    </tbody>

</table>
```

</div>

</body>
</html>
