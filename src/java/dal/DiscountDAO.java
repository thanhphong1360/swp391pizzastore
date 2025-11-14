/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Discount;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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

    //lấy danh sách có phân trang
    public List<Discount> getAll(int page, int pageSize) {
        List<Discount> list = new ArrayList<>();
        String sql = """
        SELECT * FROM Discounts 
        ORDER BY discount_id ASC 
        OFFSET ? ROWS 
        FETCH NEXT ? ROWS ONLY
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToDiscount(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    //tìm kiếm
    public List<Discount> getBySearch(String keyword, int page, int pageSize) {
        List<Discount> list = new ArrayList<>();
        String sql = """
        SELECT * FROM Discounts 
        WHERE code LIKE ? OR description LIKE ? 
        ORDER BY discount_id ASC 
        OFFSET ? ROWS 
        FETCH NEXT ? ROWS ONLY
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String pattern = "%" + keyword + "%";
            ps.setString(1, pattern);
            ps.setString(2, pattern);
            ps.setInt(3, (page - 1) * pageSize);
            ps.setInt(4, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToDiscount(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    //đếm tổng số bản ghi
    public int getTotalCount() {
        String sql = "SELECT COUNT(*) FROM Discounts";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    //đếm số bản ghi dựa trên tìm kiếm
    public int getTotalCountBySearch(String keyword) {
        String sql = "SELECT COUNT(*) FROM Discounts WHERE code LIKE ? OR description LIKE ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String pattern = "%" + keyword + "%";
            ps.setString(1, pattern);
            ps.setString(2, pattern);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Tự động cập nhật các mã hết hạn
    public void updateExpiredDiscounts(java.sql.Date currentDate) {
        String sql = "UPDATE Discounts SET status = 0 WHERE status = 1 AND end_date < ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setDate(1, currentDate);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean insert(Discount d) {
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

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean update(Discount d) {
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

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

//    public boolean delete(int id) {
//        String sql = "DELETE FROM Discounts WHERE discount_id = ?";
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setInt(1, id);
//            int rows = ps.executeUpdate();
//            return rows > 0;
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false;
//        }
//    }
    public boolean checkIfCodeExists(String code) {
        if (code == null || code.trim().isEmpty()) {
            return false;
        }

        String sql = "SELECT COUNT(*) FROM Discounts WHERE TRIM(code) = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, code.trim());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Discount mapResultSetToDiscount(ResultSet rs) throws SQLException {
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

        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) {
            d.setCreatedAt(new Date(ts.getTime()));
        }

        return d;
    }
}
