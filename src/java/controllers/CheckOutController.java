package controllers;

import daos.BookDAO;
import dtos.DetailDTO;
import dtos.OrderDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "CheckOutController", urlPatterns = {"/CheckOutController"})
public class CheckOutController extends HttpServlet {

    private static final String ERROR = "cart.jsp";
    private static final String SUCCESS = "home.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        Date date = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String url = ERROR;
        int voucher = 0;

        BookDAO dao = new BookDAO();
        HttpSession session = request.getSession();
        ArrayList<DetailDTO> list = (ArrayList<DetailDTO>) session.getAttribute("CART");
        try {
            String check = request.getParameter("voucherID");
            if (!check.isEmpty()) {
                voucher = Integer.parseInt(check);
            }
            for (DetailDTO detailDTO1 : list) {
                int CurQuantity1 = dao.getQuantityOfBook(detailDTO1.getBook().getBookID());
                if (detailDTO1.getQuantity() > CurQuantity1) {
                    list = null;
                }
                request.setAttribute("OUT", "Sorry!!! The book ' "+ detailDTO1.getBook().getBookName()+ " ' is out of stock."); 
            }
            if (list != null) {
                float total = Float.parseFloat(request.getParameter("total"));
                int UserID = Integer.parseInt(request.getParameter("userID"));
                if (dao.insertOrder(new OrderDTO(0, format.format(date), total, UserID)) != -1) {
                    int OrderID = dao.getOrderID();
                    for (DetailDTO detailDTO : list) {
                        detailDTO.setOrderID(OrderID);
                        if (dao.insertDetail(detailDTO) != -1) {
                            int CurQuantity = dao.getQuantityOfBook(detailDTO.getBook().getBookID());
                            if (CurQuantity > 0) {
                                int BookID = detailDTO.getBook().getBookID();
                                int Quantity = CurQuantity - detailDTO.getQuantity();
                                int result = dao.updateQuantityOfBook(BookID, Quantity);
                            }
                        }
                    }
                    dao.deleteVoucher(voucher);
                    session.setAttribute("listb", dao.getListBook());
                    session.setAttribute("listc", dao.getListCategory());
                    session.setAttribute("VOU", dao.getAllDiscount());
                    session.setAttribute("CART", null);
                    session.removeAttribute("CART");
                    request.setAttribute("OK", "Thanks for Coming!");
                    url = SUCCESS;

                }

            }
        } catch (SQLException ex) {
            log("CheckOutController + SQLException: " + ex.getMessage());
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
