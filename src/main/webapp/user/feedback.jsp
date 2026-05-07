<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%
if (session.getAttribute("email") == null) {

    response.sendRedirect("../login.jsp");

    return;
}
%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Feedback</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet">

</head>

<body class="bg-light">

<!-- 🔥 NAVBAR -->

<nav class="navbar navbar-dark bg-dark">

    <div class="container-fluid">

        <span class="navbar-brand">
            Feedback
        </span>

        <a href="dashboard.jsp"
           class="btn btn-light btn-sm">

            Back

        </a>

    </div>

</nav>

<div class="container py-4">

<div class="row justify-content-center">

<div class="col-lg-6 col-md-8 col-sm-12">

<div class="card shadow-sm border-0">

<div class="card-body p-4">

<!-- 🔥 TITLE -->

<h3 class="text-center mb-4">

    💬 Give Feedback

</h3>

<!-- 🔔 MESSAGE -->

<%
String msg = request.getParameter("msg");

String type = request.getParameter("type");

if (msg != null) {
%>

<div class="alert
    <%= "success".equals(type)
        ? "alert-success"
        : "alert-danger" %>">

    <%= msg %>

</div>

<%
}
%>

<!-- 📝 FEEDBACK FORM -->

<form action="<%=request.getContextPath()%>/feedback"
      method="post">

<div class="mb-4">

<label class="form-label fw-bold">

    Your Feedback

</label>

<textarea name="message"
          class="form-control"
          rows="5"
          placeholder="Write your feedback here..."
          required></textarea>

</div>

<button type="submit"
        class="btn btn-primary w-100 py-2">

    Submit Feedback

</button>

</form>

<!-- 🔙 BACK BUTTON -->

<div class="text-center mt-4">

<a href="dashboard.jsp"
   class="btn btn-secondary w-100 py-2">

    Back to Dashboard

</a>

</div>

</div>

</div>

</div>

</div>

</div>

</body>
</html>