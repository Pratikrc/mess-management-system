<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
if (session.getAttribute("email") == null) {
    response.sendRedirect("../login.jsp");
}
%>

<h2>Your Payments</h2>

<table border="1">
<tr>
    <th>Email</th>
    <th>Amount</th>
    <th>Status</th>
    <th>Date</th>
</tr>

<%
String email = (String) session.getAttribute("email");
Connection con = DBConnection.getConnection();
PreparedStatement ps = con.prepareStatement(
"SELECT * FROM payments WHERE user_email=?"
);

ps.setString(1, email);
ResultSet rs = ps.executeQuery();

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
