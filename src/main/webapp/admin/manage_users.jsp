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
<title>Manage Users</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">Manage Users</span>
        <a href="dashboard.jsp" class="btn btn-light">Back</a>
    </div>
</nav>

<div class="container mt-4">

```
<h3 class="mb-3">User List</h3>

<table class="table table-bordered table-striped table-hover">

    <thead class="table-dark">
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
    </thead>

    <tbody>

    <%
    try {
        Connection con = DBConnection.getConnection();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM users");

        while (rs.next()) {
    %>

    <tr>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("email") %></td>
        <td>
            <span class="badge 
                <%= rs.getString("status").equals("approved") ? "bg-success" : "bg-warning" %>">
                <%= rs.getString("status") %>
            </span>
        </td>

        <td>
            <% if (rs.getString("status").equals("pending")) { %>
                <a href="../approveUser?email=<%= rs.getString("email") %>" 
                   class="btn btn-success btn-sm">Approve</a>
            <% } else { %>
                <span class="text-success">Approved</span>
            <% } %>
        </td>
    </tr>

    <%
        }
    } catch(Exception e) {
        e.printStackTrace();
    }
    %>

    </tbody>

</table>
```

</div>

</body>
</html>
