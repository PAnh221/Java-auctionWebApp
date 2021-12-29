package com.ute.auctionwebapp.beans;

public class Ban {
    private int BidderBannedID, ProductID, BanID;
    public Ban(){
    }

    public Ban(int bidderBannedID, int productID){
        BidderBannedID = bidderBannedID;
        ProductID = productID;
    }

    public int getProductID(){return ProductID;}

    public int getBidderBannedID(){return BidderBannedID;}

    public void setProductID(int productID){ProductID = productID;}

    public void setBidderBannedID(int bidderBannedID){BidderBannedID = bidderBannedID;}
}
