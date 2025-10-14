package dal;

import java.sql.*;
import java.util.*;
import model.Ingredient;

public class IngredientDAO {
    private Connection conn;

    public IngredientDAO() {
        this.conn = DBContext.getInstance().getConnection();
    }

    public List<Ingredient> getAll() {
        List<Ingredient> list = new ArrayList<>();
        String sql = "SELECT * FROM Ingredients ORDER BY ingredient_id DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Ingredient(
                    rs.getInt("ingredient_id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getString("unit"),
                    rs.getDouble("quantity"),
                    rs.getTimestamp("updated_at")
                ));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

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
                    rs.getTimestamp("updated_at")
                );
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public boolean insert(Ingredient ing) {
        String sql = "INSERT INTO Ingredients(name, description, unit, quantity) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, ing.getName());
            ps.setString(2, ing.getDescription());
            ps.setString(3, ing.getUnit());
            ps.setDouble(4, ing.getQuantity());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean update(Ingredient ing) {
        String sql = "UPDATE Ingredients SET name=?, description=?, unit=?, quantity=?, updated_at=GETDATE() WHERE ingredient_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, ing.getName());
            ps.setString(2, ing.getDescription());
            ps.setString(3, ing.getUnit());
            ps.setDouble(4, ing.getQuantity());
            ps.setInt(5, ing.getIngredientId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM Ingredients WHERE ingredient_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }
}
