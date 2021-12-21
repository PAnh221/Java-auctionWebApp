package com.ute.auctionwebapp.beans;

import java.math.BigInteger;
import java.util.Date;

public class Product {
  private int proID;
  private String proName, tinyDes, fullDes;
  private int subcatID, sellerID, catID, imgindex;
  private Date uploaddate;
  private BigInteger bin;

  public Product() {
  }

  public Product(int proID, String proName, String tinyDes, String fullDes, Date uploaddate, BigInteger bin) {
    this.proID = proID;
    this.proName = proName;
    this.tinyDes = tinyDes;
    this.fullDes = fullDes;
    this.uploaddate = uploaddate;
    this.bin = bin;
  }

  public int getProID() {
    return proID;
  }

  public String getProName() {
    return proName;
  }

  public String getTinyDes() {
    return tinyDes;
  }

  public String getFullDes() {
    return fullDes;
  }

  public Date getUploaddate() {
    return uploaddate;
  }

  public BigInteger getBin() {
    return bin;
  }


  public int getSubcatID() {
    return subcatID;
  }

  public int getSellerID() {
    return sellerID;
  }

  public int getCatID() {
    return catID;
  }

  public int getImgindex() {
    return imgindex;
  }
}
