package com.ute.auctionwebapp.controllers;
import com.ute.auctionwebapp.Utils.ServletUtils;
import com.ute.auctionwebapp.models.RequestModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "RequestServlet", value = "/Request/*")
public class RequestServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();

//        HttpSession session = request.getSession();
//        String state = String.valueOf(session.getAttribute("auth"));

        switch (path) {
            case "/AddRequest":
                addRequest(request, response);
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

    private void addRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int UserID = Integer.parseInt(request.getParameter("id"));
        RequestModel.add(UserID);
        ServletUtils.redirect("/Account/Edit", request, response);
    }
}

