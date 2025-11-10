/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import com.sun.jdi.connect.spi.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.RestaurantTable;

import model.Table;

/**
 *
 * @author cungp
 */
public class TableDAO {
    
    public static ArrayList<Table> getAllTable() {
        ArrayList<Table> list = new ArrayList<>();
        DBContext dbc = DBContext.getInstance();
        String sql = "SELECT * FROM RestaurantTables";
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Table table = new Table(rs.getInt("table_id"),
                                    rs.getString("table_number"),
                                        rs.getInt("capacity"),
                                        rs.getString("location"),
                                        rs.getString("status"));
                list.add(table);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return list.isEmpty() ? null : list;
    }
    
    public static Table getTableById(int tableId) {
        ArrayList<Table> list = new ArrayList<>();
        DBContext dbc = DBContext.getInstance();
        String sql = "SELECT * FROM RestaurantTables WHERE table_id = ?";
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setInt(1, tableId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Table table = new Table(rs.getInt("table_id"),
                                    rs.getString("table_number"),
                                        rs.getInt("capacity"),
                                        rs.getString("location"),
                                        rs.getString("status"));
                list.add(table);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return list.isEmpty() ? null : list.get(0);
    }
    
    
    public static Table updateTableStatus(Table table, String status) {
        DBContext dbc = DBContext.getInstance();
        int rs = 0;
        String sql = """
        UPDATE [dbo].[RestaurantTables]
        SET status = ? 
        WHERE table_id = ?
    """;
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setString(1, status);
            statement.setInt(2, table.getTableId());
            rs = statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return rs == 0 ? null : table;
    }

    public void addTable(RestaurantTable t) {
        DBContext dbc = DBContext.getInstance();
        String sql = "INSERT INTO RestaurantTables (table_number, capacity, status, location) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = dbc.getConnection().prepareStatement(sql)) {
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
        DBContext dbc = DBContext.getInstance();
        String sql = "UPDATE RestaurantTables SET table_number=?, capacity=?, status=?, location=? WHERE table_id=?";
        try (PreparedStatement ps = dbc.getConnection().prepareStatement(sql)) {
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
        DBContext dbc = DBContext.getInstance();
        String sql = "DELETE FROM RestaurantTables WHERE table_id=?";
        try (PreparedStatement ps = dbc.getConnection().prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
