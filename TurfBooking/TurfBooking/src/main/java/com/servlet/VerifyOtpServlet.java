package com.servlet;

import com.Dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/VerifyOtpServlet")
public class VerifyOtpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp?error=session");
            return;
        }

        String enteredOtp = request.getParameter("otp");
        String generatedOtp = (String) session.getAttribute("otp");
        String username = (String) session.getAttribute("pending_username");
        String email = (String) session.getAttribute("pending_email");
        String password = (String) session.getAttribute("pending_password");
        String role = (String) session.getAttribute("pending_role");

        if (enteredOtp == null || generatedOtp == null || !enteredOtp.trim().equals(generatedOtp)) {
            response.sendRedirect("Otp.jsp?error=invalid");
            return;
        }

        if (username == null || email == null || password == null || role == null) {
            response.sendRedirect("login.jsp?error=session");
            return;
        }

        UserDao dao = new UserDao();
        if (!dao.registerUser(username, email, password, role)) {
            response.sendRedirect("login.jsp?error=register");
            return;
        }

        session.removeAttribute("otp");
        session.removeAttribute("pending_username");
        session.removeAttribute("pending_email");
        session.removeAttribute("pending_password");
        session.removeAttribute("pending_role");
        session.setAttribute("verified", true);
        session.setAttribute("email", email);

        response.sendRedirect("login.jsp?verified=true");
    }
}
