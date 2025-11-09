package dal;

import model.Payment;
import java.sql.*;

public class PaymentDAO extends DBContext {

    /**
     * INSERT – chỉ truyền 4 trường, payment_date do DB tự điền
     */
    public void insert(Payment p) throws SQLException {
        String sql = "INSERT INTO Payment (order_id, method, amount, status) VALUES (?, ?, ?, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, p.getOrderId());
            st.setString(2, p.getMethod());
            st.setBigDecimal(3, p.getAmount());
            st.setString(4, p.getStatus());
            st.executeUpdate();
        }
    }

    /**
     * Kiểm tra trùng order_id
     */
    public boolean existsByOrderId(int orderId) throws SQLException {
        String sql = "SELECT 1 FROM Payment WHERE order_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, orderId);
            try (ResultSet rs = st.executeQuery()) {
                return rs.next();
            }
        }
    }
}
