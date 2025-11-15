/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dal.MenuDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Menu;

/**
 *
 * @author Dystopia
 */
@WebServlet(name = "ListMenuServlet", urlPatterns = {"/manager/ListMenuServlet"})
public class ListMenuServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RestaurentMenuManagerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RestaurentMenuManagerServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String message = (String) session.getAttribute("message");
        String messageType = (String) session.getAttribute("messageType");
        if (session.getAttribute("user") != null) {

            if (message != null) {
                request.setAttribute("message", message);
                request.setAttribute("messageType", messageType);

                // Xóa thông báo khỏi session sau khi đã hiển thị
                session.removeAttribute("message");
                session.removeAttribute("messageType");
            }

            //phân trang
            int currentPage = 1;
            int itemsPerPage = 5;

            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                } catch (NumberFormatException e) {
                    currentPage = 1;
                }
            }
            int offset = (currentPage - 1) * itemsPerPage;

            MenuDAO menuDAO = new MenuDAO();
//            List<Menu> menuList = MenuDAO.getAllFood();
            List<Menu> menuList = menuDAO.getMenuWithPagination(offset, itemsPerPage);
            int totalItems = menuDAO.getTotalMenuCount();
            int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);

            request.setAttribute("menuList", menuList);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/View/manager/ListMenu.jsp");
            dispatcher.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
