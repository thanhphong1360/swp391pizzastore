/*
     * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
     * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.User;
import java.util.Scanner;
import org.mindrot.jbcrypt.BCrypt;

public class UserDAO {

    private Connection conn;

    public UserDAO() {
        this.conn = DBContext.getInstance().getConnection();
    }

   public static User login(String email, String password) {
    String sql = "SELECT user_id, role_id, email, password, name, created_at "
               + "FROM Users WHERE email = ?";
    try {
        DBContext db = DBContext.getInstance();
        Connection conn = db.connection;
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            String hashed = rs.getString("password");

            // ✅ Kiểm tra password người dùng nhập có đúng với hash không
            if (BCrypt.checkpw(password, hashed)) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setRoleId(rs.getInt("role_id"));
                user.setEmail(rs.getString("email"));
                user.setPassword(hashed);
                user.setName(rs.getString("name"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                return user;
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}

    public boolean checkEmailExists(String email) {
        String sql = "SELECT user_id FROM Users WHERE email = ?";
        try {
            DBContext db = DBContext.getInstance();
            Connection conn = db.connection;
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean insertUser(User user) {
        String sql = "INSERT INTO Users(role_id, email, password, name) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, user.getRoleId());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getName());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

     public void updatePassword(String email, String newPassword) {
    String hashed = BCrypt.hashpw(newPassword, BCrypt.gensalt(12));
    String sql = "UPDATE Users SET password = ?, reset_token = NULL, token_expire = NULL WHERE email = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, hashed);
        ps.setString(2, email);
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

    public List<User> getAll() {
        List<User> list = new ArrayList<>();
        String sql = """
        SELECT u.user_id, u.role_id, r.role_name, u.email, u.password,
               u.name, u.created_at, u.status
        FROM Users u
        JOIN Roles r ON u.role_id = r.role_id
        ORDER BY u.user_id DESC
    """;

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setRoleId(rs.getInt("role_id"));
                u.setRoleName(rs.getString("role_name"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setName(rs.getString("name"));
                u.setCreatedAt(rs.getTimestamp("created_at"));
                u.setStatus(rs.getBoolean("status"));
                list.add(u);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateStatus(int id, boolean newStatus) {
        String sql = "UPDATE Users SET status = ? WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBoolean(1, newStatus);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ updateStatus failed: " + e.getMessage());
            return false;
        }
    }

    public User getById(int id) {
        String sql = """
        SELECT user_id, role_id, email, password, name, created_at, status
        FROM Users
        WHERE user_id = ?
    """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setRoleId(rs.getInt("role_id"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setName(rs.getString("name"));
                u.setCreatedAt(rs.getTimestamp("created_at"));
                u.setStatus(rs.getBoolean("status"));
                return u;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int insert(User u) {
        String sql = """
        INSERT INTO Users (role_id, email, password, name, created_at, status)
        OUTPUT INSERTED.user_id
        VALUES (?, ?, ?, ?, GETDATE(), 1)
    """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, u.getRoleId());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            ps.setString(4, u.getName());

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("❌ Insert user failed: " + e.getMessage());
        }
        return -1;
    }

    public boolean update(User u) {
        String sql = "UPDATE Users SET role_id=?, email=?, password=?, name=? WHERE user_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, u.getRoleId());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            ps.setString(4, u.getName());
            ps.setInt(5, u.getUserId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Update user failed: " + e.getMessage());
        }
        return false;
    }

    public boolean existsByEmail(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    //forgotpassword
      public boolean existsEmail(String email) {
        String sql = "SELECT * FROM Users WHERE email = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
     public void saveResetToken(String email, String token) {
        String sql = "UPDATE Users SET reset_token = ?, token_expire = DATEADD(MINUTE, 30, GETDATE()) WHERE email = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getEmailByToken(String token) {
        String sql = "SELECT email FROM Users WHERE reset_token = ? AND token_expire > GETDATE()";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("email");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

// ✅ Xóa token sau khi đổi mật khẩu thành công
public void clearResetToken(String email) {
    String sql = "UPDATE Users SET reset_token = NULL, token_expire = NULL WHERE email = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, email);
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("email: ");
        String email = scanner.nextLine();
        System.out.println("password: ");
        String password = scanner.nextLine();
        UserDAO userdao = new UserDAO();
        User user = userdao.login(email, password);
        System.out.println("email: " + user.getEmail() + " password: " + user.getPassword());

    }
    
    public static User getUserById(int id) {
        ArrayList<User> list = new ArrayList<>();
        DBContext dbc = DBContext.getInstance();
        String sql = "SELECT * FROM Users WHERE user_id = ?";
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                User user = new User(rs.getInt("user_id"),
                                    rs.getInt("role_id"),
                                    rs.getString("email"),
                                    rs.getString("password"),
                                    rs.getString("name"),
                                    rs.getTime("created_at"));
                list.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return list.isEmpty() ? null : list.get(0);
    }
}
