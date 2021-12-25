package com.ute.auctionwebapp.filters;

import com.ute.auctionwebapp.Utils.ServletUtils;
import com.ute.auctionwebapp.beans.Category;
import com.ute.auctionwebapp.beans.SubCategory;
import com.ute.auctionwebapp.models.CategoryModel;
import com.ute.auctionwebapp.models.SubCategoryModel;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebFilter(filterName = "AuthFilter")
public class AuthFilter implements Filter {
  public void init(FilterConfig config) throws ServletException {
  }

  public void destroy() {
  }

  @Override
  public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws ServletException, IOException {
    HttpServletRequest request = (HttpServletRequest) req;
    HttpSession session = request.getSession();
    boolean auth = (boolean)session.getAttribute("auth");
    if(auth==false){
      ServletUtils.redirect("/Account/Login",request,(HttpServletResponse) res);
      return;
    }


    chain.doFilter(req, res);
  }
}
