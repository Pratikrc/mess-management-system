<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
if (session.getAttribute("email") == null || 
    !session.getAttribute("role").equals("admin")) {
    response.sendRedirect("../login.jsp");
}
%>

<h2>All Payments</h2>

<table border="1">
<tr>
    <th>Email</th>
    <th>Amount</th>
    <th>Status</th>
    <th>Date</th>
</tr>

<%
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
<% } %>

</table>

<a href="dashboard.jsp">Back</a>
