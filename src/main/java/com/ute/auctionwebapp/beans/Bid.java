package com.ute.auctionwebapp.beans;
import java.time.LocalDateTime;

public class Bid {
    private int BidID, BidderID,ProductID;
    private LocalDateTime Time;
    private int MaxBid;
    private String UserName;
    private float ReputationOfBidder;

    public Bid(){
    }

    public Bid(int bidderID, int productID, LocalDateTime time, int maxBid){
        BidderID = bidderID;
        ProductID = productID;
        Time = time;
        MaxBid = maxBid;
    }

    public int getBidID(){return BidID;}

    public void setBidID(int bidID){BidID = bidID;}

    public int getBidderID(){return BidderID;}

    public void setBidderID(int bidderID){BidderID = bidderID;}

    public int getProductID(){return ProductID;}

    public void setProductID(int productID){ProductID = productID;}

    public LocalDateTime getTime(){return Time;}

    public void setTime(LocalDateTime time){Time = time;}

    public int getMaxBid(){return MaxBid;}

    public void setMaxBid(int maxBid){MaxBid = maxBid;}

    public String getUserName(){return UserName;}

    public void setUserName(String userName){UserName = userName;}

    public float getReputationOfBidder(){return ReputationOfBidder;}

    public void setReputationOfBidder(float reputationOfBidder){ReputationOfBidder = reputationOfBidder;}

}
