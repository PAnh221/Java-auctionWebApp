<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="watchlistDetails" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>" />
<jsp:useBean id="authUser" scope="session" type="com.ute.auctionwebapp.beans.User"/>

<t:main>
    <jsp:body>
        <div class="card">
            <h4 class="card-header">
                Sản Phẩm Yêu Thích
            </h4>
            <c:choose>
                <c:when test="${watchlistDetails.size() == 0}">
                    <div class="card-body">
                        <p class="card-text">Bạn chưa yêu thích sản phẩm nào.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="card-body">
                        <div class="row">
                            <c:forEach items="${watchlistDetails}" var="c">
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
    </jsp:body>
</t:main>