/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author Tran Trang
 */
public class Timeline {

    private String time, action;
    private long record;

    public Timeline() {
    }

    public Timeline(String time, String action) {
        try {
            Date now = new Date();
            Date date = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").parse(time);
            long diff = now.getTime() - date.getTime();
            long second = diff / 1000;
            long minus = second / 60;
            long hour = minus / 60;
            long day = hour / 24;
            long month = day / 30;
            long year = month / 12;
            if (year >= 1) {
                this.time = year + " years";
            } else {
                if (month >= 1) {
                    this.time = month + " months";
                } else {
                    if (day >= 1) {
                        this.time = day + " days";
                    } else {
                        if (hour >= 1) {
                            this.time = hour + " hours";
                        } else {
                            if (minus >= 1) {
                                this.time = minus + " minus";
                            } else {
                                this.time = second + " seconds";
                            }
                        }
                    }
                }
            }
            this.action = action;
            this.record = second;

        } catch (ParseException ex) {
            ex.printStackTrace();
        }
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public long getRecord() {
        return record;
    }

}
