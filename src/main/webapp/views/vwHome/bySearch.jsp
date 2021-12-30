<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="listSearchProduct" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>"/>
<jsp:useBean id="authUser" scope="session" type="com.ute.auctionwebapp.beans.User"/>
<t:main>
    <jsp:body>
        <div class="card">
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item">
                            <div class="nav-link" href="#" style="color: #0d0d0d" disabled><h5>Tìm kiếm theo từ
                                khóa ${keyword}</h5></div>
                        </li>
                    </ul>
                </div>
                <span class="navbar-text mr-3">Order by: </span>
                <div class="dropdown">
                    <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                       data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            ${order_by}
                    </a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuLink">
                        <a class="dropdown-item"
                           href="${pageContext.request.contextPath}/Home/bySearch?search_input=${keyword}&type_order=New Post">New
                            Post</a>
                        <a class="dropdown-item"
                           href="${pageContext.request.contextPath}/Home/bySearch?search_input=${keyword}&type_order=Almost Over">Almost
                            Over</a>
                        <a class="dropdown-item"
                           href="${pageContext.request.contextPath}/Home/bySearch?search_input=${keyword}&type_order=Price:Low to High">Price:
                            Low to High</a>
                        <a class="dropdown-item"
                           href="${pageContext.request.contextPath}/Home/bySearch?search_input=${keyword}&type_order=Price:High to Low">Price:
                            High to Low</a>
                    </div>
                </div>
            </nav>
            <c:choose>
                <c:when test="${listSearchProduct.size() == 0}">
                    <div class="card-body">
                        <p class="card-text">Không có dữ liệu.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="card-body">
                        <div class="row">
                            <c:forEach items="${listSearchProduct}" var="c">
                                <div class="col-sm-3 mb-2">
                                    <div class="card h-100">
                                        <img src="${pageContext.request.contextPath}/public/imgs/sp/${c.imgIndex}/${c.imgIndex}_main.png" alt="${c.proName}" title="${c.proName}" class="card-img-top" style="width: 280px;height: 280px;">
                                                <div class="card-body">
                                                    <h6 class="card-title">${c.proName}</h6>
                                                    <h5 class="card-title text-danger">
                                                        <u><small>đ</small></u><fmt:formatNumber value="${c.currentPrice}" type="number" />
                                                    </h5>
                                                    <c:if test="${c.currentBidderUsername != null}">
                                                        <p class="font-weight-light mt-3">Người giữ: <i>${c.currentBidderUsername}</i></p>
                                                    </c:if>
                                                    <p class="font-weight-light mt-3">Ngày đăng: <i>${c.uploadDate}</i></p>
                                                    <p class="font-weight-light mt-3">Ngày kết thúc: <i>${c.endDate}</i></p>
                                                </div>
                                                <div class="card-footer text-muted">
                                                    <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/Product/AddWatchlist?ProID=${c.proID}&UserID=${authUser.userID}" role="button">
                                                        <i class="fa fa-heart" aria-hidden="true"></i>
                                                    </a>

                                                    <a class="btn btn-sm btn-outline-info" href="${pageContext.request.contextPath}/Product/Detail?id=${c.proID}" role="button">
                                                            <%--                        <i class="fa fa-eye" aria-hidden="true"></i>--%>
                                                        Chi tiết sản phẩm
                                                    </a>
                                                </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <c:choose>
            <c:when test="${total_page != 0}">
                <nav aria-label="Page navigation example">
                    <ul class="pagination">
                        <c:choose>
                            <c:when test="${current_page!=1}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/Home/bySearch?search_input=${keyword}&type_order=${order_by}&current_page=${current_page-1}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                        <span class="sr-only">Previous</span>
                                    </a>
                                </li>
                            </c:when>
                        </c:choose>
                        <c:forEach var = "i" begin = "1" end = "${total_page}">
                            <c:choose>
                                <c:when test="${current_page==i}">
                                    <li class="page-item active" ><a class="page-link" href="">
                                        ${i}<span class="sr-only">(current)</span>
                                    </a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/Home/bySearch?search_input=${keyword}&type_order=${order_by}&current_page=${i}">
                                            ${i}
                                    </a></li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <c:choose>
                            <c:when test="${current_page!=total_page}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/Home/bySearch?search_input=${keyword}&type_order=${order_by}&current_page=${current_page+1}" aria-label="Previous">
                                        <span aria-hidden="true">&raquo;</span>
                                        <span class="sr-only">Previous</span>
                                    </a>
                                </li>
                            </c:when>
                        </c:choose>
                    </ul>
                </nav>
            </c:when>
        </c:choose>
    </jsp:body>
</t:main>