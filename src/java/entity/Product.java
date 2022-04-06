/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.util.List;

/**
 *
 * @author Tran Trang
 */
public class Product {
    private int ID;
    private String name;
    private String describe;
    private String productInfo;
    private int CategoryID;
    private int quantity;
    private double price;
    private boolean status;
    private List<ImageProduct> image;
    private String createAt,updateAt;

    public Product() {
    } 

    public Product(int ID, String name, String describe, String productInfo, int CategoryID, int quantity, double price, boolean status, List<ImageProduct> image, String createAt, String updateAt) {
        this.ID = ID;
        this.name = name;
        this.describe = describe;
        this.productInfo = productInfo;
        this.CategoryID = CategoryID;
        this.quantity = quantity;
        this.price = price;
        this.status = status;
        this.image = image;
        this.createAt = createAt;
        this.updateAt = updateAt;
    }

    public String getCreateAt() {
        return createAt;
    }

    public void setCreateAt(String createAt) {
        this.createAt = createAt;
    }

    public String getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(String updateAt) {
        this.updateAt = updateAt;
    }
    
    public List<ImageProduct> getImage() {
        return image;
    }

    public void setImage(List<ImageProduct> image) {
        this.image = image;
    }
    
    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public String getProductInfo() {
        return productInfo;
    }

    public void setProductInfo(String productInfo) {
        this.productInfo = productInfo;
    }

    public int getCategoryID() {
        return CategoryID;
    }

    public void setCategoryID(int CategoryID) {
        this.CategoryID = CategoryID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    } 
}
