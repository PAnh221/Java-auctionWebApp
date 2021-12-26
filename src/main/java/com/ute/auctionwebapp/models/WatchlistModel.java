package com.ute.auctionwebapp.models;
import com.ute.auctionwebapp.Utils.DbUtils;
import com.ute.auctionwebapp.beans.Category;
import com.ute.auctionwebapp.beans.Watchlist;
import org.sql2o.Connection;

import java.util.List;

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

    public static List<Watchlist> findAllbyUserID(int UserID) {
        final String query = "select * from watchlist where UserID = :UserID";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(query)
                    .addParameter("UserID", UserID)
                    .executeAndFetch(Watchlist.class);
        }
    }

}
