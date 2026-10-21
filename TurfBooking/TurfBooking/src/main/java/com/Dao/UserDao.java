package com.Dao;

import com.Turf.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UserDao {
    public boolean registerUser(String username, String email, String password, String role) {
        String sql = "INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, ?)";
        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, role);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("User registration failed: " + e.getMessage());
            return false;
        }
    }

    public boolean userExistsByEmail(String email) {
        String sql = "SELECT 1 FROM users WHERE email = ? LIMIT 1";
        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            return ps.executeQuery().next();
        } catch (SQLException e) {
            System.err.println("Could not check email: " + e.getMessage());
            return false;
        }
    }
}
