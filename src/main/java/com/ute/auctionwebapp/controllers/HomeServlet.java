package com.ute.auctionwebapp.controllers;

import com.ute.auctionwebapp.Utils.ServletUtils;
import com.ute.auctionwebapp.beans.Product;
import com.ute.auctionwebapp.beans.User;
import com.ute.auctionwebapp.models.ProductModel;
import com.ute.auctionwebapp.models.UserModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeServlet", value = "/Home/*")
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        if (path == null || path.equals("/")){
            path = "/Index";
        }
        switch (path){
            case "/Index":

                List<Product> listP1 = ProductModel.Top5AboutToEnd();
                List<Product> listP2 = ProductModel.Top5HotProducts();
                List<Product> listP3 = ProductModel.Top5HighestPrice();

                request.setAttribute("top5_1", listP1);
                request.setAttribute("top5_2", listP2);
                request.setAttribute("top5_3", listP3);

                ServletUtils.forward("/views/vwHome/Index.jsp", request, response);
                break;
//            case "/About":
//                ServletUtils.forward("/views/vwHome/About.jsp",request,response);
//                break;
            default:
                ServletUtils.forward("/views/404.jsp",request,response);
                break;
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

}
