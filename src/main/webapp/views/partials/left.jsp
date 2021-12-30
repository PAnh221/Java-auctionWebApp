<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="subcategoriesWithDetails" scope="request"
             type="java.util.List<com.ute.auctionwebapp.beans.SubCategory>"/>
<div class="card" style="width: 15rem;">
    <h5 class="card-header">
        Danh mục con
    </h5>
    <div class="list-group list-group-flush">
        <c:forEach items="${subcategoriesWithDetails}" var="s">
            <a href="${pageContext.request.contextPath}/Product/BySubCat?id=${s.subCatID}"
               class="list-group-item list-group-item-action">
                    ${s.subCatName}
            </a>
        </c:forEach>
    </div>
</div>