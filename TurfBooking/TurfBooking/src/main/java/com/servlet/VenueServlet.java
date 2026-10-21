package com.servlet;

import java.io.IOException;
import com.Dao.VenueDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/VenueServlet")
public class VenueServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || !"business".equals(session.getAttribute("user_role"))) {
            response.sendRedirect("login.jsp?error=login");
            return;
        }

        String name = request.getParameter("name");
        String location = request.getParameter("location");
        String description = request.getParameter("description");
        String priceText = request.getParameter("price_per_hour");
        String imageUrl = request.getParameter("image_url");

        if (name == null || name.isBlank() ||
            location == null || location.isBlank() ||
            priceText == null || priceText.isBlank()) {
            response.sendRedirect("venue.jsp?status=missing");
            return;
        }

        double pricePerHour;
        try {
            pricePerHour = Double.parseDouble(priceText);
            if (pricePerHour <= 0) {
                response.sendRedirect("venue.jsp?status=invalid");
                return;
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("venue.jsp?status=invalid");
            return;
        }

        if (imageUrl == null || imageUrl.isBlank()) {
            imageUrl = "images/turf1.jpeg";
        }

        int ownerId = (Integer) session.getAttribute("user_id");

        VenueDao dao = new VenueDao();
        String result = dao.registerVenue(name.trim(), location.trim(),
                description == null ? "" : description.trim(),
                pricePerHour, imageUrl.trim(), ownerId);

        if ("SUCCESS".equals(result)) {
            response.sendRedirect("venue.jsp?status=success");
        } else {
            response.sendRedirect("venue.jsp?status=error");
        }
    }
}
