/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {

    protected Connection connection;
    
    private static DBContext instance = new DBContext();

    public static DBContext getInstance() {
        return instance;
    }

    public Connection getConnection() {
        return connection;
    }
    
    public DBContext()
    {
        try {
            String user = "sa";
            String pass = "123"; //1, 123
            String url = "jdbc:sqlserver://localhost:1433;databaseName=PizzaRestaurantDB;TrustServerCertificate=true;";
            //jdbc:sqlserver://DESKTOP-LI8DM67:1433;databaseName=PizzaRestaurantDB;TrustServerCertificate=true;
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void main(String[] args) {
        try {
            Connection conn = DBContext.getInstance().getConnection();
            if (conn != null && !conn.isClosed()) {
                System.out.println("Kết nối thành công đến cơ sở dữ liệu!");
            } else {
                System.out.println(" Kết nối thất bại.");
            }
        } catch (Exception e) {
            System.out.println("Lỗi khi kết nối: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
