package com.ute.auctionwebapp.models;

import com.ute.auctionwebapp.Utils.DbUtils;
import com.ute.auctionwebapp.beans.Product;
import com.ute.auctionwebapp.beans.User;
import org.sql2o.Connection;

import java.util.List;

public class UserModel {
  public static List<User> findAll() {
    final String query = "SELECT UserID, UserName, Name, Password, Address, Email, Dob, Permission, Rating FROM user\n";
    try (Connection con = DbUtils.getConnection()) {
      return con.createQuery(query)
        .executeAndFetch(User.class);
    }
  }
  public static List<User> findByPermission(int id) {
    final String query = "select * from user where Permission = :Permission";
    try (Connection con = DbUtils.getConnection()) {
      List<User> list = con.createQuery(query)
              .addParameter("Permission", id)
              .executeAndFetch(User.class);

      if (list.size() == 0) {
        return null;
      }

      return list;
    }
  }
  public static User findById(int id) {
    final String query = "select * from user where UserID = :UserID";
    try (Connection con = DbUtils.getConnection()) {
      List<User> list = con.createQuery(query)
        .addParameter("UserID", id)
        .executeAndFetch(User.class);

      if (list.size() == 0) {
        return null;
      }
      return list.get(0);
    }
  }
  public static User findByUsername(String username) {
    final String query = "select * from user where UserName = :UserName";
    try (Connection con = DbUtils.getConnection()) {
      List<User> list = con.createQuery(query)
              .addParameter("UserName", username)
              .executeAndFetch(User.class);

      if (list.size() == 0) {
        return null;
      }
      return list.get(0);
    }
  }

  public static void add(User c) {
    String insertSql = "INSERT INTO user (UserID,UserName, Name, Password, Address, Email, Dob, Permission, Rating) VALUES (:userid,:username,:name,:password,:address,:email,:dob,:permission,:rating)\n";
    try (Connection con = DbUtils.getConnection()) {
      con.createQuery(insertSql)
              .addParameter("userid", c.getUserID())
              .addParameter("username", c.getUserName())
              .addParameter("name", c.getName())
              .addParameter("password", c.getPassword())
              .addParameter("address", c.getAddress())
              .addParameter("email", c.getEmail())
              .addParameter("dob", c.getDob())
              .addParameter("permission", c.getPermission())
              .addParameter("rating", c.getRating())
              .executeUpdate();
    }
  }

  public static void update(User c) {
    String sql = "UPDATE user SET  UserName = :username, Name = :name, Password = :password, Address = :address, Email = :email, Dob = :dob, Permission = :permission, Rating = :rating WHERE UserID = :userid \n";
    try (Connection con = DbUtils.getConnection()) {
      con.createQuery(sql)
              .addParameter("userid", c.getUserID())
              .addParameter("username", c.getUserName())
              .addParameter("name", c.getName())
              .addParameter("password", c.getPassword())
              .addParameter("address", c.getAddress())
              .addParameter("email", c.getEmail())
              .addParameter("dob", c.getDob())
              .addParameter("permission", c.getPermission())
              .addParameter("rating", c.getRating())
        .executeUpdate();
    }
  }

  public static void delete(int id) {
    String sql = "delete from user where UserID = :UserID";
    try (Connection con = DbUtils.getConnection()) {
      con.createQuery(sql)
        .addParameter("UserID", id)
        .executeUpdate();
    }
  }

  public static void upgradeBidder(int id) {
    String sql = "UPDATE user SET  Permission = 1 WHERE UserID = :userid and Rating > 9\n";
    try (Connection con = DbUtils.getConnection()) {
      con.createQuery(sql)
              .addParameter("userid", id)
              .executeUpdate();
    }
  }
  public static void degradeSeller(int id) {
    String sql = "UPDATE user SET  Permission = 2 WHERE UserID = :userid \n";
    try (Connection con = DbUtils.getConnection()) {
      con.createQuery(sql)
              .addParameter("userid", id)
              .executeUpdate();
    }
  }
}