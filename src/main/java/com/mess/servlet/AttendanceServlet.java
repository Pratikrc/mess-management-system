package com.mess.servlet;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.mess.db.DBConnection;

@WebServlet("/attendance")
public class AttendanceServlet extends HttpServlet {


protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String email = request.getParameter("email");
    String status = request.getParameter("status");
    String today = LocalDate.now().toString();

    try {
        Connection con = DBConnection.getConnection();

        // Check if already marked
        PreparedStatement check = con.prepareStatement(
            "SELECT * FROM attendance WHERE user_email=? AND meal_date=?"
        );
        check.setString(1, email);
        check.setString(2, today);

        ResultSet rs = check.executeQuery();

        if (rs.next()) {
            response.getWriter().println("Already marked for today!");
        } else {
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO attendance(user_email, meal_date, status) VALUES (?, ?, ?)"
            );

            ps.setString(1, email);
            ps.setString(2, today);
            ps.setString(3, status);

            ps.executeUpdate();

            response.sendRedirect("user/dashboard.jsp");
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
}


}
