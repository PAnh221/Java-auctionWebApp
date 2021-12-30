<%--
  Created by IntelliJ IDEA.
  User: doanh
  Date: 12/30/2021
  Time: 5:07 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="listRating" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Rating>" />
<jsp:useBean id="authUser" scope="session" type="com.ute.auctionwebapp.beans.User"/>
<jsp:useBean id="user" scope="request" type="com.ute.auctionwebapp.beans.User"/>
<jsp:useBean id="reputation" scope="request" type="java.lang.Float"/>


<html>
<head>
    <meta charset="utf-8">
    <title>Rating Detail</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Material+Icons" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
    <%--    <link rel="stylesheet" href="./assets/css/test.css">--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/public/css/Profile.css"></head>
<body>
<jsp:include page="../../views/partials/nav.jsp" />
<br><br>
<div class="container mt-3">
    <div class="main-body">
        <div class="row">
            <div class="col-lg-3">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex flex-column align-items-center text-center">
                            <img src="https://bootdey.com/img/Content/avatar/avatar6.png" alt="Admin"
                                 class="rounded-circle p-1 bg-primary mt-4" width="110">
                            <div class="mt-3">
                                <h4>${user.userName}</h4>
                                <c:if test="${user.permission == 0}">
                                    <span class="badge badge-success">Bidder</span>
                                </c:if>
                                <c:if test="${user.permission == 1}">
                                    <span class="badge badge-info">Seller</span>
                                </c:if>
                                <h5 class="mt-3">Uy tín: ${reputation}%</h5>
                            </div>
                        </div>
                        <hr class="my-4">
                    </div>
                </div>
            </div>
            <div class="col-lg-9">
                <c:choose>
                    <c:when test="${listRating.size() == 0}">
                        <div class="card">
                            <div class="card-body d-flex flex-column align-items-center text-center">
                                <h3>Người dùng chưa từng được đánh giá.</h3>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${listRating}" var="r">
                            <div class="card mb-4">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-lg-3">
                                            <c:choose>
                                                <c:when test="${r.vote>0}">
                                                    <div class="row mb-1 d-flex justify-content-center mt-3">
                                                        <figure style="max-width: 60px; max-height: 60px"><img src="${pageContext.request.contextPath}/public/imgs/icon/like-button.png" style="width: 100%"></figure>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="row mb-1 d-flex justify-content-center mt-3">
                                                        <figure style="max-width: 60px; max-height: 60px"><img src="${pageContext.request.contextPath}/public/imgs/icon/dislike-button.png" style="width: 100%"></figure>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                            <div class="row mb-3 text-secondary d-flex justify-content-center">
                                                <h6 class="mb-0">${r.ratingName}</h6>
                                            </div>
                                        </div>
                                        <div class="col-lg-8 d-flex justify-content-center align-self-center">
                                            <i><h5 class="mb-0">"${r.feedBack}"</h5></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>
</body>
</html>
