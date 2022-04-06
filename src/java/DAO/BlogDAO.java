/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import entity.Blog;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Tran Trang
 */
public class BlogDAO {
    
    public boolean getReact(String userID, int postID) throws SQLException{
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("select * from ReactPost where userID=? AND blogID = ?");
                stm.setString(1, userID);
                stm.setInt(2, postID);
                check = stm.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }
    
    public boolean createReact(String userID, int postID) throws SQLException{
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("insert into ReactPost (userID,blogID) values (?,?)");
                stm.setString(1, userID);
                stm.setInt(2, postID);
                check = stm.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }
    
    public boolean deleteReact(String userID, int postID) throws SQLException{
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("delete from ReactPost where userID=? AND blogID = ?");
                stm.setString(1, userID);
                stm.setInt(2, postID);
                check = stm.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }
    
    public boolean uploadImage(String image, int ID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("update Blogs set Image=? where BlogID = ?");
                stm.setString(1, image);
                stm.setInt(2, ID);
                check = stm.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public int getNumberPages(boolean admin, String search) throws SQLException {
        int num = -1;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                if (admin) {
                    if (search != null && !search.isEmpty()) {
                        stm = conn.prepareStatement("select count(*) from Blogs WHERE Title LIKE ? OR Summary like ? OR Content like ? ");
                        stm.setString(1, "%" + search + "%");
                    } else {
                        stm = conn.prepareStatement("select count(*) from Blogs");
                    }
                } else {
                    if (search != null && !search.isEmpty()) {
                        stm = conn.prepareStatement("select count(*) from Blogs WHERE Title LIKE ? OR Summary like ? OR Content like ? ");
                        stm.setString(1, "%" + search + "%");
                    } else {
                        stm = conn.prepareStatement("select count(*) from Blogs");
                    }
                }
                rs = stm.executeQuery();
                while (rs.next()) {
                    num = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return num;
    }

    public List<Blog> getListBlog(int start, int record, boolean admin, String search) throws SQLException {
        List<Blog> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                if (admin) {
                    if (search != null && !search.isEmpty()) {
                        stm = conn.prepareStatement("select * from Blogs WHERE Title LIKE ? OR Summary like ? OR Content like ? ORDER BY CREATEDAT DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
                    } else {
                        stm = conn.prepareStatement("select * from Blogs ORDER BY CREATEDAT DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
                    }
                } else {
                    if (search != null && !search.isEmpty()) {
                        stm = conn.prepareStatement("select * from Blogs  where getDate()>publishedAt AND (Title LIKE ? OR Summary like ? OR Content like ?) ORDER BY  publishedAt DESC, CreatedAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
                    } else {
                        stm = conn.prepareStatement("select * from Blogs where getDate()>publishedAt ORDER BY  publishedAt DESC, CreatedAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
                    }
                }
                if (search != null && !search.isEmpty()) {
                    stm.setString(1, "%" + search + "%");
                    stm.setString(2, "%" + search + "%");
                    stm.setString(3, "%" + search + "%");
                    stm.setInt(4, start);
                    stm.setInt(5, record);
                } else {
                    stm.setInt(1, start);
                    stm.setInt(2, record);
                }
                rs = stm.executeQuery();
                while (rs.next()) {
                    String authorID = rs.getString(2);
                    String authorName = rs.getString(3);
                    String title = rs.getString(4);
                    String summary = rs.getString(5);
                    String content = rs.getString(6);
                    String image = rs.getString(7);
                    String createAt = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString(8)));
                    String updatedAt = rs.getString(9);
                    if (updatedAt != null && !updatedAt.isEmpty()) {
                        updatedAt = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(updatedAt));
                    }
                    String publishedAt = rs.getString(10);
                    if (publishedAt != null && !publishedAt.isEmpty()) {
                        publishedAt = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(publishedAt));
                    }
                    list.add(new Blog(rs.getInt(1), authorID, authorName, title, summary, content, image, false, createAt, updatedAt, publishedAt,false));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public boolean updateBlog(Blog blog) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("update Blogs set AuthorID=?,AuthorName=?,Title=?,Summary=?,Content=?,publishedAt= (select CONVERT(datetime,?)),updatedAt=getDate() where blogID = ?");
                stm.setString(1, blog.getAuthorID());
                stm.setString(2, blog.getAuthorName());
                stm.setString(3, blog.getTitle());
                stm.setString(4, blog.getSummary());
                stm.setString(5, blog.getContent());
                if (blog.getPublishedAt()!=null) {
                    stm.setString(6, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").parse(blog.getPublishedAt())));
                }else{
                    stm.setString(6, blog.getPublishedAt());
                }
                stm.setInt(7, blog.getBlogID());
                check = stm.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public int addBlog(Blog blog) throws SQLException {
        int check = 0;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("insert into Blogs (AuthorID,AuthorName,Title,Summary,Content) values (?,?,?,?,?)");
                stm.setString(1, blog.getAuthorID());
                stm.setString(2, blog.getAuthorName());
                stm.setString(3, blog.getTitle());
                stm.setString(4, blog.getSummary());
                stm.setString(5, blog.getContent());
                check = stm.executeUpdate();
                if (check > 0) {
                    stm = conn.prepareCall("SELECT top 1 blogID from Blogs order by blogID desc");
                    rs = stm.executeQuery();
                    if (rs.next()) {
                        check = rs.getInt(1);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public Blog getBlog(int id) throws SQLException {
        Blog p = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareCall("SELECT * from Blogs WHERE blogID = ?");
                stm.setInt(1, id);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String authorID = rs.getString(2);
                    String authorName = rs.getString(3);
                    String title = rs.getString(4);
                    String summary = rs.getString(5);
                    String content = rs.getString(6);
                    String image = rs.getString(7);
                    String createAt = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString(8)));
                    String updatedAt = rs.getString(9);
                    if (updatedAt != null && !updatedAt.isEmpty()) {
                        updatedAt = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(updatedAt));
                    }
                    String publishedAt = rs.getString(10);
                    if (publishedAt != null && !publishedAt.isEmpty()) {
                        publishedAt = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(publishedAt));
                    }
                    p = new Blog(id, authorID, authorName, title, summary, content, image, false, createAt, updatedAt, publishedAt,false);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return p;
    }

}
