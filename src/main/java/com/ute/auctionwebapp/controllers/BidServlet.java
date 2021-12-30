package com.ute.auctionwebapp.controllers;

import java.util.Properties;


//import at.favre.lib.crypto.bcrypt.BCrypt;
import com.ute.auctionwebapp.Utils.ServletUtils;
import com.ute.auctionwebapp.beans.*;
import com.ute.auctionwebapp.models.*;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
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
                    //mail
                    final String username = "caulacbo3qcuhanh@gmail.com";
                    final String password = "thanhnha";
                    Properties prop = new Properties();
                    prop.put("mail.smtp.host", "smtp.gmail.com");
                    prop.put("mail.smtp.port", "587");
                    prop.put("mail.smtp.auth", "true");
                    prop.put("mail.smtp.starttls.enable", "true");
                    Session session2 = Session.getInstance(prop, new javax.mail.Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(username, password);
                        }
                    });

                    String emailTo = user.getEmail();
                    String emailSubject = "Ra gia thanh cong!";
                    String content = "Ban da dau gia "+product.getProName() +" thanh cong voi gia la: "+price;
                    try {
                        Message message = new MimeMessage(session2);
                        message.setFrom(new InternetAddress(username));
                        message.setRecipients(
                                Message.RecipientType.TO,
                                InternetAddress.parse(emailTo)
                        );
                        message.setSubject(emailSubject);
                        message.setText(content);

                        // sends the e-mail
                        Transport.send(message);
                        System.out.println("send done!");
                    }
                    catch (Exception e)
                    {
                        e.printStackTrace();
                    }

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