<%--
  Created by IntelliJ IDEA.
  User: Admins
  Date: 24-Dec-21
  Time: 7:57 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%--Top 5 sản phẩm gần kết thúc đấu giá--%>
<jsp:useBean id="top5_1" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>" />

<%--Top 5 sản phẩm nhiều lượt ra giá nhất--%>
<jsp:useBean id="top5_2" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>" />

<%--Top 5 sản phẩm giá cao nhất--%>
<jsp:useBean id="top5_3" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>" />

<jsp:useBean id="authUser" scope="session" type="com.ute.auctionwebapp.beans.User"/>

<t:main>
    <jsp:body>
        <div class="card">
            <h4 class="card-header">
                Top 5 sản phẩm sắp kết thúc đấu giá
            </h4>
            <c:choose>
                <c:when test="${top5_1.size() == 0}">
                    <div class="card-body">
                        <p class="card-text">Không có dữ liệu.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="card-body">
                        <div class="row">
                            <c:forEach items="${top5_1}" var="c">
                                <div class="col-sm-3 mb-2">
                                    <div class="card h-100">
                                            <%--                      <img src="${pageContext.request.contextPath}/public/imgs/sp/${c.proID}/main_thumbs.jpg" alt="${c.proName}" title="${c.proName}" class="card-img-top">--%>
                                        <div class="card-body">
                                            <h6 class="card-title">${c.proName}</h6>
                                            <h5 class="card-title text-danger">
                                                <u><small>đ</small></u><fmt:formatNumber value="${c.currentPrice}" type="number" />
                                            </h5>
                                            <c:if test="${c.currentBidderUsername != null}">
                                                <p class="font-weight-light mt-3">Người giữ: <i>${c.currentBidderUsername}</i></p>
                                            </c:if>
                                            <p class="font-weight-light mt-3">Ngày đăng: <i>${c.uploadDate}</i></p>
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
        <br>
        <div class="card">
            <h4 class="card-header">
                Top 5 sản phẩm hot nhất
            </h4>
            <c:choose>
                <c:when test="${top5_2.size() == 0}">
                    <div class="card-body">
                        <p class="card-text">Không có dữ liệu.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="card-body">
                        <div class="row">
                            <c:forEach items="${top5_2}" var="c">
                                <div class="col-sm-3 mb-2">
                                    <div class="card h-100">
                                            <%--                      <img src="${pageContext.request.contextPath}/public/imgs/sp/${c.proID}/main_thumbs.jpg" alt="${c.proName}" title="${c.proName}" class="card-img-top">--%>
                                        <div class="card-body">
                                            <h6 class="card-title">${c.proName}</h6>
                                            <h5 class="card-title text-danger">
                                                <u><small>đ</small></u><fmt:formatNumber value="${c.currentPrice}" type="number" />
                                            </h5>
                                            <c:if test="${c.currentBidderUsername != null}">
                                                <p class="font-weight-light mt-3">Người giữ: <i>${c.currentBidderUsername}</i></p>
                                            </c:if>
                                            <p class="font-weight-light mt-3">Ngày đăng: <i>${c.uploadDate}</i></p>
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
        <br>
        <div class="card">
            <h4 class="card-header">
                Top 5 sản phẩm giá cao nhất
            </h4>
            <c:choose>
                <c:when test="${top5_3.size() == 0}">
                    <div class="card-body">
                        <p class="card-text">Không có dữ liệu.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="card-body">
                        <div class="row">
                            <c:forEach items="${top5_3}" var="c">
                                <div class="col-sm-3 mb-2">
                                    <div class="card h-100">
                                            <%--                      <img src="${pageContext.request.contextPath}/public/imgs/sp/${c.proID}/main_thumbs.jpg" alt="${c.proName}" title="${c.proName}" class="card-img-top">--%>
                                        <div class="card-body">
                                            <h6 class="card-title">${c.proName}</h6>
                                            <h5 class="card-title text-danger">
                                                <u><small>đ</small></u><fmt:formatNumber value="${c.currentPrice}" type="number" />
                                            </h5>
                                            <c:if test="${c.currentBidderUsername != null}">
                                                <p class="font-weight-light mt-3">Người giữ: <i>${c.currentBidderUsername}</i></p>
                                            </c:if>
                                            <p class="font-weight-light mt-3">Ngày đăng: <i>${c.uploadDate}</i></p>
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
        <br>
    </jsp:body>
</t:main>
