<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
if (session.getAttribute("email") == null) {
response.sendRedirect("../login.jsp");
}
String email = (String) session.getAttribute("email");
%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Your Payments</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">Your Payments</span>
        <a href="dashboard.jsp" class="btn btn-light">Back</a>
    </div>
</nav>

<div class="container mt-4">

```
<h3>Your Payment History</h3>

<table class="table table-bordered table-striped">

    <thead class="table-dark">
        <tr>
            <th>Amount</th>
            <th>Status</th>
            <th>Date</th>
        </tr>
    </thead>

    <tbody>

    <%
    try {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM payments WHERE user_email=?"
        );

        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
    %>

    <tr>
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
