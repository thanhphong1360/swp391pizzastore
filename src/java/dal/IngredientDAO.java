package dal;

import java.sql.*;
import java.util.*;
import model.Ingredient;

public class IngredientDAO {

    private Connection conn;

    public IngredientDAO() {
        this.conn = DBContext.getInstance().getConnection();
    }

    // 🧾 Lấy tất cả nguyên liệu (chỉ lấy những cái đang active)
    public List<Ingredient> getAll() {
        List<Ingredient> list = new ArrayList<>();
        String sql = "SELECT * FROM Ingredients ORDER BY ingredient_id DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Ingredient ing = new Ingredient(
                        rs.getInt("ingredient_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("unit"),
                        rs.getDouble("quantity"),
                        rs.getTimestamp("updated_at"),
                        rs.getBoolean("status")
                );
                list.add(ing);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 🔍 Lấy nguyên liệu theo ID
    public Ingredient getById(int id) {
        String sql = "SELECT * FROM Ingredients WHERE ingredient_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Ingredient(
                        rs.getInt("ingredient_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("unit"),
                        rs.getDouble("quantity"),
                        rs.getTimestamp("updated_at"),
                        rs.getBoolean("status")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ➕ Thêm mới nguyên liệu
    public boolean insert(Ingredient ing) {
        String sql = "INSERT INTO Ingredients(name, description, unit, quantity, status, updated_at) "
                + "VALUES (?, ?, ?, ?, ?, GETDATE())";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, ing.getName());
            ps.setString(2, ing.getDescription());
            ps.setString(3, ing.getUnit());
            ps.setDouble(4, ing.getQuantity());
            ps.setBoolean(5, ing.isStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Insert ingredient failed: " + e.getMessage());
            return false;
        }
    }

    public boolean update(Ingredient ing) {
        String sql = "UPDATE Ingredients "
                + "SET name = ?, description = ?, unit = ?, quantity = ?, status = ?, updated_at = GETDATE() "
                + "WHERE ingredient_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, ing.getName());
            ps.setString(2, ing.getDescription());
            ps.setString(3, ing.getUnit());
            ps.setDouble(4, ing.getQuantity());
            ps.setBoolean(5, ing.isStatus());
            ps.setInt(6, ing.getIngredientId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Update ingredient failed: " + e.getMessage());
            return false;
        }
    }

    // 🔎 Kiểm tra trùng tên khi thêm mới (chỉ kiểm tra với status = 1)
    public boolean existsByName(String name) {
        String sql = "SELECT COUNT(*) FROM Ingredients WHERE name = ? AND status = 1";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name.trim());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("❌ existsByName failed: " + e.getMessage());
        }
        return false;
    }

    // 🔎 Kiểm tra trùng tên khi edit (ngoại trừ chính nó, và chỉ tính status = 1)
    public boolean existsByNameExceptId(String name, int id) {
        String sql = "SELECT COUNT(*) FROM Ingredients WHERE name = ? AND ingredient_id <> ? AND status = 1";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name.trim());
            ps.setInt(2, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("❌ existsByNameExceptId failed: " + e.getMessage());
        }
        return false;
    }

    public boolean updateStatus(int id, boolean newStatus) {
        String sql = "UPDATE Ingredients SET status = ?, updated_at = GETDATE() WHERE ingredient_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBoolean(1, newStatus);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateQuantity(int ingredientId, double newQuantity) {
        String sql = "UPDATE Ingredients SET quantity = ? WHERE ingredient_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, newQuantity);
            ps.setInt(2, ingredientId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Update quantity failed: " + e.getMessage());
            return false;
        }
    }

}
