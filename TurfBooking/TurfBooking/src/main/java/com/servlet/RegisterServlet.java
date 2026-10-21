package com.servlet;

import com.Dao.UserDao;
import com.util.EmailUtil;
import com.util.OtpGenerator;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (isBlank(username) || isBlank(email) || isBlank(password) || isBlank(role)) {
            response.sendRedirect("login.jsp?error=missing");
            return;
        }

        UserDao dao = new UserDao();
        if (dao.userExistsByEmail(email)) {
            response.sendRedirect("login.jsp?error=exists");
            return;
        }

        String otp = OtpGenerator.generateOtp();
        HttpSession session = request.getSession();
        session.setAttribute("otp", otp);
        session.setAttribute("pending_username", username);
        session.setAttribute("pending_email", email);
        session.setAttribute("pending_password", password);
        session.setAttribute("pending_role", role);

        if (!EmailUtil.sendOtpEmail(email, otp)) {
            session.invalidate();
            response.sendRedirect("login.jsp?error=email");
            return;
        }

        request.getRequestDispatcher("Otp.jsp").forward(request, response);
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
