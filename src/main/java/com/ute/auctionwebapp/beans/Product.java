package com.ute.auctionwebapp.beans;

//import com.sun.org.apache.xerces.internal.impl.xpath.XPath;

import java.math.BigInteger;
import java.time.LocalDateTime;
import java.util.Date;

public class Product {
  private int ProID;
  private String ProName, TinyDes, FullDes;
  private int SubCatID, SellerID, ImgIndex;
  //private int CatID;
  private LocalDateTime UploadDate, EndDate;
  private int Bin, StartPrice, StepPrice;
  private int Status;
  public Product() {}


  public Product(int proID, String proName, String tinyDes, String fullDes, int subCatID, int sellerID, int imgIndex, LocalDateTime uploadDate, int bin, int startPrice, int stepPrice, int status /*, int catId */) {
    ProID = proID;
    ProName = proName;
    TinyDes = tinyDes;
    FullDes = fullDes;
    SubCatID = subCatID;
    SellerID = sellerID;
    ImgIndex = imgIndex;
    UploadDate = uploadDate;
    Bin = bin;
    Status = status;
    //CatID = catId

    //Mới thêm
    EndDate = uploadDate.plusDays(7);
    StartPrice = startPrice;
    StepPrice = stepPrice;
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

  //public int getCatID() {
  //  return CatID;
  //}
  //
  //public void setCatID(int catId) {
  //  CatID = catId;
  //}

  public int getSellerID() {
    return SellerID;
  }

  public void setSellerID(int sellerID) {
    SellerID = sellerID;
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


  //Mới thêm

  public LocalDateTime getEndDate(){ return EndDate;}

  public void setEndDate(LocalDateTime endDate) { EndDate = endDate;}

  public int getStartPrice() {return StartPrice;}

  public void setStartPrice(int startPrice) {StartPrice = startPrice;}

  public int getStepPrice() {return StepPrice;}

  public void setStepPrice(int stepPrice) {StepPrice = stepPrice;}

  public int getStatus() {return Status;}

  public void setStatus(int status){ Status = status;}

}
