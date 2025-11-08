/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dal.CategoryDAO;
import dal.MenuDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.List;
import model.Category;

/**
 *
 * @author Dystopia
 */
@WebServlet(name = "AddMenuServlet", urlPatterns = {"/manager/AddMenuServlet"})
@MultipartConfig
public class AddMenuServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DeleteMenuServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteMenuServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session.getAttribute("user") != null) {
            CategoryDAO categoryDAO = new CategoryDAO();
            List<Category> categories = categoryDAO.getAllCategoryName();
            request.setAttribute("categories", categories);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/View/manager/AddMenu.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session.getAttribute("user") != null) {
            String foodName = request.getParameter("foodName");
            String description = request.getParameter("description");
            double price = 0.0;
            String priceStr = request.getParameter("price");

            if (priceStr != null && !priceStr.trim().isEmpty()) {
                try {
                    price = Double.parseDouble(priceStr.trim());
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            String status = request.getParameter("status");

            int categoryId = 0;
            String categoryIdStr = request.getParameter("category_id");
            if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
                try {
                    categoryId = Integer.parseInt(categoryIdStr.trim());
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }

            String size = request.getParameter("size");

            // Xử lý upload ảnh (nếu có)
            Part filePart = request.getPart("imageUrl");
            String imageUrl = null;
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uploadPath = getServletContext().getRealPath("") + File.separator + "images" + File.separator + fileName;
                File file = new File(uploadPath);

                // Kiểm tra nếu thư mục không tồn tại thì tạo nó
                if (!file.getParentFile().exists()) {
                    file.getParentFile().mkdirs();
                }

                filePart.write(uploadPath);  // Lưu ảnh vào thư mục images
                imageUrl = "images/" + fileName;  // Lưu đường dẫn ảnh vào cơ sở dữ liệu
            }

            // Lưu món ăn vào cơ sở dữ liệu
            MenuDAO.addFoodForMenu(foodName, description, price, imageUrl, status, size, categoryId);

            // Sau khi lưu món ăn xong, chuyển hướng đến trang danh sách món ăn
            
            response.sendRedirect(request.getContextPath() + "/manager/ListMenuServlet");
        }
    }
}
