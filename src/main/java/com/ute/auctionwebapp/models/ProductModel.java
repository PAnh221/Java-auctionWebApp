package com.ute.auctionwebapp.models;

import com.ute.auctionwebapp.beans.Product;
import com.ute.auctionwebapp.Utils.DbUtils;
import org.sql2o.Connection;

import java.util.List;

public class ProductModel {
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

//  public static void add(Product p) {
//    String insertSql = "INSERT INTO products (ProName, TinyDes, FullDes, Price, CatID, Quantity) VALUES (:proname,:tinydes,:fulldes,:price,:catid,:quantity)";
//    try (Connection con = DbUtils.getConnection()) {
//      con.createQuery(insertSql)
//        .addParameter("proname", p.getProName())
//        .addParameter("tinydes", p.getTinyDes())
//        .addParameter("fulldes", p.getFullDes())
//        .addParameter("price", p.getPrice())
//        .addParameter("catid", p.getCatID())
//        .addParameter("quantity", p.getQuantity())
//        .executeUpdate();
//    }
//  }

//  public static void update(Product p) {
//    String sql = "UPDATE product SET  ProName = :ProName, TinyDes = :TinyDes, FullDes = :FullDes, Price = :Price, CatID = :CatID, Quantity = :quantity WHERE ProID = :proid";
//    try (Connection con = DbUtils.getConnection()) {
//      con.createQuery(sql)
//        .addParameter("proname", p.getProName())
//        .addParameter("tinydes", p.getTinyDes())
//        .addParameter("fulldes", p.getFullDes())
//        .addParameter("price", p.getBin())
//        .addParameter("catid", p.getSubCatID())
//        .addParameter("proid", p.getProID())
//        .executeUpdate();
//    }
//  }

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