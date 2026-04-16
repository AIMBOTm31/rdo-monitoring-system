package com.rdo.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static Connection connection = null;
    
    public static Connection getConnection() {
        if (connection == null) {
            try {
                // Load MySQL Driver (works with 9.6.0)
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                // Connection URL for MySQL 9.6.0
                String url = "jdbc:mysql://localhost:3306/rdo_monitoring_cg?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
                String username = "root";
                String password = "1234";  // XAMPP default is empty
                
                connection = DriverManager.getConnection(url, username, password);
                System.out.println("Database Connected Successfully!");
                
            } catch (ClassNotFoundException e) {
                System.err.println("MySQL JDBC Driver not found!");
                e.printStackTrace();
            } catch (SQLException e) {
                System.err.println("Database Connection Failed!");
                System.err.println("Error: " + e.getMessage());
                e.printStackTrace();
            }
        }
        return connection;
    }
    
    public static void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                connection = null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}