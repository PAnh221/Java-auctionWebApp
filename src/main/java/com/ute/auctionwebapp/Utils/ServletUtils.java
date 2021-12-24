package com.ute.auctionwebapp.Utils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ServletUtils {
    public static void forward(String url, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);
    }

    public static void redirect(String url, HttpServletRequest request, HttpServletResponse response) throws IOException {
        String contextpath = request.getContextPath();
        int idx = url.indexOf(contextpath);
        if(idx < 0){
            response.sendRedirect(request.getContextPath() + url);
        }
        else{
            response.sendRedirect(url);
        }
    }
}
