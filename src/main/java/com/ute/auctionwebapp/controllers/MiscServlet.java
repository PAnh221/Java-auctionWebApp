package com.ute.auctionwebapp.controllers;

import com.ute.auctionwebapp.Utils.ServletUtils;
import com.ute.auctionwebapp.beans.Category;
import com.ute.auctionwebapp.beans.Product;
import com.ute.auctionwebapp.beans.SubCategory;
import com.ute.auctionwebapp.beans.User;
import com.ute.auctionwebapp.models.CategoryModel;
import com.ute.auctionwebapp.models.ProductModel;
import com.ute.auctionwebapp.models.ProductModelAdmin;
import com.ute.auctionwebapp.models.SubCategoryModel;
//import jdk.internal.loader.AbstractClassLoaderValue;
//import jdk.vm.ci.meta.Local;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Collection;
import java.util.List;
import java.util.Objects;

@WebServlet(name = "MiscServlet", value = "/Misc/*")
@MultipartConfig(
  fileSizeThreshold = 2 * 1024 * 1024,
  maxFileSize = 50 * 1024 * 1024,
  maxRequestSize = 50 * 1024 * 1024
)
public class MiscServlet extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String path = request.getPathInfo();
    HttpSession session = request.getSession();
    User user = (User)session.getAttribute("authUser");
    if(user.getPermission()==2){
      switch (path) {
        case "/Editor":
          ServletUtils.forward("/views/vwMisc/Editor.jsp", request, response);
          break;

        case "/Upload":
          List<Category> category = CategoryModel.findAll();
          List<SubCategory> subcategory = SubCategoryModel.findAll();
          request.setAttribute("subcategory", subcategory);
          ServletUtils.forward("/views/vwMisc/Upload.jsp", request, response);
          break;

        default:
          ServletUtils.forward("/views/404.jsp", request, response);
          break;
      }
    } else {
      ServletUtils.redirect("/Home", request, response);
    }
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    request.setCharacterEncoding("UTF-8");
    String path = request.getPathInfo();
    switch (path) {
      case "/Editor":
        postEditor(request, response);
        break;

      case "/Upload":
        postUpload(request, response);
        break;

      default:
        ServletUtils.forward("/views/404.jsp", request, response);
        break;
    }
  }

  private void postUpload(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String proname = request.getParameter("ProName");
    int imgindex = ProductModel.getNewestProduct().getProID() + 1;
    int bin = Integer.parseInt(request.getParameter("Bin"));
    int startprice = Integer.parseInt(request.getParameter("StartPrice"));
    int stepprice = Integer.parseInt(request.getParameter("StepPrice"));
    String fulldes = request.getParameter("FullDes");
    String tinydes = request.getParameter("TinyDes");
    LocalDateTime uploaddate = LocalDateTime.now();
    HttpSession session = request.getSession();
    User seller = (User)session.getAttribute("authUser");
    int sellerid = seller.getUserID();
    String SubCategoryID = request.getParameter("SubCategory");
    SubCategoryID = SubCategoryID.substring(1,SubCategoryID.length()-1);
    System.out.println(SubCategoryID);
    int subcatid = Integer.parseInt(SubCategoryID);
    Collection<Part> parts = request.getParts();
    for (Part part : request.getParts()) {
      if (part.getName().equals("fuMain")) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] items = contentDisposition.split(";");
        for (String s : items) {
          String tmp = s.trim();
          if (tmp.startsWith("filename")) {
            int idx = tmp.indexOf("=") + 2;
            String filename = tmp.substring(idx, tmp.length() - 1);
            String targetDir = this.getServletContext().getRealPath("public/imgs/sp/" + imgindex);
            System.out.println(targetDir);
            File dir = new File(targetDir);
            Boolean createDirSuccess;
            if (!dir.exists()) {
               createDirSuccess = dir.mkdir();
            }
            else {createDirSuccess = true;}
            if(createDirSuccess) {
              String destination = targetDir + "/" + filename;
              part.write(destination);
            }
            else {
              System.out.println("Lỗi tạo thư mục chứa ảnh!");
            }
          }
        }
      }
    }
    Product prod = new Product(proname, tinydes, fulldes, subcatid, sellerid, imgindex, uploaddate, bin, startprice, stepprice, 0);
    ProductModelAdmin.add(prod);
    List<Category> category = CategoryModel.findAll();
    List<SubCategory> subcategory = SubCategoryModel.findAll();
    request.setAttribute("category", category);
    request.setAttribute("subcategory", subcategory);
    ServletUtils.forward("/views/vwMisc/Upload.jsp", request, response);
  }

  private void postEditor(HttpServletRequest request, HttpServletResponse response) throws
    ServletException, IOException {
    String tinyDesc = request.getParameter("TinyDes");
    System.out.println(tinyDesc);

    String desc = request.getParameter("FullDes");
    System.out.println(desc);

    ServletUtils.forward("/views/vwMisc/Editor.jsp", request, response);
  }
}
