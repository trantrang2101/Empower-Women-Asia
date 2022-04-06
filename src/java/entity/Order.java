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
public class Order {
    private int ID;
    private String customerID,fullName,orderDate,address,region,postalCode,country,phone,note;
    private boolean prepay,checkpay;
    private int done;
    private List<OrderDetail> list;
    private String updateAt;

    public Order() {
    }

    public Order(int ID, String customerID, String fullName, String orderDate, String address, String region, String postalCode, String country, String phone, String note, boolean prepay, boolean checkpay, int done, List<OrderDetail> list, String updateAt) {
        this.ID = ID;
        this.customerID = customerID;
        this.fullName = fullName;
        this.orderDate = orderDate;
        this.address = address;
        this.region = region;
        this.postalCode = postalCode;
        this.country = country;
        this.phone = phone;
        this.note = note;
        this.prepay = prepay;
        this.checkpay = checkpay;
        this.done = done;
        this.list = list;
        this.updateAt = updateAt;
    }

    public String getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(String updateAt) {
        this.updateAt = updateAt;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getCustomerID() {
        return customerID;
    }

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public boolean isPrepay() {
        return prepay;
    }

    public void setPrepay(boolean prepay) {
        this.prepay = prepay;
    }

    public boolean isCheckpay() {
        return checkpay;
    }

    public void setCheckpay(boolean checkpay) {
        this.checkpay = checkpay;
    }

    public int getDone() {
        return done;
    }

    public void setDone(int done) {
        this.done = done;
    }

    public List<OrderDetail> getList() {
        return list;
    }

    public void setList(List<OrderDetail> list) {
        this.list = list;
    }
    
}
