<%
if (session.getAttribute("email") == null) {

    response.sendRedirect("../login.jsp");

    return;
}

String message = request.getParameter("msg");

String type = request.getParameter("type");

if (type == null) {

    type = "info";
}
%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Mark Attendance</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet">

<link rel="stylesheet"
      href="../css/style.css">

</head>

<body class="bg-light">

<div class="container py-4">

<!-- 🔥 PAGE TITLE -->

<h3 class="text-center mb-4">

    Mark Attendance

</h3>

<!-- 🔔 MESSAGE -->

<% if (message != null) { %>

<div class="alert alert-<%= type %> text-center shadow-sm">

    <%= message %>

</div>

<% } %>

<div class="row">

<!-- 🍛 LUNCH CARD -->

<div class="col-lg-6 col-md-6 col-sm-12 mb-4">

<div class="card shadow-sm border-0 h-100">

<div class="card-body">

<h4 class="text-success mb-4 text-center">

    🍛 Lunch

</h4>

<form action="<%=request.getContextPath()%>/attendance"
      method="post">

<input type="hidden"
       name="meal_type"
       value="Lunch">

<!-- PRESENT -->

<div class="form-check mb-3">

    <input class="form-check-input"
           type="radio"
           name="status"
           value="Present"
           required>

    <label class="form-check-label">

        Present

    </label>

</div>

<!-- ABSENT -->

<div class="form-check mb-4">

    <input class="form-check-input"
           type="radio"
           name="status"
           value="Absent"
           required>

    <label class="form-check-label">

        Absent

    </label>

</div>

<button type="submit"
        class="btn btn-success w-100 py-2">

    Submit Lunch Attendance

</button>

</form>

</div>

</div>

</div>

<!-- 🍽️ DINNER CARD -->

<div class="col-lg-6 col-md-6 col-sm-12 mb-4">

<div class="card shadow-sm border-0 h-100">

<div class="card-body">

<h4 class="text-primary mb-4 text-center">

    🍽️ Dinner

</h4>

<form action="<%=request.getContextPath()%>/attendance"
      method="post">

<input type="hidden"
       name="meal_type"
       value="Dinner">

<!-- PRESENT -->

<div class="form-check mb-3">

    <input class="form-check-input"
           type="radio"
           name="status"
           value="Present"
           required>

    <label class="form-check-label">

        Present

    </label>

</div>

<!-- ABSENT -->

<div class="form-check mb-4">

    <input class="form-check-input"
           type="radio"
           name="status"
           value="Absent"
           required>

    <label class="form-check-label">

        Absent

    </label>

</div>

<button type="submit"
        class="btn btn-primary w-100 py-2">

    Submit Dinner Attendance

</button>

</form>

</div>

</div>

</div>

</div>

<!-- 🔙 BACK BUTTON -->

<div class="text-center mt-2">

<a href="dashboard.jsp"
   class="btn btn-secondary w-100 w-md-auto px-4">

    Back to Dashboard

</a>

</div>

</div>

</body>
</html>