package com.servlet;

import com.util.EmailUtil;
import com.util.OtpGenerator;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/OtpServlet")
public class OtpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userEmail = request.getParameter("email");
        if (userEmail == null || userEmail.isBlank()) {
            response.sendRedirect("login.jsp?error=invalid");
            return;
        }

        String otp = OtpGenerator.generateOtp();
        HttpSession session = request.getSession();
        session.setAttribute("otp", otp);
        session.setAttribute("email", userEmail);

        if (EmailUtil.sendOtpEmail(userEmail, otp)) {
            response.sendRedirect("Otp.jsp");
        } else {
            response.sendRedirect("login.jsp?error=email");
        }
    }
}
