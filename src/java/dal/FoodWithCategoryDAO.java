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
import model.Food;
import model.FoodWithCategory;

/**
 *
 * @author Dystopia
 */
public class FoodWithCategoryDAO {

    
    public static List<FoodWithCategory> getAllFood() {
        List<FoodWithCategory> fWCList = new ArrayList<>();
        String sql = "SELECT f.*, c.name AS category_name, c.description AS category_desc\n"
                + "FROM Foods f\n"
                + "INNER JOIN Categories c ON f.category_id = c.category_id;";

        try {
            DBContext db = DBContext.getInstance();
            Connection conn = db.connection;

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                FoodWithCategory f = new FoodWithCategory(
                        rs.getInt("food_id"),
                        rs.getInt("category_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("status"),
                        rs.getString("category_name"),
                        rs.getString("category_desc")
                );
                fWCList.add(f);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return fWCList;
    }
    
    public static void addFoodfForMenu(){       
        
    }
    
    public static void editFoodForMenu(){
        
    }
    
}
