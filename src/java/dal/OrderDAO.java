/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import model.Invoice;
import model.Order;
import java.sql.ResultSet;

/**
 *
 * @author cungp
 */
public class OrderDAO {

    public static int createOrder(Order order) {
        DBContext dbc = DBContext.getInstance();
        int newOrderId = 0;
        String sql = """
        INSERT INTO [dbo].[Orders] (invoice_id, waiter_id, table_id, price, note) 
        OUTPUT INSERTED.order_id 
        VALUES (?, ?, ?, ?, ?)              
        """;
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setInt(1, order.getInvoiceId());
            statement.setInt(2, order.getWaiterId());
            statement.setInt(3, order.getTableId());
            statement.setBigDecimal(4, order.getPrice());
            statement.setString(5, order.getNote());
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                newOrderId = rs.getInt("order_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
        return newOrderId == 0 ? 0 : newOrderId;
    }

    public static Order updateOrder(Order order) {
        DBContext dbc = DBContext.getInstance();
        int rs = 0;
        String sql = """
        UPDATE [dbo].[Orders] 
        SET invoice_id = ?, waiter_id = ?, chef_id = ?, table_id = ?, status = ?, price = ?, note = ? 
        WHERE order_id = ?
    """;
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setInt(1, order.getInvoiceId());
            statement.setInt(2, order.getWaiterId());
            statement.setInt(3, order.getChefId());
            statement.setInt(4, order.getTableId());
            statement.setString(5, order.getStatus());
            statement.setBigDecimal(6, order.getPrice());
            statement.setString(7, order.getNote());
            rs = statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return rs == 0 ? null : order;
    }
    
    public static Order updateOrderPrice(Order order) {
        DBContext dbc = DBContext.getInstance();
        int rs = 0;
        String sql = """
        UPDATE [dbo].[Orders] 
        SET price = ?
        WHERE order_id = ?
    """;
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setBigDecimal(1, order.getPrice());
            statement.setInt(2, order.getOrderId());
            rs = statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return rs == 0 ? null : order;
    }
}
