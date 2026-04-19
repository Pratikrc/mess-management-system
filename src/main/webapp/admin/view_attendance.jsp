<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
if (session.getAttribute("email") == null || 
    !session.getAttribute("role").equals("admin")) {
    response.sendRedirect("../login.jsp");
}
%>

<h2>Attendance Records</h2>

<table border="1">
<tr>
    <th>Email</th>
    <th>Date</th>
    <th>Status</th>
</tr>

<%
Connection con = DBConnection.getConnection();
Statement st = con.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM attendance");

while (rs.next()) {
%>

<tr>
    <td><%= rs.getString("user_email") %></td>
    <td><%= rs.getString("meal_date") %></td>
    <td><%= rs.getString("status") %></td>
</tr>
<% } %>

</table>

<a href="dashboard.jsp">Back</a>
