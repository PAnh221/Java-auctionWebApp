package com.ute.auctionwebapp.models;

import com.ute.auctionwebapp.Utils.DbUtils;
import com.ute.auctionwebapp.beans.Product;
import org.sql2o.Connection;

import java.util.List;

public class ProductModelAdmin {
  public static List<Product> findAll() {
    final String query = "select * from product";
    try (Connection con = DbUtils.getConnection()) {
      return con.createQuery(query)
        .executeAndFetch(Product.class);
    }
  }

  public static List<Product> findByCatId(int CatID) {
    final String query = "select * from product where CatID = :CatID";
    try (Connection con = DbUtils.getConnection()) {
      return con.createQuery(query)
        .addParameter("CatID", CatID)
        .executeAndFetch(Product.class);
    }
  }

  public static List<Product> findBySubCatId(int SubCatID) {
    final String query = "select * from product where SubCatID = :SubCatID";
    try (Connection con = DbUtils.getConnection()) {
      return con.createQuery(query)
              .addParameter("SubCatID", SubCatID)
              .executeAndFetch(Product.class);
    }
  }

  public static Product findById(int ProID) {
    final String query = "select * from product where ProID = :ProID";
    try (Connection con = DbUtils.getConnection()) {
      List<Product> list = con.createQuery(query)
        .addParameter("ProID", ProID)
        .executeAndFetch(Product.class);
      if (list.size() == 0) {
        return null;
      }
      return list.get(0);
    }
  }

  public static void add(Product p) {
    String insertSql = "INSERT INTO product (ImgIndex, CatID, UploadDate, Bin, FullDes, TinyDes, SellerID, SubCatID, ProName, ProID) VALUES (:imgindex,:catid,:uploaddate,:bin,:fulldes,:tinydes,:sellerid,:subcatid,:proname,:proid)\n";
    try (Connection con = DbUtils.getConnection()) {
      con.createQuery(insertSql)
              .addParameter("imgindex", p.getImgIndex())
              .addParameter("catid", p.getCatID())
              .addParameter("uploaddate", p.getUploadDate())
              .addParameter("bin", p.getBin())
              .addParameter("fulldes", p.getFullDes())
              .addParameter("tinydes", p.getTinyDes())
              .addParameter("sellerid", p.getSellerID())
              .addParameter("subcatid", p.getSubCatID())
              .addParameter("proname", p.getProName())
              .addParameter("proid", p.getProID())
        .executeUpdate();
    }
  }

  public static void update(Product p) {
    String sql = "UPDATE product SET  ImgIndex = :imgindex, CatID = :catid, UploadDate = :uploaddate, Bin = :bin, FullDes = :fulldes, TinyDes = :tinydes, SellerID = :sellerid, SubCatID = :subcatid, ProName = :proname WHERE ProID = :proid \n";
    try (Connection con = DbUtils.getConnection()) {
      con.createQuery(sql)
              .addParameter("imgindex", p.getImgIndex())
              .addParameter("catid", p.getCatID())
              .addParameter("uploaddate", p.getUploadDate())
              .addParameter("bin", p.getBin())
              .addParameter("fulldes", p.getFullDes())
              .addParameter("tinydes", p.getTinyDes())
              .addParameter("sellerid", p.getSellerID())
              .addParameter("subcatid", p.getSubCatID())
              .addParameter("proname", p.getProName())
              .addParameter("proid", p.getProID())
        .executeUpdate();
    }
  }

  public static void delete(int id) {
    String sql = "delete from product where ProID = :ProID";
    try (Connection con = DbUtils.getConnection()) {
      con.createQuery(sql)
        .addParameter("ProID", id)
        .executeUpdate();
    }
  }

  //Top 5 select
  public static List<Product> Top5HighestPrice() {
    final String query = "select * from product order by Bin desc limit 5";
    try (Connection con = DbUtils.getConnection()) {
      return con.createQuery(query)
              .executeAndFetch(Product.class);
    }
  }
}