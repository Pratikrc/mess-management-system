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

protected void doPost(HttpServletRequest request,
                      HttpServletResponse response)
        throws ServletException, IOException {

    String name = request.getParameter("name");

    String email = request.getParameter("email").toLowerCase().trim();

    String phone = request.getParameter("phone");

    String password = request.getParameter("password");

 // NAME VALIDATION
    if (!name.matches("[A-Za-z ]+")) {

        response.sendRedirect(
            "register.jsp?msg=Name should contain only letters&type=error"
        );

        return;
    }

    // PASSWORD VALIDATION
    String passwordRegex =
    	    "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=!]).{8,}$";

    	if (!password.matches(passwordRegex)) {

    	    response.sendRedirect(
    	        "register.jsp?msg=Password must contain uppercase, lowercase, number and special symbol&type=error"
    	    );

    	    return;
    	}
    	String emailRegex =
    			"^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";

    		if(!email.matches(emailRegex)){

    		    response.sendRedirect(
    		        "register.jsp?msg=Invalid Email Format&type=error"
    		    );

    		    return;
    		}
    try {

        Connection con = DBConnection.getConnection();

        String query =

            "INSERT INTO users(name, email, phone, password) " +
            "VALUES (?, ?, ?, ?)";

        PreparedStatement ps = con.prepareStatement(query);

        ps.setString(1, name);

        ps.setString(2, email);

        ps.setString(3, phone);

        ps.setString(4, password);

        int result = ps.executeUpdate();

        if (result > 0) {

            response.sendRedirect(

                "login.jsp?msg=Registration Successful&type=success"
            );

        } else {

            response.getWriter().println(
                "Registration Failed"
            );
        }

    } catch (Exception e) {

        e.printStackTrace();
    }
}

}