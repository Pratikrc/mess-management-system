<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
if (session.getAttribute("email") == null) {
response.sendRedirect("../login.jsp");
return;
}

String email = (String) session.getAttribute("email");

boolean active = false;
boolean hasPendingPayment = false;

String plan = "";
String endDate = "";

try {
Connection con = DBConnection.getConnection();


// 🔍 CHECK SUBSCRIPTION
PreparedStatement ps1 = con.prepareStatement(
    "SELECT * FROM subscription WHERE user_email=? ORDER BY end_date DESC LIMIT 1"
);
ps1.setString(1, email);
ResultSet rs1 = ps1.executeQuery();

if (rs1.next()) {
    plan = rs1.getString("plan_type");
    endDate = rs1.getString("end_date");

    java.sql.Date ed = rs1.getDate("end_date");

    if (ed.getTime() >= System.currentTimeMillis()) {
        active = true;
    }
}

// 🔍 CHECK PENDING PAYMENT
PreparedStatement ps2 = con.prepareStatement(
    "SELECT * FROM payments WHERE user_email=? AND status='Pending'"
);
ps2.setString(1, email);
ResultSet rs2 = ps2.executeQuery();

if (rs2.next()) {
    hasPendingPayment = true;
}


} catch (Exception e) {
e.printStackTrace();
}
%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Subscription Payment</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="container mt-5">
<div class="card shadow p-4">

<h3 class="text-center mb-3">Subscription Payment</h3>

<%
String msg = request.getParameter("msg");
String type = request.getParameter("type");

if (msg != null) {
%>

<div class="alert <%= type.equals("success") ? "alert-success" : "alert-danger" %>">
    <%= msg %>
</div>
<% } %>

<!-- 🟢 CASE 1: ACTIVE SUBSCRIPTION -->

<% if (active) { %>

<div class="text-center">
    <h4 class="text-success">Already Subscribed ✅</h4>


<p><b>Plan:</b> <%= plan %></p>
<p><b>Expiry Date:</b> <%= endDate %></p>

<a href="dashboard.jsp" class="btn btn-primary mt-3">Back to Dashboard</a>


</div>

<!-- 🟡 CASE 2: PENDING PAYMENT -->

<% } else if (hasPendingPayment) { %>

<div class="text-center">
    <h4 class="text-warning">Payment Pending Approval ⏳</h4>


<p>Please wait for admin approval.</p>

<a href="../login.jsp" class="btn btn-success mt-3">Go to Login</a>


</div>

<!-- 🔵 CASE 3: SHOW PAYMENT FORM -->

<% } else { %>

<form action="<%=request.getContextPath()%>/payment" method="post">


<div class="mb-3">
    <label>Select Plan</label><br>
    <input type="radio" name="plan" value="Weekly" required> Weekly (₹500)<br>
    <input type="radio" name="plan" value="Monthly" required> Monthly (₹2000)
</div>

<div class="mb-3">
    <label>Payment Mode</label><br>
    <input type="radio" name="mode" value="Online" required onclick="showOnline()"> Online (UPI)<br>
    <input type="radio" name="mode" value="Offline" required onclick="showOffline()"> Offline
</div>

<div id="onlineBox" style="display:none;">
    <p><b>UPI ID:</b> mess@upi</p>

    <div class="text-center">
        <img src="<%=request.getContextPath()%>/images/qr.png" width="180">
    </div>

    <p class="text-danger text-center mt-2">
        ⚠ Add your <b>Name</b> while making payment
    </p>
</div>

<div id="offlineBox" style="display:none;">
    <p class="text-warning text-center">
        Pay to mess owner. Waiting for admin approval.
    </p>
</div>

<button class="btn btn-primary w-100 mt-3">Submit Payment</button>


</form>

<% } %>

</div>
</div>

<script>
function showOnline(){
    document.getElementById("onlineBox").style.display="block";
    document.getElementById("offlineBox").style.display="none";
}
function showOffline(){
    document.getElementById("onlineBox").style.display="none";
    document.getElementById("offlineBox").style.display="block";
}
</script>

</body>
</html>
