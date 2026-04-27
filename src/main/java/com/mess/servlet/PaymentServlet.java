package com.mess.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.mess.db.DBConnection;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {

protected void doPost(HttpServletRequest request, HttpServletResponse response)
throws IOException {


String email = (String) request.getSession().getAttribute("email");
String plan = request.getParameter("plan");
String mode = request.getParameter("mode");

int amount = plan.equals("Weekly") ? 500 : 2000;

try {
    Connection con = DBConnection.getConnection();

    PreparedStatement ps = con.prepareStatement(
        "INSERT INTO payments(user_email, amount, plan, payment_mode, status) VALUES (?, ?, ?, ?, 'Pending')"
    );

    ps.setString(1, email);
    ps.setInt(2, amount);
    ps.setString(3, plan);
    ps.setString(4, mode);

    ps.executeUpdate();

    response.sendRedirect("user/payment.jsp?msg=Waiting for admin approval&type=success");

} catch (Exception e) {
    e.printStackTrace();
}


}
}
