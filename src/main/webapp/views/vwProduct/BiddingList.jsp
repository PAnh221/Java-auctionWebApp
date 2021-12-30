<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="biddingProductDetails" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>" />
<jsp:useBean id="winProductDetails" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>" />
<jsp:useBean id="authUser" scope="session" type="com.ute.auctionwebapp.beans.User"/>

<t:main>
    <jsp:body>
        <div class="card">
            <h4 class="card-header">
                Sản Phẩm Bạn Tham Gia Đang Đấu Giá
            </h4>
            <c:choose>
                <c:when test="${biddingProductDetails.size() == 0}">
                    <div class="card-body">
                        <p class="card-text">Bạn đang không tham gia đấu giá sản phẩm nào.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="card-body">
                        <div class="row">
                            <c:forEach items="${biddingProductDetails}" var="c">
                                <div class="col-sm-3 mb-2">
                                    <div class="card h-100">
                                            <%--                      <img src="${pageContext.request.contextPath}/public/imgs/sp/${c.proID}/main_thumbs.jpg" alt="${c.proName}" title="${c.proName}" class="card-img-top">--%>
                                        <div class="card-body">
                                            <h6 class="card-title">${c.proName}</h6>
                                            <h5 class="card-title text-danger">
                                                <u><small>đ</small></u><fmt:formatNumber value="${c.bin}" type="number" />
                                            </h5>
                                            <p class="font-weight-light mt-3">${c.uploadDate}</p>
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
        <br><br>
        <div class="card">
            <h4 class="card-header">
                Sản Phẩm Bạn Đã Thắng Đấu Giá
            </h4>
            <c:choose>
                <c:when test="${winProductDetails.size() == 0}">
                    <div class="card-body">
                        <p class="card-text">Bạn chưa thắng đấu giá sản phẩm nào.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="card-body">
                        <div class="row">
                            <c:forEach items="${winProductDetails}" var="c">
                                <div class="col-sm-3 mb-2">
                                    <div class="card h-100">
                                            <%--                      <img src="${pageContext.request.contextPath}/public/imgs/sp/${c.proID}/main_thumbs.jpg" alt="${c.proName}" title="${c.proName}" class="card-img-top">--%>
                                        <div class="card-body">
                                            <h6 class="card-title">${c.proName}</h6>
                                            <h5 class="card-title text-danger">
                                                <u><small>đ</small></u><fmt:formatNumber value="${c.bin}" type="number" />
                                            </h5>
                                            <p class="font-weight-light mt-3">${c.uploadDate}</p>
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
    </jsp:body>
</t:main>