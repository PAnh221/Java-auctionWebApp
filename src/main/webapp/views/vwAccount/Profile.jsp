<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="ListAuctioning" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>"/>
<jsp:useBean id="ListAuctioned" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>"/>
<jsp:useBean id="authUser" scope="session" type="com.ute.auctionwebapp.beans.User"/>


<html>
<head>
    <meta charset="utf-8">
    <title>Profile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Material+Icons" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
    <%--    <link rel="stylesheet" href="./assets/css/test.css">--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/public/css/Profile.css">
</head>

<body>
<jsp:include page="../../views/partials/nav.jsp"/>
<div class="container mt-3">
    <div class="main-body">
        <div class="row">
            <div class="col-lg-4">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex flex-column align-items-center text-center">
                            <img src="https://bootdey.com/img/Content/avatar/avatar6.png" alt="Admin"
                                 class="rounded-circle p-1 bg-primary" width="110">
                            <div class="mt-3">
                                <h4>${authUser.name}</h4>
                                <p class="text-secondary mb-1">${authUser.email}</p>
                                <p class="text-muted font-size-sm">${authUser.address}</p>
                                <c:if test="${authUser.permission == 0}">
                                    <span class="badge badge-success">Bidder</span>
                                </c:if>
                                <c:if test="${authUser.permission == 1}">
                                    <span class="badge badge-info">Seller</span>
                                </c:if>
                            </div>
                        </div>
                        <hr class="my-4">

                    </div>
                    <div class="col-lg-2 mb-3">
                        <div class="card p-3">
                            <div class="e-navlist e-navlist--active-bg">
                                <form id="frmLogout" action="${pageContext.request.contextPath}/Account/Logout"
                                      method="post"></form>
                                <ul class="nav">
                                    <li class="nav-item"><a class="nav-link px-2 active"
                                                            href="${pageContext.request.contextPath}/Home">
                                        <i class="fa fa-home" aria-hidden="true"></i>
                                        <span>Home</span>
                                    </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link px-2" href="javascript:$('#frmLogout').submit()">
                                            <i class="fa fa-sign-out" aria-hidden="true"></i>
                                            <span>Log out</span>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <br>
            <div class="card">
                <h4 class="card-header">
                    Sản Phẩm đang đấu giá của bạn
                </h4>
                <c:choose>
                    <c:when test="${ListAuctioning.size() == 0}">
                        <div class="card-body">
                            <script>
                                function denyPortProduct() {
                                    alert("Vui lòng gửi yêu cầu cho quản trị viên để trở thành Seller trước khi thực hiện thao tác này!")
                                }
                            </script>
                            <c:if test="${authUser.permission == 1}">
                                <p class="card-text">Hiện tại không có sản phẩm nào của bạn đang được đấu giá. <a
                                        href="${pageContext.request.contextPath}/Misc/Upload" style="color: #56baed">Đăng
                                    sản phẩm ngay?</a></p>
                            </c:if>
                            <c:if test="${authUser.permission != 1}">
                                <p class="card-text">Hiện tại không có sản phẩm nào của bạn đang được đấu giá. <a
                                        onclick="alert('Vui lòng gửi yêu cầu cho quản trị viên để trở thành Seller trước khi thực hiện thao tác này!')"
                                        style="color: #56baed">Đăng sản phẩm ngay?</a></p>
                            </c:if>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="card-body">
                            <div class="row">
                                <c:forEach items="${ListAuctioning}" var="c">
                                    <div class="col-sm-3 mb-2">
                                        <div class="card h-100">
                                                <%--                      <img src="${pageContext.request.contextPath}/public/imgs/sp/${c.proID}/main_thumbs.jpg" alt="${c.proName}" title="${c.proName}" class="card-img-top">--%>
                                            <div class="card-body">
                                                <h6 class="card-title">${c.proName}</h6>
                                                <h5 class="card-title text-danger">
                                                    <u><small>đ</small></u><fmt:formatNumber value="${c.bin}"
                                                                                             type="number"/>
                                                </h5>
                                                <p class="font-weight-light mt-3">${c.uploadDate}</p>
                                            </div>
                                            <div class="card-footer text-muted">
                                                <a class="btn btn-sm btn-outline-danger"
                                                   href="${pageContext.request.contextPath}/Product/AddWatchlist?ProID=${c.proID}&UserID=${authUser.userID}"
                                                   role="button">
                                                    <i class="fa fa-heart" aria-hidden="true"></i>
                                                </a>

                                                <a class="btn btn-sm btn-outline-info"
                                                   href="${pageContext.request.contextPath}/Product/Detail?id=${c.proID}"
                                                   role="button">
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
                    Sản Phẩm đã kết thúc đấu giá của bạn
                </h4>
                <c:choose>
                    <c:when test="${ListAuctioned.size() == 0}">
                        <div class="card-body">
                            <p class="card-text">Bạn chưa có sản phẩm đã kết thúc.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="card-body">
                            <div class="row">
                                <c:forEach items="${ListAuctioned}" var="c">
                                    <div class="col-sm-3 mb-2">
                                        <div class="card h-100">
                                                <%--                      <img src="${pageContext.request.contextPath}/public/imgs/sp/${c.proID}/main_thumbs.jpg" alt="${c.proName}" title="${c.proName}" class="card-img-top">--%>
                                            <div class="card-body">
                                                <h6 class="card-title">${c.proName}</h6>
                                                <h5 class="card-title text-danger">
                                                    <u><small>đ</small></u><fmt:formatNumber value="${c.bin}"
                                                                                             type="number"/>
                                                </h5>
                                                <p class="font-weight-light mt-3">${c.uploadDate}</p>
                                            </div>
                                            <div class="card-footer text-muted">
                                                <a class="btn btn-sm btn-outline-danger"
                                                   href="${pageContext.request.contextPath}/Product/AddWatchlist?ProID=${c.proID}&UserID=${authUser.userID}"
                                                   role="button">
                                                    <i class="fa fa-heart" aria-hidden="true"></i>
                                                </a>

                                                <a class="btn btn-sm btn-outline-info"
                                                   href="${pageContext.request.contextPath}/Product/Detail?id=${c.proID}"
                                                   role="button">
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
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
                    integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
                    crossorigin="anonymous"></script>
        </div>
    </div>
</div>

</body>
</html>