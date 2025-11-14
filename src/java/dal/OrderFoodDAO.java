/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Order;
import model.OrderFood;

/**
 *
 * @author cungp
 */
public class OrderFoodDAO {

    public static OrderFood createOrderFood(OrderFood orderFood) {
        DBContext dbc = DBContext.getInstance();
        int rs = 0;
        String sql = """
        INSERT INTO [dbo].[OrderFoods] (order_id, food_id, quantity, price, note)
        VALUES (?, ?, ?, ?,?)
        """;
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setInt(1, orderFood.getOrderId());
            statement.setInt(2, orderFood.getFoodId());
            statement.setInt(3, orderFood.getQuantity());
            statement.setBigDecimal(4, orderFood.getPrice());
            statement.setString(5, orderFood.getNote());
            rs = statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return rs == 0 ? null : orderFood;
    }

    public static ArrayList<OrderFood> getOrderFoodsByOrderId(int id) {
        ArrayList<OrderFood> list = new ArrayList<>();
        DBContext dbc = DBContext.getInstance();
        String sql = "SELECT * FROM OrderFoods WHERE order_id = ?";
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                OrderFood orderFood = new OrderFood();
                orderFood.setOrderFoodId(rs.getInt("orderfood_id"));
                orderFood.setOrderId(rs.getInt("order_id"));
                orderFood.setFoodId(rs.getInt("food_id"));
                orderFood.setQuantity(rs.getInt("quantity"));
                orderFood.setStatus(rs.getString("status"));
                orderFood.setPrice(rs.getBigDecimal("price"));
                orderFood.setNote(rs.getString("note"));
                list.add(orderFood);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return list.isEmpty() ? null : list;
    }
    
    public static OrderFood getOrderFoodById(int id) {
        ArrayList<OrderFood> list = new ArrayList<>();
        DBContext dbc = DBContext.getInstance();
        String sql = "SELECT * FROM OrderFoods WHERE orderfood_id = ?";
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                OrderFood orderFood = new OrderFood();
                orderFood.setOrderFoodId(rs.getInt("orderfood_id"));
                orderFood.setOrderId(rs.getInt("order_id"));
                orderFood.setFoodId(rs.getInt("food_id"));
                orderFood.setQuantity(rs.getInt("quantity"));
                orderFood.setStatus(rs.getString("status"));
                orderFood.setPrice(rs.getBigDecimal("price"));
                orderFood.setNote(rs.getString("note"));
                list.add(orderFood);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return list.isEmpty() ? null : list.get(0);
    }
    
    public static ArrayList<OrderFood> getOrderFoodsByStatus(String status) {
        ArrayList<OrderFood> list = new ArrayList<>();
        DBContext dbc = DBContext.getInstance();
        String sql = "SELECT * FROM OrderFoods WHERE status = ?";
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setString(1, status);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                OrderFood orderFood = new OrderFood();
                orderFood.setOrderFoodId(rs.getInt("orderfood_id"));
                orderFood.setStatus(rs.getString("status"));
                orderFood.setOrderId(rs.getInt("order_id"));
                orderFood.setFoodId(rs.getInt("food_id"));
                orderFood.setQuantity(rs.getInt("quantity"));
                orderFood.setPrice(rs.getBigDecimal("price"));
                orderFood.setNote(rs.getString("note"));

                list.add(orderFood);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return list.isEmpty() ? null : list;
    }

    public static ArrayList<OrderFood> getOrderFoodsByOrderIdAndStatus(int orderId, String status) {
        ArrayList<OrderFood> list = new ArrayList<>();
        DBContext dbc = DBContext.getInstance();
        String sql = "SELECT * FROM OrderFoods WHERE order_id = ? AND status = ?";
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setInt(1, orderId);
            statement.setString(2, status);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                OrderFood orderFood = new OrderFood();
                orderFood.setOrderFoodId(rs.getInt("orderfood_id"));
                orderFood.setStatus(rs.getString("status"));
                orderFood.setOrderId(rs.getInt("order_id"));
                orderFood.setFoodId(rs.getInt("food_id"));
                orderFood.setQuantity(rs.getInt("quantity"));
                orderFood.setPrice(rs.getBigDecimal("price"));
                orderFood.setNote(rs.getString("note"));

                list.add(orderFood);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return list.isEmpty() ? null : list;
    }

    public static void deleteOrderFood(int orderFoodId) {
        DBContext dbc = DBContext.getInstance();
        int rs = 0;
        String sql = """
        DELETE FROM [dbo].[OrderFoods] WHERE orderfood_id = ?
        """;
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setInt(1, orderFoodId);
            rs = statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static OrderFood updateOrderFoodQuantity(OrderFood orderFood) {
        DBContext dbc = DBContext.getInstance();
        int rs = 0;
        String sql = """
        UPDATE [dbo].[OrderFoods]
        SET quantity = ?
        WHERE orderfood_id = ?
        """;
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setInt(1, orderFood.getQuantity());
            statement.setInt(2, orderFood.getOrderFoodId());
            rs = statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return rs == 0 ? null : orderFood;
    }
    
    public static void updateOrderFoodStatus(int orderFoodId, String status) {
        DBContext dbc = DBContext.getInstance();
        int rs = 0;
        String sql = """
        UPDATE [dbo].[OrderFoods]
        SET status = ?
        WHERE orderfood_id = ?
        """;
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setString(1, status);
            statement.setInt(2, orderFoodId);
            rs = statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        OrderFood orderFood = getOrderFoodById(9);
        System.out.println(orderFood.getFoodId());
    }
}
