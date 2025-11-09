package dal;

import model.RestaurantTable;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TableDAO extends DBContext {

    public List<RestaurantTable> getAllTables() {
        List<RestaurantTable> list = new ArrayList<>();
        String sql = "SELECT * FROM RestaurantTables";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new RestaurantTable(
                        rs.getInt("table_id"),
                        rs.getString("table_number"),
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

    public RestaurantTable getTableById(int id) {
        String sql = "SELECT * FROM RestaurantTables WHERE table_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new RestaurantTable(
                        rs.getInt("table_id"),
                        rs.getString("table_number"),
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

    public void addTable(RestaurantTable t) {
        String sql = "INSERT INTO RestaurantTables (table_number, capacity, status, location) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, t.getTableNumber());
            ps.setInt(2, t.getCapacity());
            ps.setString(3, t.getStatus());
            ps.setString(4, t.getLocation());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean updateTable(RestaurantTable t) {
        String sql = "UPDATE RestaurantTables SET table_number=?, capacity=?, status=?, location=? WHERE table_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, t.getTableNumber());
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
        String sql = "DELETE FROM RestaurantTables WHERE table_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
