<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
String role = (String) session.getAttribute("role");

if (role == null || !role.equals("admin")) {
response.sendRedirect("../login.jsp");
return;
}
%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Manage Menu</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">Manage Menu</span>
        <a href="dashboard.jsp" class="btn btn-light">Back</a>
    </div>
</nav>

<div class="container mt-4">

<div class="row">

<!-- ADD MENU -->

<div class="col-md-4">
    <div class="card shadow p-3">
        <h4>Add Menu</h4>


    <form action="<%=request.getContextPath()%>/addMenu" method="post">

        <div class="mb-3">
            <label>Meal Type</label><br>
            <input type="radio" name="meal_type" value="Lunch" required> Lunch<br>
            <input type="radio" name="meal_type" value="Dinner" required> Dinner
        </div>

        <div class="mb-3">
            <label>Description</label>
            <textarea name="description" class="form-control" required></textarea>
        </div>

        <button type="submit" class="btn btn-success w-100">Add Menu</button>

    </form>
</div>


</div>

<!-- MENU LIST -->

<div class="col-md-8">
    <div class="card shadow p-3">
        <h4>Menu List</h4>


    <table class="table table-bordered table-striped">

        <thead class="table-dark">
            <tr>
                <th>Date</th>
                <th>Meal Type</th>
                <th>Description</th>
                <th>Action</th>
            </tr>
        </thead>

        <tbody>

        <%
        try {
            Connection con = DBConnection.getConnection();
            Statement st = con.createStatement();

            ResultSet rs = st.executeQuery("SELECT * FROM menu ORDER BY meal_date DESC");

            while (rs.next()) {
        %>

        <tr>
            <td><%= rs.getString("meal_date") %></td>
            <td><%= rs.getString("meal_type") %></td>
            <td><%= rs.getString("description") %></td>

            <td>
                <!-- EDIT -->
                <a href="edit_menu.jsp?id=<%= rs.getInt("id") %>"
                   class="btn btn-primary btn-sm">Edit</a>

                <!-- DELETE -->
                <a href="<%=request.getContextPath()%>/deleteMenu?id=<%= rs.getInt("id") %>"
                   class="btn btn-danger btn-sm"
                   onclick="return confirm('Are you sure you want to delete this menu?');">
                   Delete
                </a>
            </td>
        </tr>

        <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>

        </tbody>

    </table>

</div>


</div>

</div>

</div>

</body>
</html>
