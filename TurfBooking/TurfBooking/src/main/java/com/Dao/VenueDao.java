package com.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import com.Turf.DBConnection;

public class VenueDao {

    public String registerVenue(String name, String location, String description,
                                double pricePerHour, String imageUrl, int ownerId) {

        String sql = "INSERT INTO venues " +
                     "(name, location, description, price_per_hour, image_url, owner_id) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, location);
            ps.setString(3, description);
            ps.setDouble(4, pricePerHour);
            ps.setString(5, imageUrl);
            ps.setInt(6, ownerId);

            return ps.executeUpdate() > 0 ? "SUCCESS" : "FAILURE";

        } catch (Exception e) {
            e.printStackTrace();
            return "FAILURE";
        }
    }
}
