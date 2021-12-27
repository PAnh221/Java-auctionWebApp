package com.ute.auctionwebapp.models;
import com.ute.auctionwebapp.Utils.DbUtils;
import com.ute.auctionwebapp.beans.Category;
import com.ute.auctionwebapp.beans.Product;
import com.ute.auctionwebapp.beans.Watchlist;
import org.sql2o.Connection;

import java.util.List;

public class WatchlistModel {
    public static void add(Watchlist w) {
        List<Watchlist> watchlists = WatchlistModel.findbyUIDandPID(w.getUserID(), w.getProID());
        if (watchlists.size() > 0) return;

        String insertSql = "INSERT INTO watchlist (ProID, UserID) VALUES (:ProID,:UserID)";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(insertSql)
                    .addParameter("ProID", w.getProID())
                    .addParameter("UserID", w.getUserID())
                    .executeUpdate();
        }
    }

    public static void delete(Watchlist w) {
        String insertSql = "delete " +
                "from watchlist where ProID=:ProID and UserID=:UserID";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(insertSql)
                    .addParameter("ProID", w.getProID())
                    .addParameter("UserID", w.getUserID())
                    .executeUpdate();
        }
    }


    //Vĩ sửa sau khi sửa database
    public static List<Product> findAllbyUserID(int UserID) {
        final String query = "select product.ProID, ProName, SubCatID, SellerID, TinyDes, FullDes, Bin, UploadDate/*, CatID*/, ImgIndex " +
                "from watchlist, product " +
                "where watchlist.UserID = :UserID and watchlist.ProID = product.ProID";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(query)
                    .addParameter("UserID", UserID)
                    .executeAndFetch(Product.class);
        }
    }

    //check if data already exists
    public static List<Watchlist> findbyUIDandPID(int UserID, int ProID) {
        final String query = "select *" +
                "from watchlist " +
                "where UserID = :UserID and ProID = :ProID";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(query)
                    .addParameter("UserID", UserID)
                    .addParameter("ProID", ProID)
                    .executeAndFetch(Watchlist.class);
        }
    }

}
