<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="categoriesWithDetails" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Category>"/>
<jsp:useBean id="subcategoriesWithDetails" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.SubCategory>"/>

<div class="card" style="width: 15rem;">
  <h4 class="card-header">
    Categories
  </h4>
  <div class="list-group list-group-flush">
    <c:forEach items="${categoriesWithDetails}" var="c">
      <a href="${pageContext.request.contextPath}/Product/ByCat?id=${c.catID}" class="list-group-item list-group-item-action">
<%--        <i class="fa fa-caret-right" aria-hidden="true"></i>--%>
        ${c.catName}
      </a>
    </c:forEach>

  </div>
</div>

<div class="card mt-2" style="width: 15rem;">
  <h4 class="card-header">
    SubCategories
  </h4>
  <div class="list-group list-group-flush">
    <c:forEach items="${subcategoriesWithDetails}" var="s">
      <a href="${pageContext.request.contextPath}/Product/BySubCat?id=${s.subCatID}" class="list-group-item list-group-item-action">
          <%--        <i class="fa fa-caret-right" aria-hidden="true"></i>--%>
          ${s.subCatName}
      </a>
    </c:forEach>

  </div>
</div>