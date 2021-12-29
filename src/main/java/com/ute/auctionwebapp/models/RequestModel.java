package com.ute.auctionwebapp.models;

import com.ute.auctionwebapp.Utils.DbUtils;
import com.ute.auctionwebapp.beans.Category;
import com.ute.auctionwebapp.beans.Product;
import com.ute.auctionwebapp.beans.Request;
import org.sql2o.Connection;

import java.util.List;

public class RequestModel {
    public static void add(int BidderID) {
        if (RequestModel.checkExist(BidderID)) {
            String insertSql = "insert into request(IdRequest, IdBidder) VALUES (null, :BidderID)";
            try (Connection con = DbUtils.getConnection()) {
                con.createQuery(insertSql)
                        .addParameter("BidderID", BidderID)
                        .executeUpdate();
            }
        }
    }

    public static boolean checkExist(int BidderID) {
        String query = "select * from request where IdBidder = :BidderID";
        try (Connection con = DbUtils.getConnection()) {
            List<Request> list = con.createQuery(query)
                    .addParameter("BidderID", BidderID)
                    .executeAndFetch(Request.class);
            if (list.size() == 0) {
                return true;
            }
            return false;
        }
    }


}
