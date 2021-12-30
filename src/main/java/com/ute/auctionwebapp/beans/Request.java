package com.ute.auctionwebapp.beans;

public class Request {
    private int IdRequest, IdBidder;

    public Request(int idRequest, int idBidder) {
        IdRequest = idRequest;
        IdBidder = idBidder;
    }

    public Request(int idBidder) {
        IdBidder = idBidder;
    }

    public Request() {}

    public int getIdBidder() {
        return IdBidder;
    }
}
