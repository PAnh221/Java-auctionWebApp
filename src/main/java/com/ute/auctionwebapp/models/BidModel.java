package com.ute.auctionwebapp.models;

import com.ute.auctionwebapp.beans.Product;
import com.ute.auctionwebapp.beans.Bid;
import com.ute.auctionwebapp.Utils.DbUtils;
import org.sql2o.Connection;

import java.util.List;

public class BidModel {

    public static void addBid(Bid bid){

    }

    public static int getCurrentPriceByID(int productID){
        Product product = ProductModelAdmin.findById(productID);
        List<Bid> listBid = getListBidByProductID(productID);
        if (listBid.size()<=1) return product.getStartPrice();
        else {
            Bid best = getBestBiddingByProductID(productID);
            Bid second = getSecondBestBiddingByProductID(productID);

            if (best.getMaxBid() - second.getMaxBid() >= product.getStepPrice()){
                return second.getMaxBid() + product.getStepPrice();
            }
            else{
                if (best.getTime().isAfter(second.getTime())){
                    return second.getMaxBid();
                }
                else{
                    return best.getMaxBid();
                }
            }
        }
    }

    public static int getCurrentBidderIDByID(int productID){
        Product product = ProductModelAdmin.findById(productID);
        List<Bid> listBid = getListBidByProductID(productID);
        if (listBid.size()<=1) return -1;
        else {
            Bid best = getBestBiddingByProductID(productID);
            Bid second = getSecondBestBiddingByProductID(productID);

            if (best.getMaxBid() - second.getMaxBid() >= product.getStepPrice()){
                return best.getBidderID();
            }
            else{
                if (best.getTime().isAfter(second.getTime())){
                    return second.getBidderID();
                }
                else{
                    return best.getBidderID();
                }
            }
        }
    }

    public static List<Bid> getListBidByProductID(int productID){
        final String query = "select * from bid where ProductID = :productID";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(query)
                    .addParameter("productID", productID)
                    .executeAndFetch(Bid.class);
        }
    }

    //tìm người ra gía cao nhất hiện tại cho ID sản phẩm nhập
    public static Bid getBestBiddingByProductID(int productID){
        final String query = "select * from bid where ProductID = :productID order by MaxBid DESC";
        try (Connection con = DbUtils.getConnection()) {
            List<Bid> list = con.createQuery(query)
                    .addParameter("productID", productID)
                    .executeAndFetch(Bid.class);
            if (list.size() == 0) {
                return null;
            }
            return list.get(0);
        }
    }

    //tìm người ra gía cao nhì hiện tại cho ID sản phẩm nhập
    public static Bid getSecondBestBiddingByProductID(int productID){
        final String query = "select * from bid where ProductID = :productID order by MaxBid DESC";
        try (Connection con = DbUtils.getConnection()) {
            List<Bid> list = con.createQuery(query)
                    .addParameter("productID", productID)
                    .executeAndFetch(Bid.class);
            if (list.size() <= 1) {
                return null;
            }
            return list.get(1);
        }
    }
}
