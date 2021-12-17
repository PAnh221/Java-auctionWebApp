package com.ute.auctionwebapp.controllers;

import com.ute.auctionwebapp.Utils.ServletUtils;
import com.ute.auctionwebapp.beans.Category;
import com.ute.auctionwebapp.beans.Product;
import com.ute.auctionwebapp.beans.Watchlist;
import com.ute.auctionwebapp.models.CategoryModel;
import com.ute.auctionwebapp.models.ProductModel;
import com.ute.auctionwebapp.models.WatchlistModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductFEServlet", value = "/Product/*")
public class ProductFEServlet extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String path = request.getPathInfo();
    if (path == null || path.equals("/")) {
      path = "/Index";
    }
    switch (path) {
      case "/Index":
        List<Product> listP = ProductModel.findAll();
        request.setAttribute("products", listP);
        ServletUtils.forward("/views/vwProduct/ByCat.jsp", request, response);
        break;

      case "/ByCat":
        int catId = Integer.parseInt(request.getParameter("id"));
        List<Product> list = ProductModel.findByCatId(catId);
        request.setAttribute("products", list);
        ServletUtils.forward("/views/vwProduct/ByCat.jsp", request, response);
        break;

      case "/Detail":
        int proId = Integer.parseInt(request.getParameter("id"));
        Product product = ProductModel.findById(proId);
        if (product == null) {
          ServletUtils.redirect("/Home", request, response);
        } else {
          request.setAttribute("product", product);
          ServletUtils.forward("/views/vwProduct/Detail.jsp", request, response);
        }
        break;

      default:
        ServletUtils.forward("/views/404.jsp", request, response);
        break;
    }
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String path = request.getPathInfo();
    switch (path) {
      case "/ByCat?id=2":
        addWatchlist(request, response);
        break;

      default:
        ServletUtils.forward("/views/404.jsp", request, response);
        break;
    }
  }

  private void addWatchlist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//    int proid = Integer.parseInt(request.getParameter("proid"));
    int userid = 1;
    int proid = 1;
    Watchlist w = new Watchlist(proid, userid);
    WatchlistModel.add(w);
    ServletUtils.forward("views/vwProduct/ByCat?id=2", request, response);
  }
}
