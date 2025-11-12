package dal;

import java.sql.*;
import java.util.*;
import model.CategoryRevenue;
import model.RevenueByDate;
import model.TopFood;

public class DashboardDAO extends DBContext {

    // Tổng doanh thu hôm nay (chỉ offline)
    public double getTodayRevenue() {
        double total = 0;
        String sql = """
            SELECT SUM(final_price) FROM Invoices
            WHERE CAST(created_at AS DATE) = CAST(GETDATE() AS DATE)
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    // Tổng số hóa đơn (chỉ offline)
    public int getTotalInvoices() {
        int total = 0;
        String sql = """
            SELECT COUNT(*) FROM Invoices
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    // Tổng khách hàng (có giao dịch, chỉ offline)
    public int getTotalCustomers() {
        int total = 0;
        String sql = """
            SELECT COUNT(DISTINCT waiter_id) FROM Invoices
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    // Doanh thu theo ngày (lọc theo khoảng, chỉ offline)
    public List<RevenueByDate> getRevenueByDate(String fromDate, String toDate) {
        List<RevenueByDate> list = new ArrayList<>();
        String sql = """
            SELECT CAST(created_at AS DATE) AS date, SUM(final_price) AS total
            FROM Invoices
            WHERE CAST(created_at AS DATE) BETWEEN ? AND ?
            GROUP BY CAST(created_at AS DATE)
            ORDER BY date ASC
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, fromDate);
            ps.setString(2, toDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new RevenueByDate(rs.getString("date"), rs.getDouble("total")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Tổng số hóa đơn theo khoảng (chỉ offline)
    public int getTotalInvoicesInRange(String from, String to) {
        int total = 0;
        String sql = """
            SELECT COUNT(*) FROM Invoices
            WHERE CAST(created_at AS DATE) BETWEEN ? AND ?
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, from);
            ps.setString(2, to);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    // Tổng khách hàng theo khoảng (có giao dịch, chỉ offline)
    public int getTotalCustomersInRange(String from, String to) {
        int total = 0;
        String sql = """
            SELECT COUNT(DISTINCT waiter_id) FROM Invoices
            WHERE CAST(created_at AS DATE) BETWEEN ? AND ?
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, from);
            ps.setString(2, to);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    // Top món ăn bán chạy theo khoảng ngày (chỉ tính đơn đã thanh toán, chỉ offline)
    public List<TopFood> getTopFoods(String from, String to, int limit) {
        List<TopFood> list = new ArrayList<>();
        String sql = """
            SELECT TOP (?) f.name AS food_name, SUM(ofd.quantity) AS total_quantity
            FROM OrderFoods ofd
            JOIN Orders o ON ofd.order_id = o.order_id
            JOIN Invoices i ON o.invoice_id = i.invoice_id
            JOIN Foods f ON ofd.food_id = f.food_id
            WHERE CAST(o.created_at AS DATE) BETWEEN ? AND ?
            GROUP BY f.name
            ORDER BY total_quantity DESC
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ps.setString(2, from);
            ps.setString(3, to);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new TopFood(rs.getString("food_name"), rs.getInt("total_quantity")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Doanh thu theo loại món (chỉ tính đơn đã thanh toán, chỉ offline)
    public List<CategoryRevenue> getRevenueByCategory(String from, String to) {
        List<CategoryRevenue> list = new ArrayList<>();
        String sql = """
            SELECT c.name AS category_name, SUM(ofd.quantity * COALESCE(ofd.price, f.price)) AS total_revenue
            FROM OrderFoods ofd
            JOIN Orders o ON ofd.order_id = o.order_id
            JOIN Invoices i ON o.invoice_id = i.invoice_id
            JOIN Foods f ON ofd.food_id = f.food_id
            JOIN Categories c ON f.category_id = c.category_id
            WHERE CAST(o.created_at AS DATE) BETWEEN ? AND ?
            GROUP BY c.name
            ORDER BY total_revenue DESC
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, from);
            ps.setString(2, to);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new CategoryRevenue(rs.getString("category_name"), rs.getDouble("total_revenue")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // so sánh Onlive với Offline - Vì không có online, trả về Offline 100%
    public Map<String, Integer> getOrderChannelRatio(String from, String to) {
        Map<String, Integer> map = new HashMap<>();
        String sql = """
            SELECT COUNT(*) AS count FROM Invoices 
            WHERE CAST(created_at AS DATE) BETWEEN ? AND ?
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, from);
            ps.setString(2, to);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                map.put("Offline", rs.getInt("count"));
                map.put("Online", 0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

}