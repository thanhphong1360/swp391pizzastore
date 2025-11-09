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
import model.Menu;

/**
 *
 * @author Dystopia
 */
@WebServlet(name="EditMenuServlet", urlPatterns={"/manager/EditMenuServlet"})
@MultipartConfig

public class EditMenuServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet EditMenuServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditMenuServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session.getAttribute("user") != null)
        {      
            int foodId = Integer.parseInt(request.getParameter("foodId"));
            Menu menu = MenuDAO.getFoodById(foodId);
            CategoryDAO cateDAO = new CategoryDAO();
            List<Category> cateList = cateDAO.getAllCategoryName();
            
            request.setAttribute("menu", menu);
            request.setAttribute("categories", cateList);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/View/manager/EditMenu.jsp");
            dispatcher.forward(request, response);
        }
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session.getAttribute("user") != null)
        {      
         
            int foodId = Integer.parseInt(request.getParameter("foodId"));
            String foodName = request.getParameter("foodName");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            String status = request.getParameter("status");
            String size = request.getParameter("size");
            int categoryId = Integer.parseInt(request.getParameter("category_id"));

            String imageUrl = null;
            Part filePart = request.getPart("imageUrl");
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
            MenuDAO.updateFoodForMenu(foodId, foodName, description, price, imageUrl, status, size, categoryId);
            response.sendRedirect(request.getContextPath() + "/manager/ListMenuServlet");
        
        }
    }
}
