package com.ute.auctionwebapp.models;

import com.ute.auctionwebapp.Utils.DbUtils;
import com.ute.auctionwebapp.beans.Category;
import com.ute.auctionwebapp.beans.SubCategory;
import org.sql2o.Connection;

import java.util.List;

public class SubCategoryModel {
  public static List<SubCategory> findAllSubCat() {
    final String query = "select * from subcategory";
    try (Connection con = DbUtils.getConnection()) {
      return con.createQuery(query)
              .executeAndFetch(SubCategory.class);
    }
  }

  public static List<SubCategory> findAll() {
    final String query = "select subcategory.SubCatID, subcategory.SubCatName, subcategory.CatID, category.CatName from subcategory, category where subcategory.CatID = category.CatID";
    try (Connection con = DbUtils.getConnection()) {
      return con.createQuery(query)
        .executeAndFetch(SubCategory.class);
    }
  }

  public static SubCategory findById(int id) {
    final String query = "select subcategory.SubCatID, subcategory.SubCatName, subcategory.CatID, category.CatName from subcategory, category where subcategory.CatID = category.CatID and SubCatID = :SubCatID";
    try (Connection con = DbUtils.getConnection()) {
      List<SubCategory> list = con.createQuery(query)
        .addParameter("SubCatID", id)
        .executeAndFetch(SubCategory.class);

      if (list.size() == 0) {
        return null;
      }

      return list.get(0);
    }
  }

  public static void add(SubCategory c) {
    String insertSql = "INSERT INTO subcategory (SubCatID, SubCatName, CatID) VALUES (:subcatid,:subcatname,:catid)\n";
    try (Connection con = DbUtils.getConnection()) {
      con.createQuery(insertSql)
              .addParameter("subcatid", c.getSubCatID())
              .addParameter("subcatname", c.getSubCatName())
              .addParameter("catid", c.getCatID())
        .executeUpdate();
    }
  }

  public static void update(SubCategory c) {
    String sql = "UPDATE subcategory SET  SubCatName = :subcatname, CatID = :catid WHERE SubCatID = :subcatid \n";
    try (Connection con = DbUtils.getConnection()) {
      con.createQuery(sql)
              .addParameter("subcatid", c.getSubCatID())
              .addParameter("subcatname", c.getSubCatName())
              .addParameter("catid", c.getCatID())
        .executeUpdate();
    }
  }

  public static void delete(int id) {
    String sql = "delete from subcategory where SubCatID = :SubCatID";
    try (Connection con = DbUtils.getConnection()) {
      con.createQuery(sql)
        .addParameter("SubCatID", id)
        .executeUpdate();
    }
  }


}