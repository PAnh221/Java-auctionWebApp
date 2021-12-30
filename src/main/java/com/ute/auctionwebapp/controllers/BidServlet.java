package com.ute.auctionwebapp.controllers;

import java.util.Properties;


//import at.favre.lib.crypto.bcrypt.BCrypt;
import com.ute.auctionwebapp.Utils.ServletUtils;
import com.ute.auctionwebapp.beans.*;
import com.ute.auctionwebapp.models.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet(name = "BidServlet", value = "/Bid/*")
public class BidServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        System.out.println("do duoc get");
        if (path == null || path.equals("/")){
            path = "/Index";
        }
        switch (path){
            case "/Index":
                ServletUtils.redirect("/Home", request, response);
                break;
            default:
                ServletUtils.redirect("/Home", request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String path = request.getPathInfo();
        if(path.equals("/AddBid")){
            int productID = Integer.parseInt(request.getParameter("proid"));
            int bidderID = Integer.parseInt(request.getParameter("bidderid"));
            if(bidderID == 0) return;
            Product product = ProductModel.findById(productID);
            int price = Integer.parseInt(request.getParameter("price"));
            HttpSession session = request.getSession();
            Boolean state = (Boolean)request.getAttribute("auth");
            User user = (User)session.getAttribute("authUser");
            LocalDateTime now = LocalDateTime.now();
            Bid newBid = new Bid(user.getUserID(), productID, now, price);
            if(bidderID == user.getUserID() && ProductModel.findById(productID) != null && product.getStatus() == 0 && product.getEndDate().isAfter(now)) {
                if(RatingModel.getReputationOfUserID(user.getUserID()) <= 80) return;
                if (product.getBin() > 0) {
                    if(price > product.getBin()) {
                        newBid.setMaxBid(product.getBin());
                        ProductModel.endAuctionProductID(productID);
                    }
                    else if(price < product.getCurrentPrice() + product.getStepPrice()){
                        return;
                    }
                } else if(price < product.getCurrentPrice() + product.getStepPrice()){
                    return;
                }
                if(BidModel.notExisted(productID, user.getUserID())){
                    BidModel.addBid(newBid);
                    if(newBid.getMaxBid() == product.getBin())
                        ProductModel.endAuctionProductID(productID);
                }
                else{
                    BidModel.updateBid(newBid);
                    if(newBid.getMaxBid() == product.getBin())
                        ProductModel.endAuctionProductID(productID);
                }
            }
        }
    }
}