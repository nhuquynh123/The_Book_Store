package controllers;

import daos.BookDAO;
import dtos.BookDTO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "EditController", urlPatterns = {"/EditController"})
public class EditController extends HttpServlet {
    private static final String ERROR = "home.jsp";
    private static final String SUCCESS = "manageBook.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            BookDTO b = new BookDTO(Integer.parseInt(request.getParameter("id")),
                    request.getParameter("name"),
                    request.getParameter("image"),
                    Float.parseFloat(request.getParameter("price")),
                    Integer.parseInt(request.getParameter("quantity")),
                    request.getParameter("author"),
                    request.getParameter("currentdate"),
                    Boolean.parseBoolean(request.getParameter("status")),
                    Integer.parseInt(request.getParameter("category")));
            BookDAO dao = new BookDAO();
            if (dao.updateBook(b) > 0) {
                request.setAttribute("OK", "Update Success!");
                url = SUCCESS;
            }
        } catch (SQLException ex) {
            log("EditController + SQLException: " + ex.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
