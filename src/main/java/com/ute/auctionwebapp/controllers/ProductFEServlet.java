package com.ute.auctionwebapp.controllers;

import com.mysql.cj.Session;
import com.ute.auctionwebapp.Utils.ServletUtils;
import com.ute.auctionwebapp.beans.*;
import com.ute.auctionwebapp.models.CategoryModel;
import com.ute.auctionwebapp.models.ProductModel;
import com.ute.auctionwebapp.models.UserModel;
import com.ute.auctionwebapp.models.WatchlistModel;
import com.ute.auctionwebapp.models.BidModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "ProductFEServlet", value = "/Product/*")
public class ProductFEServlet extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String path = request.getPathInfo();
    if (path == null || path.equals("/")) {
      path = "/Index";
    }

    HttpSession session = request.getSession();
    String state = String.valueOf(session.getAttribute("auth"));

    switch (path) {
      case "/MyBid":
        if (state == "false") {
          ServletUtils.redirect("/Account/Login", request, response);
          break;
        }
        List<Product> bList = ProductModel.findBiddedProductbyUserID(Integer.parseInt(request.getParameter("UserID")));
        request.setAttribute("biddingProductDetails", bList);
        ServletUtils.forward("/views/vwProduct/BiddingList.jsp", request, response);
        break;

      case "/Watchlist":
        if (state == "false") {
          ServletUtils.redirect("/Account/Login", request, response);
          break;
        }

        int UID = Integer.parseInt(request.getParameter("UserID"));
        List<Product> wList = WatchlistModel.findAllbyUserID(UID);
        request.setAttribute("watchlistDetails", wList);
        ServletUtils.forward("/views/vwProduct/Watchlist.jsp", request, response);
        break;

      case "/AddWatchlist":
        if (state == "false") {
          ServletUtils.redirect("/Account/Login", request, response);
          break;
        }
        addWatchlist(request, response);
        break;

      case "/RemoveWatchlist":
        if (state == "false") {
          ServletUtils.redirect("/Account/Login", request, response);
          break;
        }
        deleteWatchlist(request, response);
        break;

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

      case "/BySubCat":
        int subcatId = Integer.parseInt(request.getParameter("id"));
        List<Product> listsubcat = ProductModel.findBySubCatId(subcatId);
        request.setAttribute("products", listsubcat);
        ServletUtils.forward("/views/vwProduct/ByCat.jsp", request, response);
        break;

      case "/ByRank":
        int rankingId = Integer.parseInt(request.getParameter("rankingid"));
        if(rankingId == 1) { //by price
          List<Product> top5HighestPrice = ProductModel.Top5HighestPrice();
          request.setAttribute("products", top5HighestPrice);
        }
        ServletUtils.forward("/views/vwProduct/ByCat.jsp", request, response);
        break;

      case "/Detail":
        int proId = Integer.parseInt(request.getParameter("id"));
        Product product = ProductModel.findById(proId);
        product.setCurrentBidderUsername(BidModel.getCurrentBidderUsernameByID(proId));
        product.setCurrentPrice(BidModel.getCurrentPriceByID(proId));
        List<Product> list_relevant = ProductModel.findRelevantProductByProID(proId); //danh sach sp cung subcat
        List<Bid> list_bid = BidModel.getListBidByProductID(proId);
        list_bid.forEach(bid -> bid.setUserName(UserModel.findById(bid.getBidderID()).getUserName()));
        int sID = product.getSellerID();
        User s = UserModel.findById(sID);


        if (ProductModel.findById(proId) == null) {
          ServletUtils.redirect("/Home", request, response);
        } else {
          request.setAttribute("product", product);
          request.setAttribute("relevantProducts", list_relevant);
          request.setAttribute("bidHistory", list_bid);
          request.setAttribute("seller", s);
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


      default:
        ServletUtils.forward("/views/404.jsp", request, response);
        break;
    }
  }

  private void addWatchlist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id_user = Integer.parseInt(request.getParameter("UserID"));
        int id_product = Integer.parseInt(request.getParameter("ProID"));
        Watchlist w = new Watchlist(id_product, id_user);
        WatchlistModel.add(w);
        ServletUtils.redirect("/Product/Index", request, response);
  }

  private void deleteWatchlist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    int id_user = Integer.parseInt(request.getParameter("UserID"));
    int id_product = Integer.parseInt(request.getParameter("ProID"));
    Watchlist w = new Watchlist(id_product, id_user);
    WatchlistModel.delete(w);
    ServletUtils.redirect("/Product/Index", request, response);
  }
}
