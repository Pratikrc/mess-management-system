package com.mess.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.mess.db.DBConnection;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {


protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session = request.getSession();
    String email = (String) session.getAttribute("email");

    String amount = request.getParameter("amount");
    String status = request.getParameter("status");

    try {
        Connection con = DBConnection.getConnection();

        String query = "INSERT INTO payments(user_email, amount, status) VALUES (?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);

        ps.setString(1, email);
        ps.setString(2, amount);
        ps.setString(3, status);

        ps.executeUpdate();

        response.sendRedirect("user/dashboard.jsp");

    } catch (Exception e) {
        e.printStackTrace();
    }
}


}
