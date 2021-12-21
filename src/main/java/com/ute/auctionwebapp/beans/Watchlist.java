package com.ute.auctionwebapp.beans;

public class Watchlist {
    int ProID, UserID;

    public Watchlist(int proID, int userID) {
        ProID = proID;
        UserID = userID;
    }

    public int getProID() {
        return ProID;
    }

    public int getUserID() {
        return UserID;
    }

    public Watchlist() {}

}
