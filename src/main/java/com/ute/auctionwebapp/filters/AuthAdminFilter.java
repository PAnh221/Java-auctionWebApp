package com.ute.auctionwebapp.filters;

import com.ute.auctionwebapp.Utils.ServletUtils;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "AuthAdminFilter")
public class AuthAdminFilter implements Filter {
  public void init(FilterConfig config) throws ServletException {
  }

  public void destroy() {
  }

  @Override
  public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws ServletException, IOException {
    HttpServletRequest request = (HttpServletRequest) req;
    HttpSession session = request.getSession();
    boolean authAdmin = (boolean)session.getAttribute("authAdmin");
    if(authAdmin==false){
      session.setAttribute("retUrl", request.getRequestURI());
      ServletUtils.redirect("/Admin/Login", request, (HttpServletResponse) res);
      return;
    }


    chain.doFilter(req, res);
  }
}
