package com.mdresort;

public class Room {
    private int roomID;
    private String roomType;
    private String roomStatus;
    private double roomPrice;
    private int staffID;

    public Room(int roomID, String roomType, String roomStatus, double roomPrice, int staffID) {
        this.roomID = roomID;
        this.roomType = roomType;
        this.roomStatus = roomStatus;
        this.roomPrice = roomPrice;
        this.staffID = staffID;
    }

    public int getRoomID() { return roomID; }
    public String getRoomType() { return roomType; }
    public String getRoomStatus() { return roomStatus; }
    public double getRoomPrice() { return roomPrice; }
    public int getStaffID() { return staffID; }
}
