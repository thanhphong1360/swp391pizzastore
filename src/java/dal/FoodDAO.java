/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

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

    public static ArrayList<Food> getFoodsSearch(Integer categoryId, String search) {
        ArrayList<Food> list = new ArrayList<>();
        DBContext dbc = DBContext.getInstance();
        //them food img url
        String sql = """
                     SELECT f.food_id, f.name, f.price, f.category_id
                             FROM Foods f
                             JOIN Categories c ON f.category_id = c.category_id
                             WHERE f.status = 'available'
                               AND (? IS NULL OR c.category_id = ?)
                               AND (? IS NULL OR f.name LIKE '%' + ? + '%')
                             ORDER BY f.name
                     """;
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            // set categoryId
            if (categoryId == null || categoryId == 0) {
                statement.setNull(1, java.sql.Types.INTEGER);
                statement.setNull(2, java.sql.Types.INTEGER);
            } else {
                statement.setInt(1, categoryId);
                statement.setInt(2, categoryId);
            }

            // set search
            if (search == null || search.trim().isEmpty()) {
                statement.setNull(3, java.sql.Types.NVARCHAR);
                statement.setNull(4, java.sql.Types.NVARCHAR);
            } else {
                statement.setString(3, search);
                statement.setString(4, search);
            }
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Food food = new Food();
                food.setFoodId(rs.getInt("food_id"));
                food.setCategoryId(rs.getInt("category_id"));
                food.setName(rs.getString("name"));
                food.setPrice(rs.getBigDecimal("price"));
                list.add(food);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return list.isEmpty() ? null : list;
    }
}
