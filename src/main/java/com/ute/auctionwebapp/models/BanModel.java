package com.ute.auctionwebapp.models;

import com.ute.auctionwebapp.beans.Ban;
import com.ute.auctionwebapp.beans.Product;
import com.ute.auctionwebapp.beans.Bid;
import com.ute.auctionwebapp.Utils.DbUtils;
import com.ute.auctionwebapp.beans.User;
import org.sql2o.Connection;

import java.util.List;

public class BanModel {
    public static void addBan(Ban ban){
        final String query = "select * from ban where ProductID = :productID and BidderBannedID = :bidderID";
        try (Connection con = DbUtils.getConnection()) {
            List<Ban> exist = con.createQuery(query)
                    .addParameter("productID", ban.getProductID())
                    .addParameter("bidderID",ban.getBidderBannedID())
                    .executeAndFetch(Ban.class);
            if (exist.size()==0){
                final String insertSql = "INSERT INTO ban (BidderBannedID, ProductID) VALUES (:bidderID,:productID)\n";
                con.createQuery(insertSql)
                        .addParameter("bidderID", ban.getBidderBannedID())
                        .addParameter("productID", ban.getProductID())
                        .executeUpdate();
                BidModel.deleteBid(ban.getBidderBannedID(), ban.getProductID());
            }
        }
    }

    public static List<Ban> findAllBan(){
        final String query = "SELECT * FROM ban\n";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(query)
                    .executeAndFetch(Ban.class);
        }
    }

    public static List<Ban> findListBanByProductID(int productID){
        final String query = "SELECT * FROM ban WHERE ProductID = :productID\n";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(query)
                    .addParameter("productID", productID)
                    .executeAndFetch(Ban.class);
        }
    }

    public static Boolean isExisted(int productID, int bidderID){
        final String query = "select * from ban where ProductID = :productID and BidderBannedID = :bidderID";
        try (Connection con = DbUtils.getConnection()) {
            List<Ban> list = con.createQuery(query)
                    .addParameter("productID", productID)
                    .addParameter("bidderID", bidderID)
                    .executeAndFetch(Ban.class);
            return list.size() != 0;
        }
    }
}
