/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import entity.Customer;
import entity.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author Tran Trang
 */
public class UserDAO {

    public boolean removeCustomer(String userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("delete from Users WHERE CustomerID = ? ");
                stm.setString(1, userID);
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

    public boolean updateUser(String userID, String roldID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(" UPDATE Users SET roleID = ?,updatedAt=getDate() WHERE userID = ? ");
                stm.setString(1, roldID);
                stm.setString(2, userID);
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

    public boolean changePassword(String userID, String password) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("UPDATE Users SET password = ?,updatedAt=getDate() WHERE userID = ? ");
                stm.setString(1, password);
                stm.setString(2, userID);
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

    public boolean deleteUser(String userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("UPDATE Users SET status = ?,updatedAt=getDate() WHERE userID = ? ");
                stm.setBoolean(1, false);
                stm.setString(2, userID);
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

    public boolean updateInfo(Customer c) throws SQLException, ClassNotFoundException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("UPDATE Customers set fullName = ?, gender= ? , [Address]= ? ,Region = ? , PostalCode = ? , Country = ? , Phone = ? WHERE CustomerID = ?");
                stm.setString(1, c.getFullName());
                stm.setBoolean(2, c.isGender());
                stm.setString(3, c.getAddress());
                stm.setString(4, c.getRegion());
                stm.setString(5, c.getPostalCode());
                stm.setString(6, c.getCountry());
                stm.setString(7, c.getPhone());
                stm.setString(8, c.getID());
                check = stm.executeUpdate() > 0;
                if (check) {
                    stm = conn.prepareStatement("UPDATE Users SET updatedAt=getDate() WHERE userID = ? ");
                    stm.setString(1, c.getID());
                    check = stm.executeUpdate() > 0;
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
        return check;
    }

    public boolean insertCustomer(String userID) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("INSERT INTO Customers (CustomerID, gender) VALUES(?,1)");
                stm.setString(1, userID);
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

    public boolean insertUser(User user) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("INSERT INTO Users (userID, roleID, password, status) VALUES(?,?,?,?)");
                stm.setString(1, user.getUserID());
                stm.setString(2, user.getRoleID());
                stm.setString(3, user.getPassword());
                stm.setBoolean(4, user.isStatus());
                check = stm.executeUpdate() > 0;
                if (check) {
                    check = insertCustomer(user.getUserID());
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
        return check;
    }

    public boolean checkDuplicate(String userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                String sql = "SELECT userID FROM Users WHERE userID = ? ";
                stm = conn.prepareStatement(sql);
                stm.setString(1, userID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    check = true;
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

    public Customer getCus(String userID) throws SQLException {
        Customer cus = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                String sql = "SELECT fullName,gender, image,address,region,postalCode,Country,Phone from Customers WHERE CustomerID = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, userID);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String fullName = rs.getString("fullName");
                    String address = rs.getString("address");
                    String region = rs.getString("region");
                    String image = rs.getString("image");
                    String postalCode = rs.getString("postalCode");
                    String Country = rs.getString("Country");
                    String Phone = rs.getString("Phone");
                    boolean gender = rs.getBoolean("gender");
                    cus = new Customer(userID, fullName, image, gender, address, region, postalCode, Country, Phone);
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
        return cus;
    }

    public boolean uploadImage(String image, String ID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("update Customers set Image=? where CustomerID = ?");
                stm.setString(1, image);
                stm.setString(2, ID);
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

    public List<User> getListUser() throws SQLException {
        List<User> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                String sql = "select * from Users";
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String userID = rs.getString(1);
                    String password = rs.getString(2);
                    String roleID = rs.getString(3);
                    boolean status = rs.getBoolean(4);
                    String createAt = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString(5)));
                    String updatedAt = rs.getString(6);
                    if (updatedAt != null && !updatedAt.isEmpty()) {
                        updatedAt = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(updatedAt));
                    }
                    list.add(new User(userID, password, roleID, status, createAt, updatedAt));
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

    public User login(String userID, String password) throws SQLException {
        User login = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                String sql = "select * from Users where userID = ? AND password = ? AND status = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, userID);
                stm.setString(2, password);
                stm.setBoolean(3, true);
                rs = stm.executeQuery();
                while (rs.next()) {
                    boolean status = rs.getBoolean(4);
                    String roleID = rs.getString(3);
                    login = new User(userID, password, roleID, status, "", "");
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
        return login;
    }
}
