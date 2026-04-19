package com.mess.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.mess.db.DBConnection;

@WebServlet("/subscribe")
public class SubscriptionServlet extends HttpServlet {


protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String email = request.getParameter("email");
    String plan = request.getParameter("plan");
    String start = request.getParameter("start_date");
    String end = request.getParameter("end_date");

    try {
        Connection con = DBConnection.getConnection();

        String query = "INSERT INTO subscription(user_email, plan_type, start_date, end_date) VALUES (?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);

        ps.setString(1, email);
        ps.setString(2, plan);
        ps.setString(3, start);
        ps.setString(4, end);

        ps.executeUpdate();

        response.sendRedirect("user/dashboard.jsp");

    } catch (Exception e) {
        e.printStackTrace();
    }
}


}
