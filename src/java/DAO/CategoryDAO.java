/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import entity.Category;
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
public class CategoryDAO {
    
    public int insertCategory(Category cate) throws SQLException {
        int categoryID = -1;
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("insert into Categories (CategoryName,Description) VALUES (?,?)");
                stm.setString(1, cate.getName());
                stm.setString(2, cate.getDescribe());
                check = stm.executeUpdate() > 0;
                if (check) {
                    stm = conn.prepareStatement("select top 1 CategoryID from Categories order by CategoryID desc");
                    rs = stm.executeQuery();
                    while (rs.next()) {
                        categoryID = rs.getInt(1);
                    }
                }
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
        return categoryID;
    }

    public boolean updateCategory(Category cate) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("update Categories set CategoryName = ?,Description=?,updatedAt=getDate() where CategoryID = ?");
                stm.setString(1, cate.getName());
                stm.setString(2, cate.getDescribe());
                stm.setInt(3, cate.getID());
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

    public boolean deleteCategory(int categoryID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("delete from Categories WHERE categoryID = ? ");
                stm.setInt(1, categoryID);
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

    public List<Category> getListCategory() throws SQLException {
        List<Category> list = new ArrayList();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("select * from Categories");
                rs = stm.executeQuery();
                while (rs.next()) {
                    int ID = rs.getInt(1);
                    String name = rs.getString(2);
                    String describt = rs.getString(3);
                    String createAt = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString(4)));
                    String updatedAt = rs.getString(5);
                    if (updatedAt != null && !updatedAt.isEmpty()) {
                        updatedAt = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(updatedAt));
                    }
                    Category x = new Category(ID, name, describt,createAt, updatedAt);
                    list.add(x);
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

    public Category getCategory(int id) throws SQLException {
        Category cate = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareCall("SELECT * from Categories WHERE CategoryID = ?");
                stm.setInt(1, id);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String name = rs.getString(2);
                    String describt = rs.getString(3);
                    String createAt = new SimpleDateFormat("dd MMM,yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString(4)));
                    String updatedAt =rs.getString(5);
                    if (updatedAt!=null&&!updatedAt.isEmpty()) {
                        updatedAt = new SimpleDateFormat("dd MMM,yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(updatedAt));
                    }
                    cate = new Category(id, name, describt,createAt, updatedAt);
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
        return cate;
    }

}
