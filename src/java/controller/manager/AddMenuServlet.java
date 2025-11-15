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
            String foodName = request.getParameter("foodName").trim();
            String description = request.getParameter("description").trim();
            String priceStr = request.getParameter("price");
            String size = request.getParameter("size");
            String status = request.getParameter("status");

            double price = 0.0;
            if (priceStr != null && !priceStr.trim().isEmpty()) {
                try {
                    price = Double.parseDouble(priceStr.trim());
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            int categoryId = 0;
            String categoryIdStr = request.getParameter("category_id");
            if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
                try {
                    categoryId = Integer.parseInt(categoryIdStr.trim());
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }

            String errorMsg = null;
            if (foodName == null || foodName.isEmpty()) {
                errorMsg = "Vui lòng nhập tên món ăn.";
            } else if (foodName.length() < 2 || foodName.length() > 100) {
                errorMsg = "Tên món ăn phải có độ dài từ 2 đến 100 ký tự.";
            }

            if (MenuDAO.isFoodNameExist(foodName)) {
                errorMsg = "Tên món ăn đã tồn tại. Vui lòng nhập tên khác.";
            }

            if (description == null || description.isEmpty()) {
                errorMsg = "Vui lòng nhập mô tả cho món ăn.";
            } else if (description.length() < 2 || description.length() > 250) {
                errorMsg = "Mô tả món ăn phải có độ dài từ 2 đến 250 ký tự.";
            }

            String imageUrl = saveImage(request);
            if (imageUrl == null || imageUrl.isEmpty()) {
                imageUrl = request.getParameter("oldImageUrl"); 
            }

            if (errorMsg != null) {
                CategoryDAO categoryDAO = new CategoryDAO();
                List<Category> categories = categoryDAO.getAllCategoryName(); // Lấy lại danh mục
                request.setAttribute("categories", categories);

                request.setAttribute("errorMsg", errorMsg);
                request.setAttribute("oldName", foodName);
                request.setAttribute("oldDes", description);
                request.setAttribute("oldPrice", priceStr);
                request.setAttribute("oldSize", size);
                request.setAttribute("oldStatus", status);
                request.setAttribute("categoryId", categoryId);
                request.setAttribute("oldImageUrl", imageUrl);

                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/View/manager/AddMenu.jsp");
                dispatcher.forward(request, response);
                return;
            }

            try {
                // Cập nhật món ăn mới vào cơ sở dữ liệu
                MenuDAO.addFoodForMenu(foodName, description, price, imageUrl, status, size, categoryId);
                // Lưu thông báo vào session nếu thành công
                session.setAttribute("message", "Thêm món ăn thành công.");
                session.setAttribute("messageType", "success"); // Thông báo thành công
            } catch (Exception e) {
                // Lưu thông báo lỗi vào session nếu có exception
                session.setAttribute("message", "Thêm món ăn thất bại. Vui lòng thử lại.");
                session.setAttribute("messageType", "error"); // Thông báo thất bại
            }
            response.sendRedirect(request.getContextPath() + "/manager/ListMenuServlet");
        }
    }

    private String saveImage(HttpServletRequest request) throws IOException, ServletException {
        Part filePart = request.getPart("imageUrl");
        String imageUrl = null;

        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("") + File.separator + "images" + File.separator + fileName;

            File file = new File(uploadPath);
            if (!file.getParentFile().exists()) {
                file.getParentFile().mkdirs();
            }

            filePart.write(uploadPath);
            imageUrl = "images/" + fileName;
        }
        return imageUrl;
    }

}
