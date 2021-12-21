package com.ute.auctionwebapp.beans;

import java.math.BigInteger;
import java.util.Date;

public class Product {
  private int ProID;
  private String ProName, TinyDes, FullDes;
  private int SubCatID, SellerID, CatID, ImgIndex;
  private Date UploadDate;
  private BigInteger Bin;

  public Product() {}

  public Product(int proID, String proName, String tinyDes, String fullDes, int subCatID, int sellerID, int catID, int imgIndex, Date uploadDate, BigInteger bin) {
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

  public String getProName() {
    return ProName;
  }

  public String getTinyDes() {
    return TinyDes;
  }

  public String getFullDes() {
    return FullDes;
  }

  public int getSubCatID() {
    return SubCatID;
  }

  public int getSellerID() {
    return SellerID;
  }

  public int getCatID() {
    return CatID;
  }

  public int getImgIndex() {
    return ImgIndex;
  }

  public Date getUploadDate() {
    return UploadDate;
  }

  public BigInteger getBin() {
    return Bin;
  }
}
