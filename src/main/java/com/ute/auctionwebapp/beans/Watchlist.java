package com.ute.auctionwebapp.beans;

public class Watchlist {
    int id_product, id_user;

    public Watchlist(int id_product, int id_user) {
        this.id_product = id_product;
        this.id_user = id_user;
    }

    public Watchlist() {}

    public int getId_product() {
        return id_product;
    }

    public int getId_user() {
        return id_user;
    }
}
