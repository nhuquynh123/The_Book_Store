package controllers;

import daos.BookDAO;
import dtos.BookDTO;
import dtos.DetailDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "AddtoCartController", urlPatterns = {"/AddtoCartController"})
public class AddtoCartController extends HttpServlet {
    private static final String HOME = "home.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = HOME;
        BookDAO dao = new BookDAO();
        int Bid = Integer.parseInt(request.getParameter("BID"));
        int quantity = 1;
        DetailDTO detailDTO = new DetailDTO();
        ArrayList<DetailDTO> list = null;
        boolean flag = true;
        try {
            BookDTO bookDTO = dao.getBookByBookID(Bid);
            detailDTO = new DetailDTO(0, bookDTO.getPrice(), quantity, 0, bookDTO);

            HttpSession session = request.getSession(false);
            list = (ArrayList<DetailDTO>) session.getAttribute("CART");
            if (list != null) {
                for (int i = 0; i < list.size(); i++) {
                    if (list.get(i).getBook().getBookID() == detailDTO.getBook().getBookID()) {
                        int CurQuantity = dao.getQuantityOfBook(Bid);
                        if (list.get(i).getQuantity() + 1 <= CurQuantity) {
                            detailDTO.setQuantity(list.get(i).getQuantity() + 1);
                            detailDTO.setPrice(detailDTO.getQuantity() * detailDTO.getBook().getPrice());
                            list.set(i, detailDTO);
                        } else {
                            request.setAttribute("OUT", "Sorry! Out Of Quantity");
                        }
                        flag = false;
                    }
                }
            } else if (list == null) {
                list = new ArrayList<>();
            }
            if (flag) {
                list.add(detailDTO);
            }
            session.setAttribute("CART", list);
            url = HOME;
        } catch (SQLException ex) {
            log("AddtoCartController + SQLException: " + ex.getMessage());
        } catch (Exception ex) {
            Logger.getLogger(AddtoCartController.class.getName()).log(Level.SEVERE, null, ex);
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
