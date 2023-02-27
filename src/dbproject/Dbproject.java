/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbproject;

/**
 *
 * @author AMINUL
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Dbproject {


    private static String url = "jdbc:sqlserver://localhost:1433;databaseName=sketch;selectMethod=cursor";
    private static String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static String username = "sa";
    private static String password = "123456";
    private static Connection connection;
    private static String urlstring;

    public static Connection getConnection() {
        try {
            Class.forName(driverName);
            try {
                connection = DriverManager.getConnection(url, username, password);
                System.out.println("connection successful");
            } catch (SQLException ex) {
                // log an exception. fro example:
                System.out.println("Failed to create the database connection.");
                ex.printStackTrace();
            }
        } catch (ClassNotFoundException ex) {
            // log an exception. for example:
            System.out.println("Driver not found.");
        }
        return connection;
    }

    public static void main(String[] args) {

        getConnection();
    }
}

  
    

