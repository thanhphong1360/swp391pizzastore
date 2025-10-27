/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import model.FoodWithCategory;

/**
 *
 * @author Dystopia
 */
public class CategoryDAO {
    public static List<Category> getAllCategoryName() {
        List<Category> cList = new ArrayList<>();
        String sql = "Select category_id, name from Categories";

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
}
