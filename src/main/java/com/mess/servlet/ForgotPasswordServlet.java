package com.mess.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mess.db.DBConnection;

@WebServlet("/forgotPassword")
public class ForgotPasswordServlet extends HttpServlet {

protected void doPost(HttpServletRequest request,
                      HttpServletResponse response)
        throws ServletException, IOException {

    String email = request.getParameter("email");

    String phone = request.getParameter("phone");

    String password = request.getParameter("password");

    try {

        Connection con = DBConnection.getConnection();

        // 🔍 VERIFY USER
        PreparedStatement check = con.prepareStatement(

            "SELECT * FROM users " +
            "WHERE email=? AND phone=?"
        );

        check.setString(1, email);

        check.setString(2, phone);

        ResultSet rs = check.executeQuery();

        // ✅ USER FOUND
        if (rs.next()) {

            PreparedStatement update = con.prepareStatement(

                "UPDATE users " +
                "SET password=? " +
                "WHERE email=?"
            );

            update.setString(1, password);

            update.setString(2, email);

            update.executeUpdate();

            response.sendRedirect(

                "login.jsp?msg=Password Reset Successful&type=success"
            );

        } else {

            response.sendRedirect(

                "forgot_password.jsp?msg=Invalid Email or Phone Number&type=error"
            );
        }

    } catch (Exception e) {

        e.printStackTrace();

        response.sendRedirect(

            "forgot_password.jsp?msg=Something went wrong&type=error"
        );
    }
}

}