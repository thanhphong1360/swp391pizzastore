/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Table;
import model.Food;
import model.Category;

/**
 *
 * @author cungp
 */
public class FoodDAO {
    public static ArrayList<Food> getAllFood() {
        ArrayList<Food> list = new ArrayList<>();
        DBContext dbc = DBContext.getInstance();
        String sql = "SELECT * FROM Foods";
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Food food = new Food(rs.getInt("food_id"),
                                    rs.getInt("category_id"),
                                    rs.getString("name"),
                                    rs.getString("description"),
                                    rs.getBigDecimal("price"),
                                    rs.getString("status"));
                list.add(food);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return list.isEmpty() ? null : list;
    }
    
    public static Food getFoodById(int foodId) {
        ArrayList<Food> list = new ArrayList<>();
        DBContext dbc = DBContext.getInstance();
        String sql = "SELECT * FROM Foods WHERE food_id = ?";
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setInt(1, foodId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Food food = new Food(rs.getInt("food_id"),
                                    rs.getInt("category_id"),
                                    rs.getString("name"),
                                    rs.getString("description"),
                                    rs.getBigDecimal("price"),
                                    rs.getString("status"));
                list.add(food);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return list.isEmpty() ? null : list.get(0);
    }
}
