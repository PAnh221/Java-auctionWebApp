package com.ute.auctionwebapp.controllers;


//import at.favre.lib.crypto.bcrypt.BCrypt;
import com.ute.auctionwebapp.Utils.ServletUtils;
import com.ute.auctionwebapp.beans.Category;
import com.ute.auctionwebapp.beans.SubCategory;
import com.ute.auctionwebapp.beans.User;
import com.ute.auctionwebapp.models.CategoryModel;
import com.ute.auctionwebapp.models.SubCategoryModel;
import com.ute.auctionwebapp.models.UserModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
                ServletUtils.forward("/views/vwAdmin/Product/login.jsp", request, response);
                break;
            case "/Product/Detail":
                ServletUtils.forward("/views/vwAdmin/Product/indexProduct.jsp", request, response);
                break;
            case "/Product/Add":
                ServletUtils.forward("/views/vwAdmin/Product/addProduct.jsp", request, response);
                break;
            case "/Product/Edit":
                ServletUtils.forward("/views/vwAdmin/Product/editProduct.jsp", request, response);
                break;


//              CATEGORY <=============================================================
            case "/Category/Add":
                ServletUtils.forward("/views/vwAdmin/Category/addCategory.jsp", request, response);
                break;
            case "/Category/Detail":
                List<Category> list = CategoryModel.findAll();
                request.setAttribute("categories", list);
                ServletUtils.forward("/views/vwAdmin/Category/indexCategory.jsp", request, response);
                break;
            case "/Category/Edit":
                int id = Integer.parseInt(request.getParameter("id"));
                Category c = CategoryModel.findById(id);
                if (c == null)
                {
                    ServletUtils.forward("/views/vwAdmin/Category/indexCategory.jsp", request, response);
                }
                else
                {
                    request.setAttribute("category", c);
                    ServletUtils.forward("/views/vwAdmin/Category/editCategory.jsp", request, response);
                }
                break;

//             SUB CATEGORY <==================================================
            case "/SubCategory/Add":
                List<Category> listCate = CategoryModel.findAll();
                request.setAttribute("categories", listCate);
                ServletUtils.forward("/views/vwAdmin/SubCategory/addSubCat.jsp", request, response);
                break;
            case "/SubCategory/Detail":
                List<SubCategory> list2 = SubCategoryModel.findAll();
                request.setAttribute("categories", list2);
                ServletUtils.forward("/views/vwAdmin/SubCategory/indexSubCat.jsp", request, response);
                break;
            case "/SubCategory/Edit":
                int id2 = Integer.parseInt(request.getParameter("id"));
                SubCategory c2 = SubCategoryModel.findById(id2);
                List<Category> listCat = CategoryModel.findAll();
                if (c2 == null)
                {
                    ServletUtils.forward("/views/vwAdmin/SubCategory/indexSubCat.jsp", request, response);
                }
                else
                {
                    request.setAttribute("categories", listCat);
                    request.setAttribute("category", c2);
                    ServletUtils.forward("/views/vwAdmin/SubCategory/editSubCat.jsp", request, response);
                }
                break;

//              USER <====================================================================
            case "/User/Add":
                ServletUtils.forward("/views/vwAdmin/User/addUser.jsp", request, response);
                break;
            case "/User/Detail":
                List<User> listUser = UserModel.findAll();
                request.setAttribute("users", listUser);
                ServletUtils.forward("/views/vwAdmin/User/indexUser.jsp", request, response);
                break;
            case "/User/Edit":
                int userid = Integer.parseInt(request.getParameter("id"));
                User user = UserModel.findById(userid);
                if (user == null)
                {
                    ServletUtils.forward("/views/vwAdmin/User/indexUser.jsp", request, response);
                }
                else
                {
                    request.setAttribute("user", user);
                    ServletUtils.forward("/views/vwAdmin/User/editCategory.jsp", request, response);
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
                    ServletUtils.forward("/views/vwAdmin/Product/index.jsp", request, response);
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

            case "/SubCategory/Add":
                addSubCategory(request, response);
                break;
            case "/SubCategory/Update":
                updateSubCategory(request, response);
                break;
            case "/SubCategory/Delete":
                deleteSubCategory(request, response);
                break;

            case "/User/Add":
                addUser(request, response);
                break;
            case "/User/Isavailable":
                isAvailable(request, response);
                break;
            case "/User/Update":
                updateUser(request, response);
                break;
            case "/User/Delete":
                deleteUser(request, response);
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
        ServletUtils.forward("/views/vwAdmin/Category/addCategory.jsp", request, response);
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

    private void addSubCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int subcatid = Integer.parseInt(request.getParameter("subcatid"));
        String subcatname = request.getParameter("subcatname");
        int catid = Integer.parseInt(request.getParameter("catid"));

        SubCategory c = new SubCategory(subcatid, subcatname, catid, null);
        SubCategoryModel.add(c);
        ServletUtils.redirect("/Admin/SubCategory/Add", request, response);
    }

    private void updateSubCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int subcatid = Integer.parseInt(request.getParameter("subcatid"));
        String subcatname = request.getParameter("subcatname");
        int catid = Integer.parseInt(request.getParameter("catid"));
        SubCategory c = new SubCategory(subcatid, subcatname, catid, null);
        SubCategoryModel.update(c);
        ServletUtils.redirect("/Admin/SubCategory/Detail", request, response);
    }

    private void deleteSubCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("subcatid"));
        SubCategoryModel.delete(id);
        ServletUtils.redirect("/Admin/SubCategory/Detail", request, response);
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userid = Integer.parseInt(request.getParameter("userid"));
        String username = request.getParameter("username");
        String pass = request.getParameter("password");
//        String bcryptHashString = BCrypt.withDefaults().hashToString(12, pass.toCharArray());
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String bd = request.getParameter("dob")+" 00:00";
        DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        LocalDateTime dob = LocalDateTime.parse(bd, df);
        int permission = Integer.parseInt(request.getParameter("permission"));
        int rating = Integer.parseInt(request.getParameter("rating"));

        User user = new User(userid, permission, rating, username, name, pass, address, email, dob);
        UserModel.add(user);
        ServletUtils.forward("/views/vwAdmin/User/addUser.jsp", request, response);
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userid = Integer.parseInt(request.getParameter("userid"));
        String username = request.getParameter("username");
        String pass = request.getParameter("password");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String bd = request.getParameter("dob");
        DateTimeFormatter df = DateTimeFormatter.ofPattern("d/M/yyyy");
        LocalDateTime dob = LocalDateTime.parse(bd, df);
        int permission = Integer.parseInt(request.getParameter("permission"));
        int rating = Integer.parseInt(request.getParameter("rating"));

        User user = new User(userid, permission, rating, username, name, pass, address, email, dob);
        UserModel.update(user);
        ServletUtils.redirect("/Admin/User/Detail", request, response);
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userid = Integer.parseInt(request.getParameter("userid"));
        UserModel.delete(userid);
        ServletUtils.redirect("/Admin/User/Detail", request, response);
    }


    private void isAvailable (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("user");
        User user = UserModel.findById(1);
        Boolean available;
        if (user == null)
        {
            available = true;
        }
        else {
            available = false;
        }
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        response.setCharacterEncoding("utf-8");

        out.print(available);
        out.flush();
    }
}
