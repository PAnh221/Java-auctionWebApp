package com.ute.auctionwebapp.beans;

public class SubCategory {
  private int SubCatID;
  private String SubCatName;
  private int CatID;
  private String CatName;

  public SubCategory() {
  }


  public SubCategory(int subCatID, String subCatName, int catID, String catName) {
    SubCatID = subCatID;
    SubCatName = subCatName;
    CatID = catID;
    CatName = catName;
  }

  public int getSubCatID() {
    return SubCatID;
  }

  public void setSubCatID(int subCatID) {
    SubCatID = subCatID;
  }

  public String getSubCatName() {
    return SubCatName;
  }

  public void setSubCatName(String subCatName) {
    SubCatName = subCatName;
  }

  public int getCatID() {
    return CatID;
  }

  public void setCatID(int catID) {
    CatID = catID;
  }

  public String getCatName() {
    return CatName;
  }

  public void setCatName(String catName) {
    CatName = catName;
  }
}
