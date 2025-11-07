package controller;

import dal.AuditLogDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.AuditLog;

@WebServlet("/auditlog")
public class AuditLogServlet extends HttpServlet {

    private AuditLogDAO dao = new AuditLogDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
       
        String search = req.getParameter("search");
        List<AuditLog> logs;

        if (search != null && !search.trim().isEmpty()) {
            logs = dao.searchByName(search.trim());
        } else {
            logs = dao.getAll();
        }

        req.setAttribute("logs", logs);
        req.setAttribute("search", search); // giữ lại input
        req.getRequestDispatcher("WEB-INF/View/admin/auditlog/list.jsp").forward(req, resp);
    
    }

    @Override
    public String getServletInfo() {
        return "Audit log viewer servlet";
    }
}
