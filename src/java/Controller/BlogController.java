/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.BlogDAO;
import entity.Blog;
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
public class BlogController extends HttpServlet {

    private String ERROR = "invalid.jsp";

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
        BlogDAO dao = new BlogDAO();
        List<Timeline> timeline = (List<Timeline>) session.getAttribute("TIMELINE");
        if (timeline == null) {
            timeline = new ArrayList<>();
        }
        try {
            String action = request.getParameter("action");
            int page = 1;
            int recordsPerPage = 8;
            User loginUser = (User) session.getAttribute("LOGIN_USER");
            while (true) {
                List<Blog> list = (List<Blog>) session.getAttribute("BLOG_LIST");
                String search = request.getParameter("search");
                if (action != null && action.equalsIgnoreCase("addBlog")) {
                    String title = request.getParameter("title");
                    String authorName = request.getParameter("author");
                    String summary = request.getParameter("summary");
                    String content = request.getParameter("content");
                    Blog blog = new Blog(0, loginUser.getUserID(), authorName, title, summary, content, "", false, new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()), "", "", false);
                    int blogID = dao.addBlog(blog);
                    if (blogID > 0) {
                        blog.setBlogID(blogID);
                        list.add(blog);
                        session.setAttribute("BLOG_LIST", list);
                        session.setAttribute("BLOG_CHOOSE", blog);
                        timeline.add(new Timeline(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()), "New Blog created! Blog #" + blogID + " is created!"));
                        url = "adminBlogs.jsp";
                    }
                    break;
                } else if (action != null && action.equalsIgnoreCase("Edit")) {
                    int blogID = Integer.parseInt(request.getParameter("blogID"));
                    String title = request.getParameter("title");
                    String authorName = request.getParameter("author");
                    String summary = request.getParameter("summary");
                    String content = request.getParameter("content");
                    String dayPublished = !request.getParameter("dayPublished").equals("")?new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(request.getParameter("dayPublished").replace("T", " "))):null;
                    Blog b = dao.getBlog(blogID);
                    Blog edit = new Blog(blogID, loginUser.getUserID(), authorName, title, summary, content, "", false, b.getCreatedAt(), new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()), dayPublished, false);
                    boolean check = dao.updateBlog(edit);
                    if (check) {
                        for (int i = 0; i < list.size(); i++) {
                            Blog get = list.get(i);
                            if (get.getBlogID() == blogID) {
                                list.set(i, edit);
                                break;
                            }
                        }
                        session.setAttribute("BLOG_LIST", list);
                        if (edit.getPublishedAt() != null) {
                            edit.setPublishedAt(edit.getPublishedAt().replace(" ", "T"));
                        }
                        session.setAttribute("BLOG_CHOOSE", edit);
                        timeline.add(new Timeline(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()), "A Blog updated! Blog #" + blogID + " is updated!"));
                        url = "adminBlogs.jsp";
                    }
                    break;
                } else if (action != null && action.equalsIgnoreCase("Close")) {
                    session.setAttribute("BLOG_CHOOSE", null);
                    action = "";
                } else if (action != null && action.equalsIgnoreCase("detail")) {
                    int blogID = Integer.parseInt(request.getParameter("blogID"));
                    Blog p = null;
                    if (loginUser != null && loginUser.getRoleID().equalsIgnoreCase("AD")) {
                        p = dao.getBlog(blogID);
                    } else {
                        list = dao.getListBlog(0, Integer.MAX_VALUE, true, "");
                        for (int i = 0; i < list.size(); i++) {
                            Blog get = list.get(i);
                            if (get.getBlogID() == blogID) {
                                if (i>1) {
                                    session.setAttribute("BLOG_PREVIOUS", list.get(i - 1).getBlogID());
                                }
                                if (i < list.size() - 1) {
                                    session.setAttribute("BLOG_NEXT", list.get(i + 1).getBlogID());
                                }
                                p = get;
                                break;
                            }
                        }
                    }
                    session.setAttribute("BLOG_CHOOSE", p);
                    if (loginUser != null && loginUser.getRoleID().equalsIgnoreCase("AD")) {
                        url = url.equals(ERROR) ? "adminBlogs.jsp" : url;
                    } else {
                        url = "blogDetail.jsp";
                    }
                    break;
                } else {
                    boolean admin = false;
                    if (request.getParameter("page") != null && !request.getParameter("page").isEmpty()) {
                        page = Integer.parseInt(request.getParameter("page"));
                    }
                    if (loginUser != null && loginUser.getRoleID().equalsIgnoreCase("AD")) {
                        String previous = (String) session.getAttribute("PREVIOUS");
                        url = previous == null ? "adminBlogs.jsp" : "OrderController";
                        admin = true;
                    } else {
                        url = "blogs.jsp";
                    }
                    int numBlog = dao.getNumberPages(admin, search);
                    list = dao.getListBlog((page - 1) * recordsPerPage, recordsPerPage, admin, search);
                    if (admin) {
                        for (Blog blog : list) {
                            timeline.add(new Timeline(blog.getCreatedAt(), "New Blog created! Blog #" + blog.getBlogID() + " is created!"));
                            blog.setCreatedAt(new SimpleDateFormat("dd MM,yyyy").format(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").parse(blog.getCreatedAt())));
                            if (blog.getUpdatedAt() != null && !blog.getUpdatedAt().isEmpty()) {
                                timeline.add(new Timeline(blog.getUpdatedAt(), "A Blog has changed! Blog #" + blog.getBlogID() + " is changed!"));
                            }
                            if (blog.getPublishedAt() != null && !blog.getPublishedAt().isEmpty()) {
                                Timeline published = new Timeline(blog.getPublishedAt(), "A Blog has published! Blog #" + blog.getBlogID() + " is published!");
                                if (published.getRecord() >= 0) {
                                    blog.setPublished(true);
                                    timeline.add(published);
                                }
                            }
                            blog.setReact(dao.getReact(loginUser.getUserID(), blog.getBlogID()));
                        }
                    } else {
                        for (Blog blog : list) {
                            if (blog.getPublishedAt() != null && !blog.getPublishedAt().isEmpty()) {
                                blog.setPublishedAt(new SimpleDateFormat("dd MMM,yyyy").format(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").parse(blog.getPublishedAt())));
                            }
                            if (loginUser != null) {
                                blog.setReact(dao.getReact(loginUser.getUserID(), blog.getBlogID()));
                            }
                        }
                    }
                    int noPages = (int) Math.ceil(numBlog * 1.0 / recordsPerPage);
                    session.setAttribute("BLOGS_PAGES", noPages);
                    session.setAttribute("THIS_PAGE", page);
                    session.setAttribute("BLOG_LIST", list);
                    session.setAttribute("BLOG_NUMBER", numBlog);
                    break;
                }
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
