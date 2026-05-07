package com.mess.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.mess.db.DBConnection;

@WebServlet("/serveMeal")
public class ServeMealServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException {

        String role = (String) request.getSession()
                                      .getAttribute("role");

        // 🔒 ADMIN SECURITY
        if (role == null || !role.equals("admin")) {

            response.sendRedirect("login.jsp");

            return;
        }

        String id = request.getParameter("id");

        try {

            Connection con = DBConnection.getConnection();

            // 🔥 UPDATE SERVED STATUS
            PreparedStatement ps = con.prepareStatement(

                "UPDATE attendance " +
                "SET served='Yes' " +
                "WHERE id=?"
            );

            ps.setInt(1, Integer.parseInt(id));

            ps.executeUpdate();

            response.sendRedirect(
                "admin/meal_verification.jsp"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                "admin/meal_verification.jsp"
            );
        }
    }
}