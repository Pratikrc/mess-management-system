package com.mess.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.mess.db.DBConnection;

@WebServlet("/feedback")
public class FeedbackServlet extends HttpServlet {


protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws IOException {

    String email = (String) request.getSession().getAttribute("email");
    String message = request.getParameter("message");

    try {
        Connection con = DBConnection.getConnection();

        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO feedback(user_email, message) VALUES (?, ?)"
        );

        ps.setString(1, email);
        ps.setString(2, message);

        ps.executeUpdate();

        response.sendRedirect("user/feedback.jsp?msg=Feedback Submitted&type=success");

    } catch (Exception e) {
        e.printStackTrace();
    }
}


}
