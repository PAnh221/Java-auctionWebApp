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

@WebServlet(name = "BanServlet", value = "/Ban/*")
public class BanServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServletUtils.redirect("/Home",request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("do duoc post ban");
        request.setCharacterEncoding("UTF-8");
        String path = request.getPathInfo();
        HttpSession session = request.getSession();
        User user = (User)session.getAttribute("authUser");
        if(path.equals("/AddBan")){
            int productID = Integer.parseInt(request.getParameter("proid"));
            String bidderUserName = (String)request.getParameter("bidderusername");
            Product product = ProductModel.findById(productID);
            if(ProductModel.findById(productID) == null || bidderUserName.equals("") || user.getUserID() != ProductModel.findById(productID).getSellerID()) return;
            Ban ban = new Ban(UserModel.findByUsername(bidderUserName).getUserID(), productID);
            BanModel.addBan(ban);
        }
    }
}