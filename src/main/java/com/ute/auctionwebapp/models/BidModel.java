package com.ute.auctionwebapp.models;

import com.ute.auctionwebapp.beans.Product;
import com.ute.auctionwebapp.beans.Bid;
import com.ute.auctionwebapp.Utils.DbUtils;
import org.sql2o.Connection;

import java.util.List;

public class BidModel {

    public static void deleteBid(int bidderID, int productID){
        if (!notExisted(productID, bidderID)){
            String sql = "delete from bid where ProductID = :productID and BidderID = :bidderID";
            try (Connection con = DbUtils.getConnection()) {
                con.createQuery(sql)
                        .addParameter("productID", productID)
                        .addParameter("bidderID", bidderID)
                        .executeUpdate();
            }
        }
    }

    public static void addBid(Bid bid){
        if (BanModel.isExisted(bid.getProductID(), bid.getBidderID())) return;
        String insertSql = "INSERT INTO bid (BidderID, ProductID, Time, MaxBid) VALUES (:bidderID,:productID,:time,:maxBid)\n";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(insertSql)
                    .addParameter("bidderID", bid.getBidderID())
                    .addParameter("productID", bid.getProductID())
                    .addParameter("time", bid.getTime())
                    .addParameter("maxBid", bid.getMaxBid())
                    .executeUpdate();
        }
    }

    public static void updateBid(Bid bid){
        String sql = "UPDATE bid SET Time = :time, MaxBid = :maxBid where ProductID = :productID and BidderID = :bidderID";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(sql)
                    .addParameter("bidderID", bid.getBidderID())
                    .addParameter("productID", bid.getProductID())
                    .addParameter("time", bid.getTime())
                    .addParameter("maxBid", bid.getMaxBid())
                    .executeUpdate();
        }
    }

    public static int getCurrentPriceByID(int productID){
        Product product = ProductModelAdmin.findById(productID);
        List<Bid> listBid = getListBidByProductID(productID);
        if (listBid.size()<=1) {
            if(listBid.size()==1 && listBid.get(0).getMaxBid()==product.getBin())
                return product.getBin();
            return product.getStartPrice();
        }
        else {
            Bid best = getBestBiddingByProductID(productID);
            Bid second = getSecondBestBiddingByProductID(productID);

            if (best.getMaxBid() - second.getMaxBid() >= product.getStepPrice()){
                if (product.getBin() > 0 && best.getMaxBid() == product.getBin())
                    return product.getBin();
                else
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

    public static String getCurrentBidderUsernameByID(int productID){
        Product product = ProductModelAdmin.findById(productID);
        List<Bid> listBid = getListBidByProductID(productID);
        if (listBid.size()==1) return UserModel.findById(listBid.get(0).getBidderID()).getUserName();
        else if (listBid.size()==0) return null;
        else{
            Bid best = getBestBiddingByProductID(productID);
            Bid second = getSecondBestBiddingByProductID(productID);

            if (best.getMaxBid() - second.getMaxBid() >= product.getStepPrice()){
                return UserModel.findById(best.getBidderID()).getUserName();
            }
            else{
                if (best.getTime().isAfter(second.getTime())){
                    return UserModel.findById(second.getBidderID()).getUserName();
                }
                else{
                    return UserModel.findById(best.getBidderID()).getUserName();
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

    public static Boolean notExisted(int productID, int bidderID){
        final String query = "select * from bid where ProductID = :productID and BidderID = :bidderID";
        try (Connection con = DbUtils.getConnection()) {
            List<Bid> list = con.createQuery(query)
                    .addParameter("productID", productID)
                    .addParameter("bidderID", bidderID)
                    .executeAndFetch(Bid.class);
            return list.size() == 0;
        }
    }

}
