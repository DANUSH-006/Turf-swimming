package com.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.Turf.DBConnection;

public class BookingDao {
    public String createBooking(int userId, int venueId, String bookingDate, String bookingTime) {
        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(
                 "INSERT INTO bookings(user_id, venue_id, booking_date, booking_time) VALUES(?,?,?,?)")) {
            
            ps.setInt(1, userId);
            ps.setInt(2, venueId);
            ps.setString(3, bookingDate);
            ps.setString(4, bookingTime);
            
            if (ps.executeUpdate() > 0) {
                return "SUCCESS";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "FAILURE";
    }
}
