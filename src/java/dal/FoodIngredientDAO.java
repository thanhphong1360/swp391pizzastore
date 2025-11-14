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
import model.FoodIngredient;

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

        try {
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

    public static Ingredient getIngredientById(int ingredientId) {
        Ingredient ingredient = null;
        String sql = "SELECT * FROM Ingredients WHERE ingredient_id = ?";

        try {
            DBContext db = DBContext.getInstance();
            Connection conn = db.connection;
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, ingredientId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                ingredient = new Ingredient();
                ingredient.setIngredientId(rs.getInt("ingredient_id"));
                ingredient.setName(rs.getString("name"));
                ingredient.setDescription(rs.getString("description"));
                ingredient.setUnit(rs.getString("unit"));
                ingredient.setQuantity(rs.getDouble("quantity"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ingredient;
    }

    public static Ingredient getIngredientByFoodIdAndIngredientId(int foodId, int ingredientId) {
        Ingredient ingredient = null;
        String sql = "SELECT fi.quantity, i.name, i.unit FROM FoodIngredients fi "
                + "JOIN Ingredients i ON fi.ingredient_id = i.ingredient_id "
                + "WHERE fi.food_id = ? AND fi.ingredient_id = ?";
        try {
            DBContext db = DBContext.getInstance();
            Connection conn = db.connection;
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, foodId);  // Gán foodId vào câu lệnh SQL
            ps.setInt(2, ingredientId);  // Gán ingredientId vào câu lệnh SQL

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                ingredient = new Ingredient();
                ingredient.setIngredientId(ingredientId);  // Lấy ingredientId
                ingredient.setName(rs.getString("name"));  // Lấy tên nguyên liệu
                ingredient.setUnit(rs.getString("unit"));  // Lấy đơn vị
                ingredient.setQuantity(rs.getDouble("quantity"));  // Lấy số lượng
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ingredient;
    }
    
    public static ArrayList<FoodIngredient> getFoodIngredientsByFoodId(int foodId) {
        ArrayList<FoodIngredient> list = new ArrayList<>();
        String sql = """
                     SELECT* FROM FoodIngredients WHERE food_id = ?
                     """;
        try {
            DBContext db = DBContext.getInstance();
            Connection conn = db.connection;
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, foodId);  // Gán foodId vào câu lệnh SQL

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                FoodIngredient foodIngredient = new FoodIngredient();
                foodIngredient.setFoodId(rs.getInt("food_id"));
                foodIngredient.setIngredientId(rs.getInt("ingredient_id"));
                foodIngredient.setQuantity(rs.getDouble("quantity"));
                
                list.add(foodIngredient);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public static boolean deleteIngredient(int foodId, int ingredientId) {
        String sql = "DELETE FROM FoodIngredients WHERE food_id = ? AND ingredient_id = ?";
        try {
            DBContext db = DBContext.getInstance();
            Connection conn = db.connection;
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, foodId);  
            ps.setInt(2, ingredientId);  
            
            int rowsAffected = ps.executeUpdate();
            
            return rowsAffected > 0; 
        } catch (Exception e) {
            e.printStackTrace();
            return false;  
        }
    }
    
    public static void main(String[] args) {
        ArrayList<FoodIngredient> list = getFoodIngredientsByFoodId(22);
        for(FoodIngredient fi : list){
            System.out.println("Ingredient: "+fi.getIngredientId());
        }
    }
}