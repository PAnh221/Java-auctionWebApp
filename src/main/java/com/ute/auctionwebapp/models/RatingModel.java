package com.ute.auctionwebapp.models;

import com.ute.auctionwebapp.Utils.DbUtils;
import com.ute.auctionwebapp.beans.*;
import org.sql2o.Connection;

import java.text.DecimalFormat;
import java.time.Period;
import java.util.List;
import java.util.Objects;

//Hàm check xem ratingID có được đánh giá rated ID hay không
public class RatingModel {
    public static Boolean checkIfCanRate(int ratingID, int ratedID, int productID){
        System.out.println("ratingUserID :"+ratingID);
        System.out.println("ratedUserID :"+ratedID);
        System.out.println("onProductID :"+productID);
        Product product = ProductModel.findById(productID);
        System.out.println(BidModel.getCurrentBidderUsernameByID(productID));
        if(isExisted(ratingID,ratedID,productID) || ratedID == 0 || ratingID == 0 || productID == 0|| product.getStatus()==0)
            return false;
        else{
            User rating = UserModel.findById(ratingID);
            User rated = UserModel.findById(ratedID);
            return (product.getSellerID() == ratedID && Objects.equals(BidModel.getCurrentBidderUsernameByID(productID), rating.getUserName())) || (product.getSellerID() == ratingID && Objects.equals(BidModel.getCurrentBidderUsernameByID(productID), rated.getUserName()));
        }
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

    public static Boolean isExisted(int ratingID, int ratedID, int productID){
        final String query = "select * from Rating where IdRated = :ratedID and IdRating = :ratingID and IdProduct = :productID";
        try (Connection con = DbUtils.getConnection()) {
            List<Rating> listRating = con.createQuery(query)
                                        .addParameter("ratingID", ratingID)
                                        .addParameter("ratedID", ratedID)
                                        .addParameter("productID", productID)
                                        .executeAndFetch(Rating.class);
            return listRating.size() != 0;
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

    public static void add(Rating rating) {
        String insertSql = "insert into rating (IdRated, IdRating, IdProduct, Vote, FeedBack, Time)\n" +
                "values (:IdRated, :IdRating, :IdProduct, :Vote, :FeedBack, :Time);";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(insertSql)
                    .addParameter("IdRated", rating.getIdRated())
                    .addParameter("IdRating", rating.getIdRating())
                    .addParameter("IdProduct", rating.getIdProduct())
                    .addParameter("Vote", rating.getVote())
                    .addParameter("FeedBack", rating.getFeedBack())
                    .addParameter("Time", rating.getTime())
                    .executeUpdate();
        }
    }
}
