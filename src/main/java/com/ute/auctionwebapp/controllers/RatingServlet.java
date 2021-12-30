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
import java.util.List;


@WebServlet(name = "RatingServlet", value = "/Rating/*")

public class RatingServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        HttpSession session = request.getSession();
        Boolean state = (Boolean) session.getAttribute("auth");
        User currentUser = (User)session.getAttribute("authUser");
        if (path.equals("/AddRate")) {
            if(!state) {
                ServletUtils.redirect("/Home",request,response);
                return;
            }
            String ratedUsername = request.getParameter("RatedUsername");
            User userRated = UserModel.findByUsername(ratedUsername);
            int productID = Integer.parseInt(request.getParameter("ProID"));
            Product product = ProductModel.findById(productID);
            if (ratedUsername == null || userRated == null || product == null || productID == 0) {
                ServletUtils.redirect("/Home",request,response);
            }else if(RatingModel.checkIfCanRate(currentUser.getUserID(), userRated.getUserID(), productID)){

                request.setAttribute("user", userRated);
                request.setAttribute("reputation", RatingModel.getReputationOfUserID(userRated.getUserID()));
                ServletUtils.forward("/views/vwRating/AddRating.jsp",request,response);
            } else {
                ServletUtils.redirect("/Home",request,response);
            }
        } else if (path.equals("/Detail")) {
            String usernameDetail = (String) request.getParameter("Username");
            User userDetail = UserModel.findByUsername(usernameDetail);
            if (usernameDetail == null || userDetail == null){
                ServletUtils.redirect("/Home",request,response);
                return;
            }
            if(state) {
                if (usernameDetail.equals(currentUser.getUserName()) || userDetail.getPermission() == 1 || RatingModel.checkIfCanWatchDetail(currentUser.getUserID(),userDetail.getUserID())) {
                    List<Rating> listRating = RatingModel.getListRatingByIdUser(userDetail.getUserID());
                    listRating.forEach(rating -> {
                        rating.setRatingName(UserModel.findUsernameByID(rating.getIdRating()));
                    });
                    request.setAttribute("listRating", listRating);
                    request.setAttribute("user", userDetail);
                    request.setAttribute("reputation", RatingModel.getReputationOfUserID(userDetail.getUserID()));
                    ServletUtils.forward("/views/vwRating/Detail.jsp", request, response);
                    return;
                }
            }else if (userDetail.getPermission() == 1) {
                List<Rating> listRating = RatingModel.getListRatingByIdUser(userDetail.getUserID());
                listRating.forEach(rating -> {rating.setRatingName(UserModel.findUsernameByID(rating.getIdRating()));});
                request.setAttribute("listRating", listRating);
                request.setAttribute("user", userDetail);
                request.setAttribute("reputation",RatingModel.getReputationOfUserID(userDetail.getUserID()));
                ServletUtils.forward("/views/vwRating/Detail.jsp", request, response);
                return;
            }
            ServletUtils.redirect("/Home",request,response);
        }
    }


}
