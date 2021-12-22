package com.ute.auctionwebapp.beans;

import java.math.BigInteger;
import java.time.LocalDateTime;
import java.util.Date;

public class Product {
  private int ProID;
  private String ProName, TinyDes, FullDes;
  private int SubCatID, SellerID, CatID, ImgIndex;
  private LocalDateTime UploadDate;
  private int Bin;

  public Product() {}


  public Product(int proID, String proName, String tinyDes, String fullDes, int subCatID, int sellerID, int catID, int imgIndex, LocalDateTime uploadDate, int bin) {
    ProID = proID;
    ProName = proName;
    TinyDes = tinyDes;
    FullDes = fullDes;
    SubCatID = subCatID;
    SellerID = sellerID;
    CatID = catID;
    ImgIndex = imgIndex;
    UploadDate = uploadDate;
    Bin = bin;
  }

  public int getProID() {
    return ProID;
  }

  public void setProID(int proID) {
    ProID = proID;
  }

  public String getProName() {
    return ProName;
  }

  public void setProName(String proName) {
    ProName = proName;
  }

  public String getTinyDes() {
    return TinyDes;
  }

  public void setTinyDes(String tinyDes) {
    TinyDes = tinyDes;
  }

  public String getFullDes() {
    return FullDes;
  }

  public void setFullDes(String fullDes) {
    FullDes = fullDes;
  }

  public int getSubCatID() {
    return SubCatID;
  }

  public void setSubCatID(int subCatID) {
    SubCatID = subCatID;
  }

  public int getSellerID() {
    return SellerID;
  }

  public void setSellerID(int sellerID) {
    SellerID = sellerID;
  }

  public int getCatID() {
    return CatID;
  }

  public void setCatID(int catID) {
    CatID = catID;
  }

  public int getImgIndex() {
    return ImgIndex;
  }

  public void setImgIndex(int imgIndex) {
    ImgIndex = imgIndex;
  }

  public LocalDateTime getUploadDate() {
    return UploadDate;
  }

  public void setUploadDate(LocalDateTime uploadDate) {
    UploadDate = uploadDate;
  }

  public int getBin() {
    return Bin;
  }

  public void setBin(int bin) {
    Bin = bin;
  }
}
