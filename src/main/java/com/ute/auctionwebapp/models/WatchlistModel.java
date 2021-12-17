package com.ute.auctionwebapp.models;
import com.ute.auctionwebapp.Utils.DbUtils;
import com.ute.auctionwebapp.beans.Watchlist;
import org.sql2o.Connection;

public class WatchlistModel {
    public static void add(Watchlist w) {
        String insertSql = "INSERT INTO watchlist (id_product, id_user) VALUES (:id_product,:id_user)";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(insertSql)
                    .addParameter("id_product", w.getId_product())
                    .addParameter("id_user", w.getId_user())
                    .executeUpdate();
        }
    }


}
