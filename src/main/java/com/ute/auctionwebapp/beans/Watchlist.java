package com.ute.auctionwebapp.beans;

public class Watchlist {
    int proID, userID;


    public Watchlist(int proID, int userID) {
        this.proID = proID;
        this.userID = userID;
    }

    public int getProID() {
        return proID;
    }

    public int getUserID() {
        return userID;
    }



    public Watchlist() {}


}
