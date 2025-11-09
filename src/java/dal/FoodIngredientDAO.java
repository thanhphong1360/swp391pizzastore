/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Ingredient;

/**
 *
 * @author Dystopia
 */
public class FoodIngredientDAO {

    public static void addIngredientToFood(int foodId, int ingredientId, double quantity) {
        String sql = "INSERT INTO FoodIngredients (food_id, ingredient_id, quantity) VALUES (?, ?, ?)";

        try {
            DBContext db = DBContext.getInstance();
            Connection conn = db.connection;
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, foodId);
            ps.setInt(2, ingredientId);
            ps.setDouble(3, quantity);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Cập nhật số lượng nguyên liệu
    public static void updateIngredientQuantity(int foodId, int ingredientId, double quantity) {
        String sql = "UPDATE FoodIngredients SET quantity = ? WHERE food_id = ? AND ingredient_id = ?";

        try {
            DBContext db = DBContext.getInstance();
            Connection conn = db.connection;
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setDouble(1, quantity);
            ps.setInt(2, foodId);
            ps.setInt(3, ingredientId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Xóa nguyên liệu khỏi món ăn
    public static void deleteIngredientFromFood(int foodId, int ingredientId) {
        String sql = "DELETE FROM FoodIngredients WHERE food_id = ? AND ingredient_id = ?";

        try {
            DBContext db = DBContext.getInstance();
            Connection conn = db.connection;
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, foodId);
            ps.setInt(2, ingredientId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static List<Ingredient> getAllIngredients() {
        List<Ingredient> list = new ArrayList<>();
        String sql = "SELECT ingredient_id, name, description, unit, quantity FROM Ingredients";

        try  {
            DBContext db = DBContext.getInstance();
            Connection conn = db.connection;

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Ingredient ing = new Ingredient();
                ing.setIngredientId(rs.getInt("ingredient_id"));
                ing.setName(rs.getString("name"));
                ing.setDescription(rs.getString("description"));
                ing.setUnit(rs.getString("unit"));
                ing.setQuantity(rs.getDouble("quantity")); // tồn kho hiện tại
                list.add(ing);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
