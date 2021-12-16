package com.ute.auctionwebapp.controllers;


import com.ute.auctionwebapp.Utils.ServletUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AdminServlet", value = "/Admin/*")
public class AdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        if (path == null || path.equals("/")) {
            path = "/Product/Index";
        }

        switch (path) {
            case "/Product/Index":
                // HttpSession session = request.getSession();
                // System.out.println(session.getAttribute("auth"));
                // System.out.println(session.getAttribute("authUser"));

                ServletUtils.forward("/views/vwAdmin/login.jsp", request, response);
                break;
            case "/Product/Detail":
                ServletUtils.forward("/views/vwAdmin/index.jsp", request, response);
                break;
            case "/Product/Add":
                ServletUtils.forward("/views/vwAdmin/addProduct.jsp", request, response);
                break;
            case "/Product/Edit":
                ServletUtils.forward("/views/vwAdmin/editProduct.jsp", request, response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp", request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        if (path == null || path.equals("/")) {
            path = "/Product/Index";
        }

        switch (path) {
            case "/Product/Login":
                String username = request.getParameter("user");
                String pass = request.getParameter("pass");
                if(username.equals("admin") & pass.equals("admin"))
                {
                    ServletUtils.forward("/views/vwAdmin/index.jsp", request, response);
                }
                ServletUtils.redirect("/Admin",request,response);
                break;

            default:
                ServletUtils.forward("/views/404.jsp", request, response);
                break;
        }
    }
}
