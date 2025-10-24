/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Discount;
import java.sql.*;
import java.util.*;

/**
 *
 * @author HP
 */
public class DiscountDAO extends DBContext {

    public List<Discount> getAll() {
        List<Discount> list = new ArrayList<>();
        String sql = "SELECT * FROM Discounts";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Discount d = new Discount();
                d.setDiscountId(rs.getInt("discount_id"));
                d.setCode(rs.getString("code"));
                d.setDescription(rs.getString("description"));
                d.setType(rs.getString("type"));
                d.setValue(rs.getDouble("value"));
                d.setStartDate(rs.getDate("start_date"));
                d.setEndDate(rs.getDate("end_date"));
                d.setMinInvoicePrice(rs.getDouble("min_invoice_price"));
                d.setMaxDiscountAmount(rs.getDouble("max_discount_amount"));
                d.setStatus(rs.getBoolean("status"));
                d.setCreatedAt(rs.getDate("created_at"));
                list.add(d);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Discount getDiscountById(int id) {
        String sql = "SELECT * FROM Discounts WHERE discount_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Discount d = new Discount();
                d.setDiscountId(rs.getInt("discount_id"));
                d.setCode(rs.getString("code"));
                d.setDescription(rs.getString("description"));
                d.setType(rs.getString("type"));
                d.setValue(rs.getDouble("value"));
                d.setStartDate(rs.getDate("start_date"));
                d.setEndDate(rs.getDate("end_date"));
                d.setMinInvoicePrice(rs.getDouble("min_invoice_price"));
                d.setMaxDiscountAmount(rs.getDouble("max_discount_amount"));
                d.setStatus(rs.getBoolean("status"));
                d.setCreatedAt(rs.getDate("created_at"));
                return d;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void insert(Discount d) {
        String sql = "INSERT INTO Discounts (code, description, type, value, start_date, "
                + "end_date, min_invoice_price, max_discount_amount, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, d.getCode());
            ps.setString(2, d.getDescription());
            ps.setString(3, d.getType());
            ps.setDouble(4, d.getValue());
            ps.setDate(5, new java.sql.Date(d.getStartDate().getTime()));
            ps.setDate(6, new java.sql.Date(d.getEndDate().getTime()));
            ps.setDouble(7, d.getMinInvoicePrice());
            ps.setDouble(8, d.getMaxDiscountAmount());
            ps.setBoolean(9, d.isStatus());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Discount d) {
        String sql = "UPDATE Discounts SET code=?, description=?, type=?, value=?, start_date=?, "
                + "end_date=?, min_invoice_price=?, max_discount_amount=?, status=? "
                + "WHERE discount_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, d.getCode());
            ps.setString(2, d.getDescription());
            ps.setString(3, d.getType());
            ps.setDouble(4, d.getValue());
            ps.setDate(5, new java.sql.Date(d.getStartDate().getTime()));
            ps.setDate(6, new java.sql.Date(d.getEndDate().getTime()));
            ps.setDouble(7, d.getMinInvoicePrice());
            ps.setDouble(8, d.getMaxDiscountAmount());
            ps.setBoolean(9, d.isStatus());
            ps.setInt(10, d.getDiscountId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String sql = "DELETE FROM Discounts WHERE discount_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean checkIfCodeExists(String code) {
        if (code == null || code.trim().isEmpty()) {
            return false;
        }

        String sql = "SELECT COUNT(*) FROM Discounts WHERE TRIM(code) = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, code.trim());
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
