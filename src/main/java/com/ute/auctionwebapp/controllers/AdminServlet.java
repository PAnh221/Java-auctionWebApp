package com.ute.auctionwebapp.controllers;

import java.util.Properties;


//import at.favre.lib.crypto.bcrypt.BCrypt;
import at.favre.lib.crypto.bcrypt.BCrypt;
import com.ute.auctionwebapp.Utils.ServletUtils;
import com.ute.auctionwebapp.beans.Category;
import com.ute.auctionwebapp.beans.Product;
import com.ute.auctionwebapp.beans.SubCategory;
import com.ute.auctionwebapp.beans.User;
import com.ute.auctionwebapp.models.*;


import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
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

@WebServlet(name = "AdminServlet", value = "/Admin/*")
public class AdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String path = request.getPathInfo();
        if (path == null || path.equals("/")) {
            path = "/Login";
        }
        HttpSession session = request.getSession();
        String state = String.valueOf(session.getAttribute("authAdmin"));

        switch (path) {
            case "/Login":
                ServletUtils.forward("/views/vwAdmin/login.jsp", request, response);
                break;
            case "/Logout":
                session.setAttribute("authAdmin", false);
                ServletUtils.redirect("/Admin/Login",request,response);
                break;
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
                Product checkp = ProductModelAdmin.checkCat(catid);
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
            case "/User/UpgradeSeller":
                List<User> listUpgrade = UserModel.findUserUpgrade();
                if (listUpgrade == null)
                {
                    request.setAttribute("users", null);
                    ServletUtils.forward("/views/vwAdmin/User/indexNoneUpgradeUser.jsp", request, response);
                }
                request.setAttribute("users", listUpgrade);
                ServletUtils.forward("/views/vwAdmin/User/indexUpgradeUser.jsp", request, response);
                break;
            case "/User/Seller":
                List<User> listSeller = UserModel.findByPermission(1);
                request.setAttribute("users", listSeller);
                ServletUtils.forward("/views/vwAdmin/User/indexUser.jsp", request, response);
                break;
            case "/User/Bidder":
                List<User> listBidder = UserModel.findByPermission(0);
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
            case "/User/DenyUpgrade":
                int useridi = Integer.parseInt(request.getParameter("id"));
                RequestModel.delete(useridi);
                ServletUtils.redirect("/Admin/User/Detail", request, response);
                break;
            case "/User/Upgrade":
                int useridu = Integer.parseInt(request.getParameter("id"));
                UserModel.upgradeBidder(useridu);
                RequestModel.delete(useridu);
                ServletUtils.redirect("/Admin/User/Detail", request, response);
                break;
            case "/User/Degrade":
                int useridd = Integer.parseInt(request.getParameter("id"));
                UserModel.degradeSeller(useridd);
                ServletUtils.redirect("/Admin/User/Detail", request, response);
                break;
            case "/User/SendMail":
                sendMail(request, response);
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
                List<Category> pro_listCat = CategoryModel.findAll();
                List<SubCategory> pro_listSub = SubCategoryModel.findAll();
                List<User> pro_listUser = UserModel.findAll();
                if (prod == null)
                {
                    ServletUtils.forward("/views/vwAdmin/Product/indexProduct.jsp", request, response);
                }
                else
                {
                    request.setAttribute("categories", pro_listCat);
                    request.setAttribute("subcategories", pro_listSub);
                    request.setAttribute("users", pro_listUser);
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
        request.setCharacterEncoding("UTF-8");
        String path = request.getPathInfo();
        if (path == null || path.equals("/")) {
            path = "/Login";
        }

        switch (path) {
            case "/Login":
                String username = request.getParameter("user");
                String pass = request.getParameter("pass");
                try {
                    if(username.equals("admin") & pass.equals("admin"))
                    {
                        HttpSession session = request.getSession();
                        session.setAttribute("authAdmin", true);
                        ServletUtils.redirect("/Admin/Category/Detail", request, response);
                    }
                    else
                    {
                        HttpSession session = request.getSession();
                        session.setAttribute("authAdmin", false);
                        ServletUtils.redirect("/Admin/Login",request,response);
                    }
                }
                catch (Exception e)
                {
                    ServletUtils.redirect("/Admin",request,response);
                }
                break;
            case "/Logout":
                HttpSession session = request.getSession();
                session.setAttribute("authAdmin", false);
                ServletUtils.redirect("/Admin/Login",request,response);
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
            case "/User/IsAvailable":
                isAvailable(request, response);
                break;
            case "/User/Update":
                updateUser(request, response);
                break;
            case "/User/Delete":
                deleteUser(request, response);
                break;
            case "/User/SendMail":
                sendMail(request, response);
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
//        int catid = Integer.parseInt(request.getParameter("catid"));
        String catname = request.getParameter("catname");

        Category c = new Category(catname);
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
        Product pro = ProductModelAdmin.checkCat(id);
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
//        int userid = Integer.parseInt(request.getParameter("userid"));
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
        //int rating = Integer.parseInt(request.getParameter("rating"));

        User user = new User(1, permission,/* rating,*/ username, name, pass, address, email, dob);
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
        int permission = Integer.parseInt(request.getParameter("permission"));
        try {
            String year = request.getParameter("dob").substring(0,4);
            String month = request.getParameter("dob").substring(5,7);
            String day = request.getParameter("dob").substring(8,10);

            String bd = day+"/"+month+ "/"+ year +" 00:00";
            DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
            LocalDateTime dob = LocalDateTime.parse(bd, df);
            User user = new User(userid, permission,/* rating,*/ username, name, pass, address, email, dob);
            UserModel.update(user);
            ServletUtils.redirect("/Admin/User/Detail", request, response);
        }
        catch (Exception e)
        {
            String bd = request.getParameter("dob")+" 00:00";
            DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
            LocalDateTime dob = LocalDateTime.parse(bd, df);
            User user = new User(userid, permission,/* rating,*/ username, name, pass, address, email, dob);
            UserModel.update(user);
            ServletUtils.redirect("/Admin/User/Detail", request, response);
        }

        //int rating = Integer.parseInt(request.getParameter("rating"));
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userid = Integer.parseInt(request.getParameter("userid"));
        UserModel.delete(userid);
        ServletUtils.redirect("/Admin/User/Detail", request, response);
    }


    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int imgindex = Integer.parseInt(request.getParameter("imgindex"));
        String proname = request.getParameter("proname");
        int bin = Integer.parseInt(request.getParameter("bin"));
        int startprice = Integer.parseInt(request.getParameter("startprice"));
        int stepprice = Integer.parseInt(request.getParameter("stepprice"));
        String fulldes = request.getParameter("fulldes");
        String tinydes = request.getParameter("tinydes");
        String bd = request.getParameter("uploaddate")+" 00:00";
        DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        LocalDateTime uploaddate = LocalDateTime.parse(bd, df);
        int sellerid = Integer.parseInt(request.getParameter("sellerid"));
        int subcatid = Integer.parseInt(request.getParameter("subcatid"));
//        int proid = Integer.parseInt(request.getParameter("proid"));

        Product prod = new Product(1, proname, tinydes, fulldes, subcatid, sellerid, imgindex, uploaddate, bin, startprice, stepprice, 0);
        ProductModelAdmin.add(prod);
        ServletUtils.forward("/views/vwAdmin/Product/addProduct.jsp", request, response);
    }
//(ImgIndex, CatID, UploadDate, Bin, FullDes, TinyDes, SellerID, SubCatID, ProName, ProID)
    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int imgindex = Integer.parseInt(request.getParameter("imgindex"));
        String proname = request.getParameter("proname");
        int bin = Integer.parseInt(request.getParameter("bin"));

        String fulldes = request.getParameter("fulldes");
        String tinydes = request.getParameter("tinydes");
//      LocalDate.now() //?????nh d???ng l?? dd/MM/yyyy th?? db m???i nh???n
        String bd = LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy"))+" 00:00";
        DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        LocalDateTime uploaddate = LocalDateTime.parse(bd, df);
        int sellerid = Integer.parseInt(request.getParameter("sellerid"));
        int subcatid = Integer.parseInt(request.getParameter("subcatid"));
        int proid = Integer.parseInt(request.getParameter("proid"));

        //V?? th??m sau kh?? s???a database
        int startprice = Integer.parseInt(request.getParameter("startprice"));
        int stepprice = Integer.parseInt(request.getParameter("stepprice"));
        int status = Integer.parseInt(request.getParameter("status"));

        Product prod = new Product(proid, proname, tinydes, fulldes, subcatid, sellerid, imgindex, uploaddate, bin, startprice, stepprice, status);
        ProductModelAdmin.update(prod);
        ServletUtils.redirect("/Admin/Product/Detail", request, response);
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int proid = Integer.parseInt(request.getParameter("proid"));
        BidModel.deletePro(proid);
        WatchlistModel.deleteProduct(proid);
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

    private void sendMail (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //reset m???t kh???u
        String newpass = "123456";
        String bcryptHashString = BCrypt.withDefaults().hashToString(12, newpass.toCharArray());
        int userid = Integer.parseInt(request.getParameter("id"));
        UserModel.editPass(userid, bcryptHashString);

        //mail
        final String username = "caulacbo3qcuhanh@gmail.com";
        final String password = "thanhnha";
        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true");
        Session session = Session.getInstance(prop, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        String emailTo = request.getParameter("email");
        String emailSubject = "Reset Password";
        String content = "New Password is 123456";
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(emailTo)
            );
            message.setSubject(emailSubject);
            message.setText(content);

            // sends the e-mail
            Transport.send(message);
            System.out.println("send done!");
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        ServletUtils.redirect("/Admin/User/Detail", request, response);
    }

}
