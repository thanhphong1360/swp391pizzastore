/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
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
        INSERT INTO [dbo].[OrderFoods] (order_id, food_id, quantity, price)
        VALUES (?, ?, ?, ?)
        """;
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setInt(1, orderFood.getOrderId());
            statement.setInt(2, orderFood.getFoodId());
            statement.setInt(3, orderFood.getQuantity());
            statement.setBigDecimal(4, orderFood.getPrice());
            rs = statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return rs == 0 ? null : orderFood;
    }
}
