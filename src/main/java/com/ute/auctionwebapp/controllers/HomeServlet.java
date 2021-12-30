package com.ute.auctionwebapp.controllers;

import com.ute.auctionwebapp.Utils.ServletUtils;
import com.ute.auctionwebapp.beans.Bid;
import com.ute.auctionwebapp.beans.Product;
import com.ute.auctionwebapp.beans.User;
import com.ute.auctionwebapp.models.BidModel;
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
                List<Product> listAll = ProductModel.findAll();
                request.setAttribute("allProducts", listAll);

                List<Product> listP1 = ProductModel.Top5AboutToEnd();
                listP1.forEach(product -> {
                    product.setCurrentPrice(BidModel.getCurrentPriceByID(product.getProID()));
                    product.setCurrentBidderUsername(BidModel.getCurrentBidderUsernameByID(product.getProID()));});
                List<Product> listP2 = ProductModel.Top5HotProducts();
                listP2.forEach(product -> {
                    product.setCurrentPrice(BidModel.getCurrentPriceByID(product.getProID()));
                    product.setCurrentBidderUsername(BidModel.getCurrentBidderUsernameByID(product.getProID()));});
                List<Product> listP3 = ProductModel.Top5HighestPrice();
                listP3.forEach(product -> {
                    product.setCurrentPrice(BidModel.getCurrentPriceByID(product.getProID()));
                    product.setCurrentBidderUsername(BidModel.getCurrentBidderUsernameByID(product.getProID()));});
                request.setAttribute("top5_1", listP1);
                request.setAttribute("top5_2", listP2);
                request.setAttribute("top5_3", listP3);

                ServletUtils.forward("/views/vwHome/Index.jsp", request, response);
                break;
            case "/bySearch":
                String keyword = request.getParameter("search_input");
                String type_order = request.getParameter("type_order");
                if(type_order==null){
                    type_order="new_post";
                }
                List<Product> listSearchProduct = ProductModel.fullTextSearch(keyword,type_order);
                request.setAttribute("listSearchProduct", listSearchProduct);
                request.setAttribute("keyword", keyword);
                String order = null;
                switch (type_order){
                    case "new_post":
                        order = "New Post";
                        break;
                    case "almost_over":
                        order = "Almost Over";
                        break;
                    case "asc_price":
                        order = "Price: Low to High";
                        break;
                    case "des_price":
                        order = "Price: High to Low";
                        break;
                    default:
                        ServletUtils.forward("/views/404.jsp",request,response);
                        break;
                }
                request.setAttribute("order_by",order);
                ServletUtils.forward("/views/vwHome/bySearch.jsp",request,response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp",request,response);
                break;
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

}
