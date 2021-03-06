package com.ute.auctionwebapp.controllers;

import com.mysql.cj.Session;
import com.ute.auctionwebapp.Utils.ServletUtils;
import com.ute.auctionwebapp.beans.*;
import com.ute.auctionwebapp.models.*;
//import org.graalvm.compiler.core.common.alloc.Trace;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

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

        bList.forEach(product -> {
          product.setCurrentPrice(BidModel.getCurrentPriceByID(product.getProID()));
          product.setCurrentBidderUsername(BidModel.getCurrentBidderUsernameByID(product.getProID()));});

        request.setAttribute("biddingProductDetails", bList);
        int userId = Integer.parseInt(request.getParameter("UserID"));
        if(userId!=((User)session.getAttribute("authUser")).getUserID()) return;
        List<Bid> list = BidModel.getListBidByBidderID(userId);
        List<Product> listProductBidding = new ArrayList<>();
        List<Product> listWinProduct = new ArrayList<>();
        for (Bid bid : list) {
          Product product = ProductModel.findById(bid.getProductID());
          if (product.getStatus()==0)
            listProductBidding.add(product);
          else if (Objects.equals(BidModel.getCurrentBidderUsernameByID(product.getProID()), ((User) session.getAttribute("authUser")).getUserName())){
            product.setSellerUsername(UserModel.findUsernameByID(product.getSellerID()));
            listWinProduct.add(product);
          }
        }
        for (Product product : listWinProduct) {
          product.setCurrentPrice(BidModel.getCurrentPriceByID(product.getProID()));
          product.setCurrentBidderUsername(BidModel.getCurrentBidderUsernameByID(product.getProID()));
        }
        for (Product product : listProductBidding) {
          product.setCurrentPrice(BidModel.getCurrentPriceByID(product.getProID()));
          product.setCurrentBidderUsername(BidModel.getCurrentBidderUsernameByID(product.getProID()));
        }
        request.setAttribute("biddingProductDetails", listProductBidding);
        request.setAttribute("winProductDetails", listWinProduct);
        ServletUtils.forward("/views/vwProduct/BiddingList.jsp", request, response);
        break;

      case "/Watchlist":
        if (state == "false") {
          ServletUtils.redirect("/Account/Login", request, response);
          break;
        }
        int UID = Integer.parseInt(request.getParameter("UserID"));
        if(UID!=((User)session.getAttribute("authUser")).getUserID()) return;
        List<Product> wList = WatchlistModel.findAllbyUserID(UID);
        for (Product product : wList) {
          product.setCurrentPrice(BidModel.getCurrentPriceByID(product.getProID()));
          product.setCurrentBidderUsername(BidModel.getCurrentBidderUsernameByID(product.getProID()));
        }
        request.setAttribute("watchlistDetails", wList);
        ServletUtils.forward("/views/vwProduct/Watchlist.jsp", request, response);
        break;

      case "/AddWatchlist":
        if (state == "false") {
          ServletUtils.redirect("/Account/Login", request, response);
          break;
        }
        UID = Integer.parseInt(request.getParameter("UserID"));
        if(UID!=((User)session.getAttribute("authUser")).getUserID()) return;
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
        for (Product product : listP) {
          product.setCurrentPrice(BidModel.getCurrentPriceByID(product.getProID()));
          product.setCurrentBidderUsername(BidModel.getCurrentBidderUsernameByID(product.getProID()));
        }
        request.setAttribute("products", listP);

        ServletUtils.forward("/views/vwProduct/ByCat.jsp", request, response);
        break;

      case "/ByCat":
        int catId = Integer.parseInt(request.getParameter("id"));
        List<Product> listByCat = ProductModel.findByCatId(catId);

        listByCat.forEach(product -> {
          product.setCurrentPrice(BidModel.getCurrentPriceByID(product.getProID()));
          product.setCurrentBidderUsername(BidModel.getCurrentBidderUsernameByID(product.getProID()));});
        List<SubCategory> subCategories = SubCategoryModel.getSubbyIDCat(catId);
        request.setAttribute("subcategoriesWithDetails",subCategories);
        request.setAttribute("products", listByCat);
        ServletUtils.forward("/views/vwProduct/ByCat.jsp", request, response);
        break;

      case "/BySubCat":
        int subcatId = Integer.parseInt(request.getParameter("id"));
        List<Product> listsubcat = ProductModel.findBySubCatId(subcatId);
        for (Product product : listsubcat) {
          product.setCurrentPrice(BidModel.getCurrentPriceByID(product.getProID()));
          product.setCurrentBidderUsername(BidModel.getCurrentBidderUsernameByID(product.getProID()));
        }
        request.setAttribute("products", listsubcat);
        ServletUtils.forward("/views/vwProduct/ByCat.jsp", request, response);
        break;

      case "/Detail":
        int proId = Integer.parseInt(request.getParameter("id"));
        Product product = ProductModel.findById(proId);
        product.setCurrentBidderUsername(BidModel.getCurrentBidderUsernameByID(proId));
        product.setCurrentPrice(BidModel.getCurrentPriceByID(proId));
        List<Product> list_relevant = ProductModel.findRelevantProductByProID(proId); //danh sach sp cung subcat
        for (Product product1 : list_relevant) {
          product1.setCurrentBidderUsername(BidModel.getCurrentBidderUsernameByID(product1.getProID()));
          product1.setCurrentPrice(BidModel.getCurrentPriceByID(proId));
        }
        List<Bid> list_bid = BidModel.getListBidByProductID(proId);
        list_bid.forEach(bid -> bid.setUserName(UserModel.findById(bid.getBidderID()).getUserName()));
        List<Ban> listBanned = BanModel.findListBanByProductID(proId);

        Boolean isBanned = false;
        if (state == "true"){
          User currentUser = (User)session.getAttribute("authUser");
          int currentUserID = currentUser.getUserID();
          for (Ban ban : listBanned) {
            if (ban.getBidderBannedID() == currentUserID){
              isBanned = true;
              break;
            }
          }
        }
        int sID = product.getSellerID();
        User s = UserModel.findById(sID);

        if (ProductModel.findById(proId) == null) {
          ServletUtils.redirect("/Home", request, response);
        } else {
          request.setAttribute("product", product);
          request.setAttribute("relevantProducts", list_relevant);
          for (Bid bid : list_bid) {
            bid.setReputationOfBidder(RatingModel.getReputationOfUserID(bid.getBidderID()));
            String txt = bid.getUserName();
            String[] res = new String[txt.length()];
            for (int i = 0; i < txt.length(); i++) {
              res[i] = Character.toString(txt.charAt(i));
            }
            String encode = "";
            for (int i = 0; i < res.length; i++) {
              if(i%2 == 0)
              {
                encode = encode + res[i];
              }
              else
              {
                encode = encode + "*";
              }
            }
            bid.setEncodeUserName(encode);
          }
          request.setAttribute("bidHistory", list_bid);
          request.setAttribute("seller", s);
          request.setAttribute("isBanned", isBanned);

          User currentUser = (User)session.getAttribute("authUser");
          int currentUserID = currentUser.getUserID();
          currentUser.setCanAuction(RatingModel.getReputationOfUserID(currentUser.getUserID())>80);
          session.setAttribute("authUser",currentUser);
          request.setAttribute("reputation", RatingModel.getReputationOfUserID(currentUserID));
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
        ServletUtils.redirect("/Home/Index", request, response);
  }

  private void deleteWatchlist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    int id_user = Integer.parseInt(request.getParameter("UserID"));
    int id_product = Integer.parseInt(request.getParameter("ProID"));
    Watchlist w = new Watchlist(id_product, id_user);
    WatchlistModel.delete(w);

    int UID = Integer.parseInt(request.getParameter("UserID"));
    List<Product> wList = WatchlistModel.findAllbyUserID(UID);
    request.setAttribute("watchlistDetails", wList);
    ServletUtils.forward("/views/vwProduct/Watchlist.jsp", request, response);
  }
}
