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

  public static List<Product> findByCatId(int catID) {
    final String query = "select * from product where catID = :catID";
    try (Connection con = DbUtils.getConnection()) {
      return con.createQuery(query)
        .addParameter("catID", catID)
        .executeAndFetch(Product.class);
    }
  }

  public static List<Product> findBySubCatId(int subcatID) {
    final String query = "select * from product where subcatID = :subcatID";
    try (Connection con = DbUtils.getConnection()) {
      return con.createQuery(query)
              .addParameter("subcatID", subcatID)
              .executeAndFetch(Product.class);
    }
  }

  public static Product findById(int id) {
    final String query = "select * from product where proID = :ProID";
    try (Connection con = DbUtils.getConnection()) {
      List<Product> list = con.createQuery(query)
        .addParameter("ProID", id)
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

  public static void update(Product p) {
    String sql = "UPDATE product SET  ProName = :proname, TinyDes = :tinydes, FullDes = :fulldes, Price = :price, CatID = :catid, Quantity = :quantity WHERE ProID = :proid";
    try (Connection con = DbUtils.getConnection()) {
      con.createQuery(sql)
        .addParameter("proname", p.getProName())
        .addParameter("tinydes", p.getTinyDes())
        .addParameter("fulldes", p.getFullDes())
        .addParameter("price", p.getBin())
        .addParameter("catid", p.getSubcatID())
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
}