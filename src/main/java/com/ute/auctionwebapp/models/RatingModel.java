package com.ute.auctionwebapp.models;

import com.ute.auctionwebapp.Utils.DbUtils;
import com.ute.auctionwebapp.beans.*;
import org.sql2o.Connection;

import java.text.DecimalFormat;
import java.time.Period;
import java.util.List;

//Hàm check xem ratingID có được đánh giá rated ID hay không
public class RatingModel {
    public static Boolean checkIfCanRate(int ratingID, int ratedID, int productID){
        return true;
    }

    public static Boolean checkIfCanWatchDetail(int userID, int userDetail){
        List<Product> listAuctioning = ProductModel.findAuctioningBySellerID(userID);
        for (Product product : listAuctioning) {
            List<Bid> listBid = BidModel.getListBidByProductID(product.getProID());
            for (Bid bid : listBid) {
                if (bid.getBidderID() == userDetail)
                    return true;
            }
        }
        return false;
    }

    public static List<Rating> getListRatingByIdUser(int userID){
        final String query = "select * from Rating where IdRated = :userID";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(query)
                    .addParameter("userID", userID)
                    .executeAndFetch(Rating.class);
        }
    }

    public static float getReputationOfUserID(int userID){
        List<Rating> listRating = getListRatingByIdUser(userID);
        float sum = listRating.size();
        float postsitive = 0;
        if(sum>0) {
            for (Rating rating : listRating) {
                if (rating.getVote() == 1)
                    postsitive++;
            }
        } else return 100;
        DecimalFormat df = new DecimalFormat("#.##");
        Float reputation = Float.parseFloat(df.format(postsitive*100/sum));
        return reputation;
    }
}
