<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="ListAuctioning" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>"/>
<jsp:useBean id="ListAuctioned" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>"/>
<jsp:useBean id="authUser" scope="session" type="com.ute.auctionwebapp.beans.User"/>
<jsp:useBean id="reputation" scope="request" type="java.lang.Float"/>


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
<jsp:include page="../../views/partials/nav.jsp" />
<br>
<div class="container mt-3">
    <div class="main-body">
        <div class="row">
            <div class="col-lg-4">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex flex-column align-items-center text-center">
                            <img src="https://bootdey.com/img/Content/avatar/avatar6.png" alt="Admin"
                                 class="rounded-circle p-1 bg-primary mt-4" width="110">
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
                                <a href="${pageContext.request.contextPath}/Rating/Detail?Username=${authUser.userName}"><h5 class="mt-3">Uy tín: ${reputation}%</h5></a>
                            </div>
                        </div>
                        <hr class="my-4">
<%--                        <ul class="list-group list-group-flush">--%>
<%--                            <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">--%>
<%--                                <h6 class="mb-0"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"--%>
<%--                                                      fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"--%>
<%--                                                      class="feather feather-globe me-2 icon-inline">--%>
<%--                                    <circle cx="12" cy="12" r="10"></circle>--%>
<%--                                    <line x1="2" y1="12" x2="22" y2="12"></line>--%>
<%--                                    <path--%>
<%--                                            d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z">--%>
<%--                                    </path>--%>
<%--                                </svg>Website</h6>--%>
<%--                                <span class="text-secondary">https://bootdey.com</span>--%>
<%--                            </li>--%>
<%--                            <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">--%>
<%--                                <h6 class="mb-0"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"--%>
<%--                                                      fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"--%>
<%--                                                      class="feather feather-github me-2 icon-inline">--%>
<%--                                    <path--%>
<%--                                            d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22">--%>
<%--                                    </path>--%>
<%--                                </svg>Github</h6>--%>
<%--                                <span class="text-secondary">bootdey</span>--%>
<%--                            </li>--%>
<%--                            <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">--%>
<%--                                <h6 class="mb-0"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"--%>
<%--                                                      fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"--%>
<%--                                                      class="feather feather-twitter me-2 icon-inline text-info">--%>
<%--                                    <path--%>
<%--                                            d="M23 3a10.9 10.9 0 0 1-3.14 1.53 4.48 4.48 0 0 0-7.86 3v1A10.66 10.66 0 0 1 3 4s-4 9 5 13a11.64 11.64 0 0 1-7 2c9 5 20 0 20-11.5a4.5 4.5 0 0 0-.08-.83A7.72 7.72 0 0 0 23 3z">--%>
<%--                                    </path>--%>
<%--                                </svg>Twitter</h6>--%>
<%--                                <span class="text-secondary">@bootdey</span>--%>
<%--                            </li>--%>
<%--                            <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">--%>
<%--                                <h6 class="mb-0"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"--%>
<%--                                                      fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"--%>
<%--                                                      class="feather feather-instagram me-2 icon-inline text-danger">--%>
<%--                                    <rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect>--%>
<%--                                    <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path>--%>
<%--                                    <line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line>--%>
<%--                                </svg>Instagram</h6>--%>
<%--                                <span class="text-secondary">bootdey</span>--%>
<%--                            </li>--%>
<%--                            <li class="list-group-item d-flex justify-content-between align-items-center flex-wrap">--%>
<%--                                <h6 class="mb-0"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"--%>
<%--                                                      fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"--%>
<%--                                                      class="feather feather-facebook me-2 icon-inline text-primary">--%>
<%--                                    <path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z">--%>
<%--                                    </path>--%>
<%--                                </svg>Facebook</h6>--%>
<%--                                <span class="text-secondary">bootdey</span>--%>
<%--                            </li>--%>
<%--                        </ul>--%>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="card">
                    <div class="card-body">
                        <div class="row mb-3">
                            <div class="col-sm-3">
                                <h6 class="mb-0">Full Name</h6>
                            </div>
                            <div class="col-sm-9 text-secondary">
                                <input type="text" class="form-control" value="${authUser.name}" Edit="0" disabled>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-sm-3">
                                <h6 class="mb-0">Email</h6>
                            </div>
                            <div class="col-sm-9 text-secondary">
                                <input type="text" class="form-control" value="${authUser.email}" disabled>
                            </div>
                        </div>
<%--                        <div class="row mb-3">--%>
<%--                            <div class="col-sm-3">--%>
<%--                                <h6 class="mb-0">Phone</h6>--%>
<%--                            </div>--%>
<%--                            <div class="col-sm-9 text-secondary">--%>
<%--                                <input type="text" class="form-control" value="(239) 816-9029" disabled>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="row mb-3">--%>
<%--                            <div class="col-sm-3">--%>
<%--                                <h6 class="mb-0">Mobile</h6>--%>
<%--                            </div>--%>
<%--                            <div class="col-sm-9 text-secondary">--%>
<%--                                <input type="text" class="form-control" value="(320) 380-4539" disabled>--%>
<%--                            </div>--%>
<%--                        </div>--%>
                        <div class="row mb-3">
                            <div class="col-sm-3">
                                <h6 class="mb-0">Address</h6>
                            </div>
                            <div class="col-sm-9 text-secondary">
                                <input type="text" class="form-control" value="${authUser.address}" disabled>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-3"></div>
                            <div class="col-sm-9 text-secondary">
                                <a href="${pageContext.request.contextPath}/Account/Edit"><input type="button" class="btn btn-primary px-4"
                                                                                 value="Edit"></a>
                            </div>
                        </div>
                    </div>
                </div>
