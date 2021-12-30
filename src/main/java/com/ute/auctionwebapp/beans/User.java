package com.ute.auctionwebapp.beans;

import com.ute.auctionwebapp.models.RatingModel;

import java.time.LocalDateTime;

public class User {
  private int UserID, Permission;
  private String UserName, Name, Password, Address, Email;
  private LocalDateTime Dob;
  private Boolean CanAuction;

  public User() {
  }

  public User(int permission, String userName, String name, String password, String address, String email, LocalDateTime dob) {
    Permission = permission;
    UserName = userName;
    Name = name;
    Password = password;
    Address = address;
    Email = email;
    Dob = dob;
    CanAuction = true;
  }

  public User(int userID, int permission, String userName, String name, String password, String address, String email, LocalDateTime dob) {
    UserID = userID;
    Permission = permission;
    UserName = userName;
    Name = name;
    Password = password;
    Address = address;
    Email = email;
    Dob = dob;
    CanAuction = true;
  }

  public int getUserID() {
    return UserID;
  }

  public void setUserID(int userID) {
    UserID = userID;
  }

  public int getPermission() {
    return Permission;
  }

  public void setPermission(int permission) {
    Permission = permission;
  }

  //public int getRating() {
  //  return Rating;
  //}

  //public void setRating(int rating) {
  //  Rating = rating;
  //}

  public String getUserName() {
    return UserName;
  }

  public void setUserName(String userName) {
    UserName = userName;
  }

  public String getName() {
    return Name;
  }

  public void setName(String name) {
    Name = name;
  }

  public String getPassword() {
    return Password;
  }

  public void setPassword(String password) {
    Password = password;
  }

  public String getAddress() {
    return Address;
  }

  public void setAddress(String address) {
    Address = address;
  }

  public String getEmail() {
    return Email;
  }

  public void setEmail(String email) {
    Email = email;
  }

  public LocalDateTime getDob() {
    return Dob;
  }

  public void setDob(LocalDateTime dob) {
    Dob = dob;
  }

  public Boolean getCanAuction(){return CanAuction;}

  public void setCanAuction(Boolean canAuction){CanAuction = canAuction;}
}
