package com.mess.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.mess.db.DBConnection;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {


protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String email = request.getParameter("email");
    String password = request.getParameter("password");

    try {
        Connection con = DBConnection.getConnection();

        String query = "SELECT * FROM users WHERE email=? AND password=?";
        PreparedStatement ps = con.prepareStatement(query);

        ps.setString(1, email);
        ps.setString(2, password);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {

            HttpSession session = request.getSession();

            session.setAttribute("user", rs.getString("name"));
            session.setAttribute("email", rs.getString("email"));
            session.setAttribute("role", rs.getString("role"));

            String role = rs.getString("role");

            if (role.equals("admin")) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp");
            }

        } else {
            response.getWriter().println("Invalid Email or Password");
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
}


}
