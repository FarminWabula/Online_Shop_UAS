package com.onlineshop.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Singleton class untuk koneksi database
 */
public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/onlineshop_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&createDatabaseIfNotExist=true";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    
    private static DatabaseConnection instance;
    private Connection connection;
    
    private DatabaseConnection() throws SQLException {
        try {
            Class.forName(DRIVER);
            this.connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            System.out.println("Database connection established successfully!");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL Driver tidak ditemukan: " + e.getMessage());
            throw new SQLException("MySQL Driver tidak ditemukan", e);
        } catch (SQLException e) {
            System.err.println("Error connecting to database: " + e.getMessage());
            System.err.println("URL: " + URL);
            System.err.println("Username: " + USERNAME);
            throw e;
        }
    }
    
    public static synchronized DatabaseConnection getInstance() throws SQLException {
        if (instance == null || instance.getConnection().isClosed()) {
            instance = new DatabaseConnection();
        }
        return instance;
    }
    
    public Connection getConnection() {
        return connection;
    }
    
    public void closeConnection() throws SQLException {
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
    }
    
    // Method untuk testing koneksi
    public boolean testConnection() {
        try {
            return connection != null && !connection.isClosed();
        } catch (SQLException e) {
            System.err.println("Error testing connection: " + e.getMessage());
            return false;
        }
    }
    
    // Method untuk reconnect jika koneksi terputus
    public void reconnect() throws SQLException {
        try {
            if (connection == null || connection.isClosed()) {
                Class.forName(DRIVER);
                this.connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                System.out.println("Database reconnected successfully!");
            }
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL Driver tidak ditemukan", e);
        }
    }
}