package com.ute.auctionwebapp.models;
import com.ute.auctionwebapp.Utils.DbUtils;
import com.ute.auctionwebapp.beans.Watchlist;
import org.sql2o.Connection;

public class WatchlistModel {
    public static void add(Watchlist w) {
        String insertSql = "INSERT INTO watchlist (ProID, UserID) VALUES (:ProID,:UserID)";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(insertSql)
                    .addParameter("ProID", w.getProID())
                    .addParameter("UserID", w.getUserID())
                    .executeUpdate();
        }
    }
}
