package com.ute.auctionwebapp.controllers;


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
import java.math.BigInteger;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet(name = "AdminServlet", value = "/Admin/*")
public class AdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        if (path == null || path.equals("/")) {
            path = "/Index";
        }

        switch (path) {
            case "/Index":
                ServletUtils.forward("/views/vwAdmin/login.jsp", request, response);
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
            case "/Category/IsAvailable":
                int catid = Integer.parseInt(request.getParameter("id"));
                Product checkp = ProductModelAdmin.findByCat(catid);
                Boolean isAvai = (checkp == null);

                PrintWriter out = response.getWriter();
                response.setContentType("application/json");
                response.setCharacterEncoding("utf-8");

                out.print(isAvai);
                out.flush();
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
                List<Category> listCat2 = CategoryModel.findAll();
                if (c2 == null)
                {
                    ServletUtils.forward("/views/vwAdmin/SubCategory/indexSubCat.jsp", request, response);
                }
                else
                {
                    request.setAttribute("categories", listCat2);
                    request.setAttribute("category", c2);
                    ServletUtils.forward("/views/vwAdmin/SubCategory/editSubCat.jsp", request, response);
                }
                break;
            case "/SubCategory/IsAvailable":
                int subcatid = Integer.parseInt(request.getParameter("id"));
                Product checkpr = ProductModelAdmin.findBySubCat(subcatid);
                Boolean isAvailabl = (checkpr == null);

                PrintWriter outt = response.getWriter();
                response.setContentType("application/json");
                response.setCharacterEncoding("utf-8");

                outt.print(isAvailabl);
                outt.flush();
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
            case "/User/UpgradeBidder":
                List<User> listUpgrade = UserModel.findByPermission(0);
                request.setAttribute("users", listUpgrade);
                ServletUtils.forward("/views/vwAdmin/User/indexUser.jsp", request, response);
                break;
            case "/User/Seller":
                List<User> listSeller = UserModel.findByPermission(1);
                request.setAttribute("users", listSeller);
                ServletUtils.forward("/views/vwAdmin/User/indexUser.jsp", request, response);
                break;
            case "/User/Bidder":
                List<User> listBidder = UserModel.findByPermission(2);
                request.setAttribute("users", listBidder);
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
                    ServletUtils.forward("/views/vwAdmin/User/editUser.jsp", request, response);
                }
                break;
            case "/User/Upgrade":
                int useridu = Integer.parseInt(request.getParameter("id"));
                UserModel.upgradeBidder(useridu);
                ServletUtils.redirect("/Admin/User/Detail", request, response);
                break;
            case "/User/Degrade":
                int useridd = Integer.parseInt(request.getParameter("id"));
                UserModel.degradeSeller(useridd);
                ServletUtils.redirect("/Admin/User/Detail", request, response);
                break;

            //              PRODUCT <====================================================================
            case "/Product/Add":
                ServletUtils.forward("/views/vwAdmin/Product/addProduct.jsp", request, response);
                break;
            case "/Product/Detail":
                List<Product> products = ProductModelAdmin.findAll();
                request.setAttribute("products", products);
                ServletUtils.forward("/views/vwAdmin/Product/indexProduct.jsp", request, response);
                break;
            case "/Product/Edit":
                int proid = Integer.parseInt(request.getParameter("id"));
                Product prod = ProductModelAdmin.findById(proid);
                if (prod == null)
                {
                    ServletUtils.forward("/views/vwAdmin/Product/indexProduct.jsp", request, response);
                }
                else
                {
                    request.setAttribute("product", prod);
                    ServletUtils.forward("/views/vwAdmin/Product/editProduct.jsp", request, response);
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
                try {
                    if(username.equals("admin") & pass.equals("admin"))
                    {
                        ServletUtils.redirect("/Admin/Category/Detail", request, response);
                    }
                    else
                    {
                        ServletUtils.redirect("/Admin",request,response);
                    }
                }
                catch (Exception e)
                {
                    ServletUtils.redirect("/Admin",request,response);
                }
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

//                PRODUCT <===========================================================
            case "/Product/Add":
                addProduct(request, response);
                break;
            case "/Product/Update":
                updateProduct(request, response);
                break;
            case "/Product/Delete":
                deleteProduct(request, response);
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
        Product pro = ProductModelAdmin.findByCat(id);
        if (pro != null)
        {
            ServletUtils.redirect("/Admin/Category/Edit?id="+id, request, response);
        }
        else
        {
            CategoryModel.delete(id);
            ServletUtils.redirect("/Admin/Category/Detail", request, response);
        }
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
        Product pro = ProductModelAdmin.findBySubCat(id);
        if (pro != null)
        {
            ServletUtils.redirect("/Admin/SubCategory/Edit?id="+id, request, response);
        }
        else
        {
            SubCategoryModel.delete(id);
            ServletUtils.redirect("/Admin/SubCategory/Detail", request, response);
        }
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
        String bd = request.getParameter("dob")+" 00:00";
        DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
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


    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int imgindex = Integer.parseInt(request.getParameter("imgindex"));
        int catid = Integer.parseInt(request.getParameter("catid"));
        String proname = request.getParameter("proname");
        int bin = Integer.parseInt(request.getParameter("bin"));
        String fulldes = request.getParameter("fulldes");
        String tinydes = request.getParameter("tinydes");
        String bd = request.getParameter("uploaddate")+" 00:00";
        DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        LocalDateTime uploaddate = LocalDateTime.parse(bd, df);
        int sellerid = Integer.parseInt(request.getParameter("sellerid"));
        int subcatid = Integer.parseInt(request.getParameter("subcatid"));
        int proid = Integer.parseInt(request.getParameter("proid"));

        Product prod = new Product(proid, proname, tinydes, fulldes, subcatid, sellerid, catid, imgindex, uploaddate, bin);
        ProductModelAdmin.add(prod);
        ServletUtils.forward("/views/vwAdmin/Product/addProduct.jsp", request, response);
    }
//(ImgIndex, CatID, UploadDate, Bin, FullDes, TinyDes, SellerID, SubCatID, ProName, ProID)
    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int imgindex = Integer.parseInt(request.getParameter("imgindex"));
        int catid = Integer.parseInt(request.getParameter("catid"));
        String proname = request.getParameter("proname");
        int bin = Integer.parseInt(request.getParameter("bin"));
        String fulldes = request.getParameter("fulldes");
        String tinydes = request.getParameter("tinydes");
        String bd = request.getParameter("uploaddate")+" 00:00";
        DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        LocalDateTime uploaddate = LocalDateTime.parse(bd, df);
        int sellerid = Integer.parseInt(request.getParameter("sellerid"));
        int subcatid = Integer.parseInt(request.getParameter("subcatid"));
        int proid = Integer.parseInt(request.getParameter("proid"));

        Product prod = new Product(proid, proname, tinydes, fulldes, subcatid, sellerid, catid, imgindex, uploaddate, bin);
        ProductModelAdmin.update(prod);
        ServletUtils.redirect("/Admin/Product/Detail", request, response);
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int proid = Integer.parseInt(request.getParameter("proid"));
        ProductModelAdmin.delete(proid);
        ServletUtils.redirect("/Admin/Product/Detail", request, response);
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
