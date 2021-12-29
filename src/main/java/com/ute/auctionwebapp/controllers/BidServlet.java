package com.ute.auctionwebapp.controllers;

import java.util.Properties;


//import at.favre.lib.crypto.bcrypt.BCrypt;
import com.ute.auctionwebapp.Utils.ServletUtils;
import com.ute.auctionwebapp.beans.Category;
import com.ute.auctionwebapp.beans.Product;
import com.ute.auctionwebapp.beans.SubCategory;
import com.ute.auctionwebapp.beans.User;
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
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String path = request.getPathInfo();

        HttpSession session = request.getSession();
        String state = String.valueOf(session.getAttribute("auth"));
        User user = (User)session.getAttribute("authUser");

        if (path.equals("/AddBid")){
            int productID = Integer.parseInt(request.getParameter("proid"));
            String price = (String)request.getParameter("price");
            System.out.println(productID);
            System.out.println(price);
            ServletUtils.redirect("/home",request, response);
        }
    }
}