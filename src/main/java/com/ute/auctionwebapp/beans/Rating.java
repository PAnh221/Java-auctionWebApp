package com.ute.auctionwebapp.beans;

import com.ute.auctionwebapp.models.UserModel;

import java.time.LocalDateTime;

public class Rating {
    private int RateID,IdRated, IdRating, IdProduct, Vote;
    private String FeedBack;
    private LocalDateTime Time;

    String  RatingName;
    public Rating(){
    }

    public Rating(int idRated, int idRating, int idProduct, int vote, String feedBack, LocalDateTime time){
        IdRated = idRated;
        IdRating = idRating;
        IdProduct = idProduct;
        Vote = vote > 0 ? 1 : 0;
        FeedBack = feedBack;
        Time = time;
        RatingName = UserModel.findUsernameByID(idRating);
    }


    public int getRateID() {
        return RateID;
    }

    public void setRateID(int ratingID) {
        RateID = ratingID;
    }

    public int getIdRated() {
        return IdRated;
    }

    public void setIdBidder(int idRated) {
        IdRated = idRated;
    }

    public int getIdProduct() {
        return IdProduct;
    }

    public void setIdProduct(int idProduct) {IdProduct = idProduct;}

    public int getVote() {
        return Vote;
    }

    public void setVote(int vote) {
        Vote = vote;
    }

    public String getFeedBack() {
        return FeedBack;
    }

    public void setFeedBack(String feedBack) {
        FeedBack = feedBack;
    }

    public int getIdRating() {
        return IdRating;
    }

    public void setIdIdRating(int idRating) {
        IdRating = idRating;
    }

    public LocalDateTime getTime() {
        return Time;
    }

    public void setTime(LocalDateTime time) {
        Time = time;
    }

    public String getRatingName(){return RatingName;}

    public void setRatingName(String name){RatingName = name;}

}
