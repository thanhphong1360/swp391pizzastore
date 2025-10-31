package model;

import java.util.Date;

public class User {
    private int userId;
    private int roleId;
    private String roleName; // 🆕 thêm nếu cần hiển thị tên role
    private String email;
    private String password;
    private String name;
    private Date createdAt;
    private boolean status; // 🆕 thêm trạng thái (true = active, false = inactive)

    public User() {}

    public User(int userId, int roleId, String email, String password, String name, Date createdAt) {
        this.userId = userId;
        this.roleId = roleId;
        this.email = email;
        this.password = password;
        this.name = name;
        this.createdAt = createdAt;
    }

    // ✅ Getter & Setter đầy đủ
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}
