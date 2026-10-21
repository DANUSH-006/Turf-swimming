package com.Turf;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/turfbookingdb?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "MYSQL PASSWORD";

    private DBConnection() {}

    public static Connection createConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC driver not found. Check WEB-INF/lib/mysql-connector-j-9.6.0.jar", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
