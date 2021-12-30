package com.ute.auctionwebapp.filters;

import com.ute.auctionwebapp.beans.Category;
import com.ute.auctionwebapp.beans.SubCategory;
import com.ute.auctionwebapp.models.CategoryModel;
import com.ute.auctionwebapp.models.SubCategoryModel;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebFilter(filterName = "LayoutFilter", value = "/*")
public class LayoutFilter implements Filter {
  public void init(FilterConfig config) throws ServletException {
  }

  public void destroy() {
  }

  @Override
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
    List<Category> list = CategoryModel.findAll();
    List<SubCategory> listsub = new ArrayList<>();
    request.setAttribute("categoriesWithDetails", list);
    request.setAttribute("subcategoriesWithDetails", listsub);

    chain.doFilter(request, response);
  }
}
