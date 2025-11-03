package dal;

import model.Table;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TableDAO extends DBContext {

    public List<Table> getAllTables() {
        List<Table> list = new ArrayList<>();
        String sql = "SELECT * FROM Tables";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Table(
                        rs.getInt("table_id"),
                        rs.getString("table_name"),
                        rs.getInt("capacity"),
                        rs.getString("status"),
                        rs.getString("location")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Table getTableById(int id) {
        String sql = "SELECT * FROM Tables WHERE table_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Table(
                        rs.getInt("table_id"),
                        rs.getString("table_name"),
                        rs.getInt("capacity"),
                        rs.getString("status"),
                        rs.getString("location")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addTable(Table t) {
        String sql = "INSERT INTO Tables (table_name, capacity, status, location) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, t.getTableName());
            ps.setInt(2, t.getCapacity());
            ps.setString(3, t.getStatus());
            ps.setString(4, t.getLocation());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean updateTable(Table t) {
        String sql = "UPDATE Tables SET table_name=?, capacity=?, status=?, location=? WHERE table_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, t.getTableName());
            ps.setInt(2, t.getCapacity());
            ps.setString(3, t.getStatus());
            ps.setString(4, t.getLocation());
            ps.setInt(5, t.getTableId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public void deleteTable(int id) {
        String sql = "DELETE FROM Tables WHERE table_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
