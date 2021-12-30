package com.ute.auctionwebapp.controllers;

import java.util.Properties;


//import at.favre.lib.crypto.bcrypt.BCrypt;
import com.ute.auctionwebapp.Utils.ServletUtils;
import com.ute.auctionwebapp.beans.*;
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

@WebServlet(name = "BanServlet", value = "/Ban/*")
public class BanServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServletUtils.redirect("/Home",request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("do duoc post ban");
        request.setCharacterEncoding("UTF-8");
        String path = request.getPathInfo();
        HttpSession session = request.getSession();
        User user = (User)session.getAttribute("authUser");
        if(path.equals("/AddBan")){
            int productID = Integer.parseInt(request.getParameter("proid"));
            String bidderUserName = (String)request.getParameter("bidderusername");
            Product product = ProductModel.findById(productID);
            if(ProductModel.findById(productID) == null || bidderUserName.equals("") || user.getUserID() != ProductModel.findById(productID).getSellerID()) return;
            Ban ban = new Ban(UserModel.findByUsername(bidderUserName).getUserID(), productID);
            BanModel.addBan(ban);
            //mail
            final String username = "caulacbo3qcuhanh@gmail.com";
            final String password = "thanhnha";
            Properties prop = new Properties();
            prop.put("mail.smtp.host", "smtp.gmail.com");
            prop.put("mail.smtp.port", "587");
            prop.put("mail.smtp.auth", "true");
            prop.put("mail.smtp.starttls.enable", "true");
            Session session2 = Session.getInstance(prop, new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });

            String emailTo = UserModel.findByUsername(bidderUserName).getEmail();
            String emailSubject = "Thong bao dau gia khong thanh cong!";
            String content = "Ban da bi kick khoi san pham "+ product.getProName();
            try {
                Message message = new MimeMessage(session2);
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
        }
    }
}