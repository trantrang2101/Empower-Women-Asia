/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.BlogDAO;
import DAO.CategoryDAO;
import entity.Blog;
import entity.Category;
import entity.Timeline;
import entity.User;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Tran Trang
 */
public class CategoryController extends HttpServlet {

    private static final String ERROR = "invalid.jsp";

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
        String url = ERROR;
        String error = "";
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        User loginUser = (User) session.getAttribute("LOGIN_USER");
        List<Timeline> timeline = (List<Timeline>) session.getAttribute("TIMELINE");
        if (timeline == null) {
            timeline = new ArrayList<>();
        }
        CategoryDAO dao = new CategoryDAO();
        try {
            if (action != null && action.equalsIgnoreCase("Close")) {
                session.setAttribute("CATEGORY_CHOOSE", null);
                String previous = request.getParameter("previous");
                if (previous == null) {
                    url = "admin.jsp";
                } else {
                    url = previous;
                }
            } else if (action != null && action.equalsIgnoreCase("update")) {
                Category cate = (Category) session.getAttribute("CATEGORY_CHOOSE");
                String name = request.getParameter("name");
                String describe = request.getParameter("describe");
                Category update = new Category(cate.getID(), name, describe, "", new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()));
                boolean check = dao.updateCategory(update);
                if (check) {
                    List<Category> list = (List<Category>) session.getAttribute("CATEGORY_LIST");
                    for (int i = 0; i < list.size(); i++) {
                        Category get = list.get(i);
                        if (get.getID() == cate.getID()) {
                            list.set(i, update);
                        }
                    }
                    session.setAttribute("CATEGORY_LIST", list);
                    session.setAttribute("CATEGORY_CHOOSE", update);
                    timeline.add(new Timeline(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()), "A Category has changed! Category #" + cate.getID() + " is changed!"));
                    url = "adminCategory.jsp";
                }

            } else if (action != null && action.equalsIgnoreCase("addCategory")) {
                List<Category> list = (List<Category>) session.getAttribute("CATEGORY_LIST");
                String name = request.getParameter("name");
                String describe = request.getParameter("describe");
                Category cate = new Category(-1, name, describe, new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()), "");
                int category = dao.insertCategory(cate);
                if (category > 0) {
                    cate.setID(category);
                    list.add(cate);
                    session.setAttribute("CATEGORY_LIST", list);
                    session.setAttribute("CATEGORY_CHOOSE", cate);
                    url = "adminCategory.jsp";
                    timeline.add(new Timeline(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()), "New Category has created! Category #" + cate.getID() + " is created!"));
                }

            } else if (action != null && action.equalsIgnoreCase("DeleteCategory")) {
                int category = Integer.parseInt(request.getParameter("categoryID"));
                boolean check = dao.deleteCategory(category);
                if (check) {
                    List<Category> list = (List<Category>) session.getAttribute("CATEGORY_LIST");
                    for (Category cate : list) {
                        if (cate.getID() == category) {
                            list.remove(cate);
                        }
                    }
                    session.setAttribute("CATEGORY_LIST", list);
                    Category cate = (Category) session.getAttribute("CATEGORY_CHOOSE");
                    if (cate.getID() == category) {
                        session.setAttribute("CATEGORY_CHOOSE", null);
                    }
                    url = "adminCategory.jsp";
                    timeline.add(new Timeline(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()), "New Category has deleted! Category #" + cate.getID() + " is deleted!"));
                }

            } else if (action != null && action.equalsIgnoreCase("GetCategory")) {
                int category = Integer.parseInt(request.getParameter("categoryID"));
                Category cate = dao.getCategory(category);
                session.setAttribute("CATEGORY_CHOOSE", cate);
                url = "adminCategory.jsp";
            } else {
                List<Category> list = dao.getListCategory();
                if (loginUser != null && loginUser.getRoleID().equalsIgnoreCase("AD")) {
                    String previous = (String) session.getAttribute("PREVIOUS");
                    url = previous == null ? "adminProduct.jsp" : "BlogController";
                    for (Category cate : list) {
                        timeline.add(new Timeline(cate.getCreateAt(), "New Category created! Category #" + cate.getID() + " is created!"));
                        if (cate.getUpdateAt() != null && !cate.getUpdateAt().isEmpty()) {
                            timeline.add(new Timeline(cate.getUpdateAt(), "A Category has changed! Category #" + cate.getID() + " is changed!"));
                        }
                    }
                } else {
                    BlogDAO blogDAO = new BlogDAO();
                    List<Blog> listB = blogDAO.getListBlog(0, 4, false, "");
                    for (Blog blog : listB) {
                        if (blog.getPublishedAt()!=null) {
                            blog.setPublishedAt(new SimpleDateFormat("dd MMM,yyyy").format(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").parse(blog.getPublishedAt())));
                        }
                    }
                    session.setAttribute("BLOG_LIST", listB);
                    url = "home.jsp";
                }
                session.setAttribute("CATEGORY_LIST", list);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            bubbleSort(timeline);
            session.setAttribute("TIMELINE", timeline);
            request.setAttribute("ERROR", error);
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    private void bubbleSort(List<Timeline> arr) {
        int n = arr.size();
        boolean check = false;
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                if (arr.get(j).getRecord() > arr.get(j + 1).getRecord()) {
                    swap(arr, j, j + 1);
                    check = true;
                }
            }
            if (check == false) {
                break;
            }
        }
    }

    private void swap(List<Timeline> arr, int i, int min_index) {
        Timeline temp = arr.get(min_index);
        arr.set(min_index, arr.get(i));
        arr.set(i, temp);
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
