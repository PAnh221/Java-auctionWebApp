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
                <div class="form-group blue-border-focus w-80 h-50">
                    <textarea style="font-size: 24px" class="form-control p-10 d-flex justify-content-center align-items-center text-center h-100" id="exampleFormControlTextarea5" rows="3"></textarea>
                </div>
                <div class="d-flex align-items-center justify-content-center text-center mt-4">
                    <div class="col-lg-2 d-flex justify-content-end mt-3">
                        <figure style="max-width: 60px; max-height: 60px" onclick="document.getElementById('likeImg').src='/auctionWebApp_war/public/imgs/icon/like-button.png';document.getElementById('dislikeImg').src='/auctionWebApp_war/public/imgs/icon/dislike-disable-button.png';"><img src="${pageContext.request.contextPath}/public/imgs/icon/like-button.png" style="width: 100%" id="likeImg" alt=""></figure>
                    </div>

                    <div class="col-lg-2 d-flex justify-content-start mt-3">
                        <figure style="max-width: 60px; max-height: 60px" onclick="document.getElementById('likeImg').src='/auctionWebApp_war/public/imgs/icon/like-disable-button.png';document.getElementById('dislikeImg').src='/auctionWebApp_war/public/imgs/icon/dislike-button.png';"><img src="${pageContext.request.contextPath}/public/imgs/icon/dislike-disable-button.png" style="width: 100%" id="dislikeImg" alt=""></figure>
                    </div>

                    <button type="submit" class="col-lg-2 btn btn-primary btn-lg">
                        <i class="fa fa-check" aria-hidden="true"></i>Rate
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
