/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
}
