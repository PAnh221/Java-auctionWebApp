package com.ute.auctionwebapp.models;

import com.ute.auctionwebapp.beans.Category;
import com.ute.auctionwebapp.Utils.DbUtils;
import com.ute.auctionwebapp.beans.Product;
import org.sql2o.Connection;

import java.util.List;

public class CategoryModel {
  // public static List<Category> findAll() {
  //   return new ArrayList<>(
  //     Arrays.asList(
  //       new Category(1, "Sách"),
  //       new Category(2, "Quần áo"),
  //       new Category(3, "Điện thoại"),
  //       new Category(4, "Laptop"),
  //       new Category(5, "Loa")
  //     )
  //   );
  // }

  public static List<Category> findAll() {
    final String query = "select * from category";
    try (Connection con = DbUtils.getConnection()) {
      return con.createQuery(query)
        .executeAndFetch(Category.class);
    }
  }

  public static Category findById(int CatID) {
    final String query = "select * from category where CatID = :CatID";
    try (Connection con = DbUtils.getConnection()) {
      List<Category> list = con.createQuery(query)
        .addParameter("CatID", CatID)
        .executeAndFetch(Category.class);

      if (list.size() == 0) {
        return null;
      }

      return list.get(0);
    }
  }

  public static Boolean findByIdPro(int CatID) {
    final String query = "select * from product where CatID = :CatID";
    try (Connection con = DbUtils.getConnection()) {
      List<Product> list = con.createQuery(query)
              .addParameter("CatID", CatID)
              .executeAndFetch(Product.class);

      if (list.size() == 0) {
        return false;
      }

      return true;
    }
  }

  public static void add(Category c) {
    String insertSql = "INSERT INTO category (CatID, CatName) VALUES (:catid,:catname)\n";
    try (Connection con = DbUtils.getConnection()) {
      con.createQuery(insertSql)
              .addParameter("catid", c.getCatID())
        .addParameter("catname", c.getCatName())
        .executeUpdate();
    }
  }

  public static void update(Category c) {
    String sql = "update category set CatName = :CatName where CatID = :CatID";
    try (Connection con = DbUtils.getConnection()) {
      con.createQuery(sql)
        .addParameter("CatID", c.getCatID())
        .addParameter("CatName", c.getCatName())
        .executeUpdate();
    }
  }

  public static void delete(int id) {
    String sql = "delete from category where CatID = :CatID";
    try (Connection con = DbUtils.getConnection()) {
      con.createQuery(sql)
        .addParameter("CatID", id)
        .executeUpdate();
    }
  }
}