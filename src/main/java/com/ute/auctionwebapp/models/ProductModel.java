package com.ute.auctionwebapp.models;

import com.ute.auctionwebapp.beans.Product;
import com.ute.auctionwebapp.Utils.DbUtils;
import org.sql2o.Connection;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class ProductModel {
  public static List<Product> findAll() {
    final String query = "select * from product";
    try (Connection con = DbUtils.getConnection()) {
      return con.createQuery(query)
        .executeAndFetch(Product.class);
    }
  }

  //Vĩ sửa sau khi sửa database
  public static List<Product> findByCatId(int CatID) {
    final String query = "SELECT * FROM product WHERE product.SubCatID IN (SELECT SubCatID FROM subcategory WHERE subcategory.CatID = :CatID)";
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
  public  static  List<Product> fullTextSearch(String keyword){
    final String query = "select * from product where MATCH(ProName,TinyDes,FullDes) AGAINST(:keyword)";
    try (Connection con = DbUtils.getConnection()) {
      return con.createQuery(query)
              .addParameter("keyword", keyword)
              .executeAndFetch(Product.class);
    }
  }
  public static List<Product> findRelevantProductByProID(int ProID) {
    final String query = "select * from product where SubCatID = (select SubCatID from product where ProID = :ProID) and ProID != :ProID";
    try (Connection con = DbUtils.getConnection()) {
      return con.createQuery(query)
              .addParameter("ProID", ProID)
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

  public static List<Product> findAuctioningBySellerID(int sellerID){
    final String query = "select * from product where Status = 0 and SellerID = :sellerID";
    try (Connection con = DbUtils.getConnection()) {
      return con.createQuery(query)
              .addParameter("sellerID", sellerID)
              .executeAndFetch(Product.class);
    }
  }

  public static List<Product> findAuctionedBySellerID(int sellerID){
    final String query = "select * from product where Status = 1 and SellerID = :sellerID";
    try (Connection con = DbUtils.getConnection()) {
      return con.createQuery(query)
              .addParameter("sellerID", sellerID)
              .executeAndFetch(Product.class);
    }
  }

  public static Product getNewestProduct(){
    final String query = "select * from product order by ProID DESC";
    try (Connection con = DbUtils.getConnection()) {
      List<Product> list = con.createQuery(query)
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
    List<Product> allProduct = ProductModel.findAll();
    allProduct.forEach(product -> product.setCurrentPrice(BidModel.getCurrentPriceByID(product.getProID())));
    Collections.sort(allProduct, new Comparator<Product>() {
      @Override
      public int compare(Product o1, Product o2) {
        return o1.getCurrentPrice()>o2.getCurrentPrice()? -1 : 1;
      }
    });
    List<Product> highestPrice = new ArrayList<>();
    for (int i = 0; i < allProduct.size() && i < 5; i++){
      highestPrice.add(allProduct.get(i));
    }
    return highestPrice;
  }

  //Top 5 sản phẩm sắp kết thúc
  public static List<Product> Top5AboutToEnd(){
    final String query = "select * from product where Status = 0 order by EndDate asc limit 5";
    try (Connection con = DbUtils.getConnection()) {
      return con.createQuery(query)
              .executeAndFetch(Product.class);
    }
  }


  //Top 5 sản phẩm có nhiều người ra giá nhất
  public static List<Product> Top5HotProducts(){
    final String query = "SELECT * FROM product WHERE ProID IN (SELECT ProductID from (SELECT ProductID,COUNT(BidderID) as Count FROM bid GROUP BY ProductID ORDER BY Count DESC LIMIT 5) AS A)";
    try (Connection con = DbUtils.getConnection()) {
      return con.createQuery(query)
              .executeAndFetch(Product.class);
    }
  }
}