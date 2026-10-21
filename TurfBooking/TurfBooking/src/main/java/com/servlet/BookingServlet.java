package com.servlet;

import com.Turf.DBConnection;
import com.util.EmailUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.DateTimeException;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp?error=login");
            return;
        }

        String dateText = request.getParameter("booking_date");
        String timeText = request.getParameter("booking_time");
        String venueText = request.getParameter("venue_id");

        if (dateText == null || timeText == null || venueText == null ||
            dateText.isBlank() || timeText.isBlank() || venueText.isBlank()) {
            response.sendRedirect("booking.jsp?error=missing");
            return;
        }

        try {
            int userId = (Integer) session.getAttribute("user_id");
            int venueId = Integer.parseInt(venueText);
            LocalDate bookingDate = LocalDate.parse(dateText);
            LocalTime bookingTime = LocalTime.parse(timeText);

            if (bookingDate.isBefore(LocalDate.now())) {
                response.sendRedirect("booking.jsp?error=past");
                return;
            }

            if (bookingDate.equals(LocalDate.now()) && bookingTime.isBefore(LocalTime.now())) {
                response.sendRedirect("booking.jsp?error=past");
                return;
            }

            String checkSql = """
                SELECT COUNT(*) FROM bookings
                WHERE venue_id = ? AND booking_date = ? AND booking_time = ?
                """;

            String insertSql = """
                INSERT INTO bookings (user_id, venue_id, booking_date, booking_time)
                VALUES (?, ?, ?, ?)
                """;

            try (Connection con = DBConnection.createConnection();
                 PreparedStatement check = con.prepareStatement(checkSql)) {

                check.setInt(1, venueId);
                check.setDate(2, Date.valueOf(bookingDate));
                check.setTime(3, Time.valueOf(bookingTime));

                try (ResultSet rs = check.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        response.sendRedirect("booking.jsp?error=booked");
                        return;
                    }
                }

                try (PreparedStatement ps = con.prepareStatement(insertSql)) {
                    ps.setInt(1, userId);
                    ps.setInt(2, venueId);
                    ps.setDate(3, Date.valueOf(bookingDate));
                    ps.setTime(4, Time.valueOf(bookingTime));

                    if (ps.executeUpdate() <= 0) {
                        response.sendRedirect("error.jsp");
                        return;
                    }
                }
            }

            String email = (String) session.getAttribute("email");
            if (email != null && !email.isBlank()) {
                String message = "Your TurfBook booking is confirmed for "
                        + bookingDate + " at " + bookingTime + ".";
                EmailUtil.sendConfirmationEmail(email, message);
            }

            response.sendRedirect("success.jsp");

        } catch (NumberFormatException | DateTimeException e) {
            response.sendRedirect("booking.jsp?error=invalid");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
