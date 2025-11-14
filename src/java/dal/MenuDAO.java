/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Ingredient;
import model.Menu;

/**
 *
 * @author Dystopia
 */
public class MenuDAO {

    public static List<Menu> getAllFood() {
        List<Menu> MList = new ArrayList<>();
        String sql = "Select f.food_id, f.name as food_name, f.description, f.price, f.status, f.image_url, f.size, "
                + "c.category_id, c.name as category_name, c.description as category_description "
                + "from Foods f join Categories c on f.category_id = c.category_id";
        try {
            DBContext db = DBContext.getInstance();
            Connection conn = db.connection;

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Menu f = new Menu();
                f.setFoodId(rs.getInt("food_id"));
                f.setCategoryId(rs.getInt("category_id"));
                f.setFoodName(rs.getString("food_name"));
                f.setDescription(rs.getString("description"));
                f.setPrice(rs.getDouble("price"));
                f.setStatus(rs.getString("status"));
                f.setImgURL(rs.getString("image_url"));
                f.setSize(rs.getString("size"));
                f.setCategoryName(rs.getString("category_name"));
                f.setCategoryDescription(rs.getString("category_description"));

                List<Ingredient> ingredients = getIngredientsByFoodId(f.getFoodId());
                f.setIngredients(ingredients);
                MList.add(f);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return MList;
    }

    public static boolean addFoodForMenu(String foodName, String description, double price, String imageUrl,
            String status, String size, int categoryId) {
        String sql = "INSERT INTO Foods (name, description, price, image_url, status, size, category_id) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = null;
        try {
            DBContext db = DBContext.getInstance();
            Connection conn = db.connection; // dùng connection của DBContext; KHÔNG close conn ở đây
            ps = conn.prepareStatement(sql);
            ps.setString(1, foodName);
            ps.setString(2, description);
            ps.setDouble(3, price);
            ps.setString(4, imageUrl);
            ps.setString(5, status);
            ps.setString(6, size);
            ps.setInt(7, categoryId);
            int r = ps.executeUpdate();
            System.out.println("DEBUG MenuDAO.addFoodForMenu - inserted rows = " + r);
            return r > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    public static Menu getFoodById(int foodId) {
        Menu menu = null;
        String sql = "SELECT * FROM Foods WHERE food_id = ?";
        PreparedStatement ps = null;
        try {
            DBContext db = DBContext.getInstance();
            Connection conn = db.connection; // dùng connection của DBContext; KHÔNG close conn ở đây
            ps = conn.prepareStatement(sql);
            ps.setInt(1, foodId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                menu = new Menu();
                menu.setFoodId(rs.getInt("food_id"));
                menu.setFoodName(rs.getString("name"));
                menu.setDescription(rs.getString("description"));
                menu.setPrice(rs.getDouble("price"));
                menu.setImgURL(rs.getString("image_url"));
                menu.setStatus(rs.getString("status"));
                menu.setSize(rs.getString("size"));
                menu.setCategoryId(rs.getInt("category_id"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return menu;
    }

    public static void updateFoodForMenu(int foodId, String foodName, String description, double price,
            String imageUrl, String status, String size, int categoryId) {
        String sql = "UPDATE Foods SET name = ?, description = ?, price = ?, image_url = ?, status = ?, size = ?, category_id = ? "
                + "WHERE food_id = ?";
        PreparedStatement ps = null;
        try {
            DBContext db = DBContext.getInstance();
            Connection conn = db.connection; 
            ps = conn.prepareStatement(sql);
            ps.setString(1, foodName);
            ps.setString(2, description);
            ps.setDouble(3, price);
            ps.setString(4, imageUrl); // 
            ps.setString(5, status);
            ps.setString(6, size);
            ps.setInt(7, categoryId);
            ps.setInt(8, foodId); // 

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static List<Ingredient> getIngredientsByFoodId(int foodId) {
        List<Ingredient> ingredients = new ArrayList<>();
        String sql = "SELECT i.ingredient_id, i.name, fi.quantity, i.unit FROM FoodIngredients fi "
                + "JOIN Ingredients i ON fi.ingredient_id = i.ingredient_id "
                + "WHERE fi.food_id = ?";
        try {
            DBContext db = DBContext.getInstance();
            Connection conn = db.connection;
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, foodId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Ingredient ingredient = new Ingredient();
                ingredient.setIngredientId(rs.getInt("ingredient_id"));
                ingredient.setName(rs.getString("name"));
                ingredient.setQuantity(rs.getDouble("quantity"));
                ingredient.setUnit(rs.getString("unit"));

                ingredients.add(ingredient);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ingredients;
    }
}