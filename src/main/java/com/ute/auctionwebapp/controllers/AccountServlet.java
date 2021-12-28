package com.ute.auctionwebapp.controllers;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.ute.auctionwebapp.Utils.GoogleRecaptcha;
import com.ute.auctionwebapp.Utils.ServletUtils;
import com.ute.auctionwebapp.beans.Product;
import com.ute.auctionwebapp.beans.User;
import com.ute.auctionwebapp.models.ProductModel;
import com.ute.auctionwebapp.models.UserModel;
import org.json.simple.parser.ParseException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;


@WebServlet(name = "AccountServlet", value = "/Account/*")
public class AccountServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();

        HttpSession session = request.getSession();
        String state = String.valueOf(session.getAttribute("auth"));

        switch (path) {
            case "/Register":
                ServletUtils.forward("/views/vwAccount/Register.jsp", request, response);
                break;
            case "/Login":
                ServletUtils.forward("/views/vwAccount/Login.jsp", request, response);
                break;
            case "/ForgetPass":
                ServletUtils.forward("/views/vwAccount/ForgetPass.jsp", request, response);
                break;
            case "/Profile":
                if(state == "false") {
                    ServletUtils.redirect("/Account/Login", request, response);
                    return;
                }
                User user = (User)session.getAttribute("authUser");
                int userID = user.getUserID();
                List<Product> ListAuctioning = ProductModel.findAuctioningBySellerID(userID);
                List<Product> ListAuctioned = ProductModel.findAuctionedBySellerID(userID);
                request.setAttribute("ListAuctioning",ListAuctioning);
                request.setAttribute("ListAuctioned",ListAuctioned);
                ServletUtils.forward("/views/vwAccount/Profile.jsp", request, response);
                break;
            case "/Edit":
                ServletUtils.forward("/views/vwAccount/Edit.jsp", request, response);
                break;
            case "/IsAvailable":
                String txtusername = request.getParameter("user");
                String txtemail = request.getParameter("email");
                User username = UserModel.findByUsername(txtusername);
                User useremail = UserModel.findByEmail(txtemail);
                boolean isAvailable = (username==null)&&(useremail==null);
                PrintWriter out = response.getWriter();
                response.setContentType("application/json");
                response.setCharacterEncoding("utf-8");

                out.print(isAvailable);
                out.flush();
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
            case "/Register":
                boolean verified = false;
                String gRecaptchaReponse = request.getParameter("g-recaptcha-response");
                try {
                    verified = GoogleRecaptcha.isValid(gRecaptchaReponse);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
                registerUser(request, response);
                break;
            case "/Login":
                loginUser(request, response);
                break;
            case "/Logout":
                logoutUser(request, response);
                break;

            case "/Edit":
                editUser(request, response);
                break;

            default:
                ServletUtils.forward("/views/404.jsp", request, response);
                break;
        }
    }

    private void registerUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String rawpass = request.getParameter("rawpass");
        String bcryptHashString = BCrypt.withDefaults().hashToString(12, rawpass.toCharArray());
        String username = request.getParameter("username");
        String name = request.getParameter("fullname");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String Strdob = request.getParameter("dob") + " 00:00";
//        DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        LocalDateTime dob = LocalDateTime.parse(Strdob, df);
        int permission = 0;
        //int rating = 0;
        User c = new User(257,permission,/* rating,*/ username, name, bcryptHashString, address, email, dob);
        UserModel.add(c);
        HttpSession session = request.getSession();
        session.setAttribute("auth", true);
        session.setAttribute("authUser", c);
        ServletUtils.redirect("/Home", request, response);
    }

    private void loginUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("pass");
        User user = UserModel.findByUsername(username);
        if (user != null) {
            BCrypt.Result result = BCrypt.verifyer().verify(password.toCharArray(), user.getPassword());
            if (result.verified) {
                HttpSession session = request.getSession();
                session.setAttribute("auth", true);
                session.setAttribute("authUser", user);
                String url = (String) session.getAttribute("retUrl");
                if(url==null)
                    url = "/Home";
                ServletUtils.redirect(url, request, response);
            } else {
                request.setAttribute("hasError", true);
                request.setAttribute("errorMessage", "Invalid login.");
                ServletUtils.forward("/views/vwAccount/Login.jsp", request, response);
            }
        } else {
            request.setAttribute("hasError", true);
            request.setAttribute("errorMessage", "Invalid login.");
            ServletUtils.forward("/views/vwAccount/Login.jsp", request, response);
        }
    }

    private void logoutUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setAttribute("auth", false);
        session.setAttribute("authUser", new User());
        String url = request.getHeader("referer");
        if (url == null) url = "/Home";
        ServletUtils.redirect(url, request, response);
    }

    private void editUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = UserModel.findByUsername(username);
        if (user != null) {
            BCrypt.Result result = BCrypt.verifyer().verify(password.toCharArray(), user.getPassword());
            if (result.verified) {
                user.setName(request.getParameter("name"));
                user.setEmail(request.getParameter("email"));

//                String rawpass = request.getParameter("rawpass");
                String newPassword = request.getParameter("newpassword");
                String bcryptHashString = BCrypt.withDefaults().hashToString(12, newPassword.toCharArray());
                user.setPassword(bcryptHashString);

                UserModel.editUser(user);

                HttpSession session = request.getSession();
                String url = (String) session.getAttribute("retUrl");
                if (url == null)
                    url = "/Home";
                ServletUtils.redirect(url, request, response);
            } else {
                request.setAttribute("hasError", true);
                request.setAttribute("errorMessage", "Sai mật khẩu");
                ServletUtils.forward("/views/vwAccount/Edit.jsp", request, response);
            }
        } else {
            request.setAttribute("hasError", true);
            request.setAttribute("errorMessage", "Sai mật khẩu");
            ServletUtils.forward("/views/vwAccount/Edit.jsp", request, response);
        }
    }

}

