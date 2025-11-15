/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Category;

/**
 *
 * @author Dystopia
 */
public class CategoryDAO {

    public static List<Category> getAllCategoryName() {
        List<Category> cList = new ArrayList<>();
        String sql = "Select category_id, name  from Categories";

        try {
            DBContext db = DBContext.getInstance();
            Connection conn = db.connection;

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Category c = new Category(
                        rs.getInt("category_id"),
                        rs.getString("name")
                );
                cList.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return cList;
    }

    public static List<Category> getAllCategory() {
        List<Category> cList = new ArrayList<>();
        String sql = "Select * from Categories";

        try {
            DBContext db = DBContext.getInstance();
            Connection conn = db.connection;

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Category c = new Category(
                        rs.getInt("category_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("status")
                );
                cList.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return cList;
    }

    public static void addCategory(Category cate) {
        String sql = "Insert into Categories(name, description, status) values (?, ?, ?);";

        try {
            DBContext db = DBContext.getInstance();
            Connection conn = db.connection;

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, cate.getName());
            pstmt.setString(2, cate.getDescription());
            pstmt.setString(3, cate.getStatus());

            pstmt.executeUpdate();
            pstmt.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Category getCategoryById(int id) throws SQLException {
        String sql = "Select * from Categories c Where c.category_id = ?";
        Category cate = null;
        try {
            DBContext db = DBContext.getInstance();
            Connection conn = db.connection;

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                cate = new Category(
                        id,
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("status")
                );
            }
            rs.close();
            pstmt.close();
            return cate;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return cate;
    }

    public int editCategory(Category c) throws SQLException {
        String sql = "Update Categories SET name = ?, description = ?, status = ? WHERE category_id = ?";
        int row;
        DBContext db = DBContext.getInstance();
        Connection conn = db.connection;

        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, c.getName());
        pstmt.setString(2, c.getDescription());
        pstmt.setString(3, c.getStatus());
        pstmt.setInt(4, c.getCategoryId());
        row = pstmt.executeUpdate();

        pstmt.close();
        return row;
    }

    public boolean checkCategoryExists(String categoryName) {
        String cateLow = categoryName.toLowerCase();
        String sql = "SELECT COUNT(*) FROM Categories WHERE LOWER(name) = ?";    
        try {
            DBContext db = DBContext.getInstance();
            Connection conn = db.connection;

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, cateLow);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; 
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;  
    }
}
