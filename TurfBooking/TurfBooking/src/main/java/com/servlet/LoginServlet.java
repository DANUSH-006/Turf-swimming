package com.servlet;

import com.Turf.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String pass = request.getParameter("password");

        if (email == null || pass == null || email.isBlank() || pass.isBlank()) {
            response.sendRedirect("login.jsp?error=invalid");
            return;
        }

        String sql = "SELECT id, email, role FROM users WHERE email=? AND password=? LIMIT 1";

        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, pass);

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    response.sendRedirect("login.jsp?error=invalid");
                    return;
                }

                HttpSession session = request.getSession(true);
                session.setAttribute("user_id", rs.getInt("id"));
                session.setAttribute("user_role", rs.getString("role"));
                session.setAttribute("email", rs.getString("email"));
                session.setAttribute("verified", true);

                if ("business".equals(rs.getString("role"))) {
                    response.sendRedirect("venue.jsp");
                } else {
                    response.sendRedirect("booking.jsp");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
