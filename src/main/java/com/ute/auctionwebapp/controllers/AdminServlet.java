package com.ute.auctionwebapp.controllers;


import com.ute.auctionwebapp.Utils.ServletUtils;
import com.ute.auctionwebapp.beans.Category;
import com.ute.auctionwebapp.models.CategoryModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

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
                ServletUtils.forward("/views/vwAdmin/login.jsp", request, response);
                break;
            case "/Product/Detail":
                ServletUtils.forward("/views/vwAdmin/indexProduct.jsp", request, response);
                break;
            case "/Product/Add":
                ServletUtils.forward("/views/vwAdmin/addProduct.jsp", request, response);
                break;
            case "/Product/Edit":
                ServletUtils.forward("/views/vwAdmin/editProduct.jsp", request, response);
                break;

            case "/Category/Add":
                ServletUtils.forward("/views/vwAdmin/addCategory.jsp", request, response);
                break;
            case "/Category/Detail":
                List<Category> list = CategoryModel.findAll();
                request.setAttribute("categories", list);
                ServletUtils.forward("/views/vwAdmin/indexCategory.jsp", request, response);
                break;
            case "/Category/Edit":
                int id = Integer.parseInt(request.getParameter("id"));
                Category c = CategoryModel.findById(id);
                if (c == null)
                {
                    ServletUtils.forward("/views/vwAdmin/indexCategory.jsp", request, response);
                }
                else
                {
                    request.setAttribute("category", c);
                    ServletUtils.forward("/views/vwAdmin/editCategory.jsp", request, response);
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
            case "/Category/Add":
                addCategory(request, response);
                break;
            case "/Category/Update":
                updateCategory(request, response);
                break;
            case "/Category/Delete":
                deleteCategory(request, response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp", request, response);
                break;
        }
    }
    private void addCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int catid = Integer.parseInt(request.getParameter("catid"));
        String catname = request.getParameter("catname");

        Category c = new Category(catid, catname);
        CategoryModel.add(c);
        ServletUtils.forward("/views/vwAdmin/addCategory.jsp", request, response);
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int catid = Integer.parseInt(request.getParameter("catid"));
        String catname = request.getParameter("catname");

        Category c = new Category(catid, catname);
        CategoryModel.update(c);
        ServletUtils.redirect("/Admin/Category/Detail", request, response);
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("catid"));
        CategoryModel.delete(id);
        ServletUtils.redirect("/Admin/Category/Detail", request, response);
    }
}
