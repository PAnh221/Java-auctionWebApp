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

  //Vĩ sửa sau khi sửa database
  public static List<Product> findByCatId(int CatID) {
    //final String query = "select * from product where CatID = :CatID";
    final String query = "SELECT * FROM product WHERE product.SubCatID IN (SELECT SubCatID FROM subcategory WHERE subcategory.CatID = :CatID";
    try (Connection con = DbUtils.getConnection()) {
      return con.createQuery(query)
        .addParameter("CatID", CatID)
        .executeAndFetch(Product.class);
    }
  }

  //Vĩ sửa sau khi sửa database
  public static Product findByCat(int CatID) {
    //final String query = "select * from product where CatID = :CatID";
    final String query = "SELECT * FROM product WHERE product.SubCatID IN (SELECT SubCatID FROM subcategory WHERE subcategory.CatID = :CatID";
    try (Connection con = DbUtils.getConnection()) {
      List<Product> list = con.createQuery(query)
              .addParameter("CatID", CatID)
              .executeAndFetch(Product.class);
      if (list.size() == 0) {
        return null;
      }
      return list.get(0);
    }
  }

  public static Product checkCat(int CatID) {
    final String query = "select * from product where CatID = :CatID";
    try (Connection con = DbUtils.getConnection()) {
      List<Product> list = con.createQuery(query)
              .addParameter("CatID", CatID)
              .executeAndFetch(Product.class);
      if (list.size() == 0) {
        return null;
      }
      return list.get(0);
    }
  }

  public static Product findBySubCat(int SubCatID) {
    final String query = "select * from product where SubCatID = :SubCatID";
    try (Connection con = DbUtils.getConnection()) {
      List<Product> list = con.createQuery(query)
              .addParameter("SubCatID", SubCatID)
              .executeAndFetch(Product.class);
      if (list.size() == 0) {
        return null;
      }
      return list.get(0);
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

  //Vĩ sửa sau khi sửa database
  //public static void add(Product p) {
  //  String insertSql = "INSERT INTO product (ImgIndex, CatID, UploadDate, Bin, FullDes, TinyDes, SellerID, SubCatID, ProName, ProID) VALUES (:imgindex,:catid,:uploaddate,:bin,:fulldes,:tinydes,:sellerid,:subcatid,:proname,:proid)\n";
  //  try (Connection con = DbUtils.getConnection()) {
  //    con.createQuery(insertSql)
  //            .addParameter("imgindex", p.getImgIndex())
  //            .addParameter("catid", p.getCatID())
  //            .addParameter("uploaddate", p.getUploadDate())
  //            .addParameter("bin", p.getBin())
  //            .addParameter("fulldes", p.getFullDes())
  //            .addParameter("tinydes", p.getTinyDes())
  //            .addParameter("sellerid", p.getSellerID())
  //            .addParameter("subcatid", p.getSubCatID())
  //            .addParameter("proname", p.getProName())
  //            .addParameter("proid", p.getProID())
  //      .executeUpdate();
  //  }
  //}

  public static void add(Product p) {
    String insertSql = "INSERT INTO product (ImgIndex, UploadDate, EndDate, Bin, FullDes, TinyDes, SellerID, SubCatID, ProName, ProID, StartPrice, StepPrice, Status) VALUES (:imgindex,:uploaddate, :enddate, :bin,:fulldes,:tinydes,:sellerid,:subcatid,:proname,:proid,:startprice,:stepprice,:status)\n";
    try (Connection con = DbUtils.getConnection()) {
      con.createQuery(insertSql)
              .addParameter("imgindex", p.getImgIndex())
              .addParameter("uploaddate", p.getUploadDate())
              .addParameter("bin", p.getBin())
              .addParameter("fulldes", p.getFullDes())
              .addParameter("tinydes", p.getTinyDes())
              .addParameter("sellerid", p.getSellerID())
              .addParameter("subcatid", p.getSubCatID())
              .addParameter("proname", p.getProName())
              .addParameter("proid", p.getProID())

              //Vĩ thêm sau khi sửa database
              .addParameter("startprice", p.getStartPrice())
              .addParameter("stepprice", p.getStepPrice())
              .addParameter("enddate", p.getEndDate())
              .addParameter("status", p.getStatus())
              .executeUpdate();
    }
  }

  public static void update(Product p) {
    String sql = "UPDATE product SET  ImgIndex = :imgindex, CatID = :catid, UploadDate = :uploaddate, EndDate = :enddate, Bin = :bin, FullDes = :fulldes, TinyDes = :tinydes, SellerID = :sellerid, SubCatID = :subcatid, ProName = :proname, StartPrice = :startprice, StepPrice = :stepprice WHERE ProID = :proid \n";
    try (Connection con = DbUtils.getConnection()) {
      con.createQuery(sql)
              .addParameter("imgindex", p.getImgIndex())
              .addParameter("uploaddate", p.getUploadDate())
              .addParameter("bin", p.getBin())
              .addParameter("fulldes", p.getFullDes())
              .addParameter("tinydes", p.getTinyDes())
              .addParameter("sellerid", p.getSellerID())
              .addParameter("subcatid", p.getSubCatID())
              .addParameter("proname", p.getProName())
              .addParameter("proid", p.getProID())
              //.addParameter("catid", p.getCatID())

              //Vĩ thêm sau khi sửa database
              .addParameter("enddate", p.getUploadDate().plusDays(7))
              .addParameter("stepprice", p.getStepPrice())
              .addParameter("startprice", p.getStartPrice())

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