<%--                <div class="row">--%>
<%--                    <div class="col-sm-12">--%>
<%--                        <div class="card">--%>
<%--                            <div class="card-body">--%>
<%--                                <h5 class="d-flex align-items-center mb-3">--%>
<%--                    <span class="material-icons text-info mr-2">--%>
<%--                      history--%>
<%--                    </span>--%>
<%--                                    History--%>
<%--                                </h5>--%>
<%--                                <p>Web Design</p>--%>
<%--                                <div class="progress mb-3" style="height: 5px">--%>
<%--                                    <div class="progress-bar bg-primary" role="progressbar" style="width: 80%" aria-valuenow="80"--%>
<%--                                         aria-valuemin="0" aria-valuemax="100"></div>--%>
<%--                                </div>--%>
<%--                                <p>Website Markup</p>--%>
<%--                                <div class="progress mb-3" style="height: 5px">--%>
<%--                                    <div class="progress-bar bg-danger" role="progressbar" style="width: 72%" aria-valuenow="72"--%>
<%--                                         aria-valuemin="0" aria-valuemax="100"></div>--%>
<%--                                </div>--%>
<%--                                <p>One Page</p>--%>
<%--                                <div class="progress mb-3" style="height: 5px">--%>
<%--                                    <div class="progress-bar bg-success" role="progressbar" style="width: 89%" aria-valuenow="89"--%>
<%--                                         aria-valuemin="0" aria-valuemax="100"></div>--%>
<%--                                </div>--%>
<%--                                <p>Mobile Template</p>--%>
<%--                                <div class="progress mb-3" style="height: 5px">--%>
<%--                                    <div class="progress-bar bg-warning" role="progressbar" style="width: 55%" aria-valuenow="55"--%>
<%--                                         aria-valuemin="0" aria-valuemax="100"></div>--%>
<%--                                </div>--%>
<%--                                <p>Backend API</p>--%>
<%--                                <div class="progress" style="height: 5px">--%>
<%--                                    <div class="progress-bar bg-info" role="progressbar" style="width: 66%" aria-valuenow="66"--%>
<%--                                         aria-valuemin="0" aria-valuemax="100"></div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
            </div>
            <div class="col-lg-2 mb-3">
                <div class="card p-3">
                    <div class="e-navlist e-navlist--active-bg">
                        <form id="frmLogout" action="${pageContext.request.contextPath}/Account/Logout" method="post"></form>
                        <ul class="nav">
                            <li class="nav-item"><a class="nav-link px-2 active" href="${pageContext.request.contextPath}/Home">
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
                        function denyPortProduct(){
                            alert("Vui lòng gửi yêu cầu cho quản trị viên để trở thành Seller trước khi thực hiện thao tác này!")
                        }
                    </script>
                    <c:if test="${authUser.permission == 1}">
                        <p class="card-text">Hiện tại không có sản phẩm nào của bạn đang được đấu giá. <a href="${pageContext.request.contextPath}/Misc/Upload" style="color: #56baed">Đăng sản phẩm ngay?</a></p>
                    </c:if>
                    <c:if test="${authUser.permission != 1}">
                        <p class="card-text">Hiện tại không có sản phẩm nào của bạn đang được đấu giá. <a href="" onclick="alert('Vui lòng gửi yêu cầu cho quản trị viên để trở thành Seller trước khi thực hiện thao tác này!')" style="color: #56baed">Đăng sản phẩm ngay?</a></p>
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
                                            <u><small>đ</small></u><fmt:formatNumber value="${c.bin}" type="number" />
                                        </h5>
                                        <p class="font-weight-light mt-3">${c.uploadDate}</p>
                                    </div>
                                    <div class="card-footer text-muted">
                                        <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/Misc/Editor?ProID=${c.proID}" role="button">
                                            <i class="fa fa-pencil" aria-hidden="true"></i>
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
                                            <u><small>đ</small></u><fmt:formatNumber value="${c.bin}" type="number" />
                                        </h5>
                                        <p class="font-weight-light mt-3">${c.uploadDate}</p>
                                        <c:choose>
                                            <c:when test="${c.status == 1}">
                                        <p>Người thắng: <a href="${pageContext.request.contextPath}/Rating/Detail?Username=${c.currentBidderUsername}" style="color: #56baed">${c.currentBidderUsername}</a></p>
                                    </div>
                                            <div class="card-footer text-muted">
                                                <a class="btn btn-sm btn-outline-warning" href="${pageContext.request.contextPath}/Rating/AddRate?ProID=${c.proID}&RatedUsername=${c.currentBidderUsername}" role="button">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                </a>
                                                <a class="btn btn-sm btn-outline-info" href="${pageContext.request.contextPath}/Product/Detail?id=${c.proID}" role="button">
                                                        <%--                        <i class="fa fa-eye" aria-hidden="true"></i>--%>
                                                    Chi tiết sản phẩm
                                                </a>
                                            </div>
                                            </c:when>
                                            <c:otherwise>
                                            <strong>Đấu giá thất bại</strong>
                                    </div>
                                            <div class="card-footer text-muted">
                                                <a class="btn btn-sm btn-outline-info" href="${pageContext.request.contextPath}/Product/Detail?id=${c.proID}" role="button">
                                                        <%--                        <i class="fa fa-eye" aria-hidden="true"></i>--%>
                                                    Chi tiết sản phẩm
                                                </a>
                                            </div>
                                            </c:otherwise>
                                        </c:choose>
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
</body>
</html>