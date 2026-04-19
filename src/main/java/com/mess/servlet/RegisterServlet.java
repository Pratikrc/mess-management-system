package com.mess.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mess.db.DBConnection;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {


protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    try {
        Connection con = DBConnection.getConnection();

        String query = "INSERT INTO users(name, email, password) VALUES (?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);

        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, password);

        int result = ps.executeUpdate();

        if (result > 0) {
        	response.sendRedirect("login.jsp");
        } else {
            response.getWriter().println("Registration Failed");
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
}

}


