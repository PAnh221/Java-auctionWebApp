<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="isRequesting" scope="request" type="java.lang.Boolean"/>
<jsp:useBean id="authUser" scope="session" type="com.ute.auctionwebapp.beans.User"/>

<html lang="en">
<!DOCTYPE html>
<html lang="en">


<head>
    <meta charset="utf-8">
    <title>edit profile page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.1/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
    <script>
        var check = function () {
            if (document.getElementById('newpassword').value ==
                document.getElementById('confirm-newpassword').value) {
                document.getElementById('submitbtn').disabled = false;
                document.getElementById('message').style.color = 'green';
                document.getElementById('message').innerHTML = 'Mật khẩu trùng khớp';
            } else {
                document.getElementById('submitbtn').disabled = true;
                document.getElementById('message').style.color = 'red';
                document.getElementById('message').innerHTML = 'Mật khẩu không khớp';
            }
        }
    </script>
</head>

<body>
<jsp:include page="../../views/partials/nav.jsp"/>
<div class="container mt-3">
    <div class="row flex-lg-nowrap">
        <div class="col-12 col-lg-auto mb-3" style="width: 200px;">
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
                        <li class="nav-item"><a class="nav-link px-2 active"
                                                href="${pageContext.request.contextPath}/Account/Profile">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                 fill="currentColor" class="bi bi-person-square"
                                 viewBox="0 0 16 16">
                                <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
                                <path
                                        d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2zm12 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1v-1c0-1-1-4-6-4s-6 3-6 4v1a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12z"/>
                            </svg>
                            <span>Profile</span>
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

        <div class="col">
            <div class="row">
                <!-- div contain profile -->
                <div class="col mb-3">
                    <div class="card">
                        <div class="card-body">
                            <div class="e-profile">
                                <div class="row">
                                    <div class="col-12 col-sm-auto mb-3">
                                        <div class="mx-auto" style="width: 140px;">
                                            <div class="d-flex justify-content-center align-items-center rounded"
                                                 style="height: 140px; background-color: rgb(233, 236, 239);">
                                                <span style="color: rgb(166, 168, 170); font: bold 8pt Arial;">140x140</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col d-flex flex-column flex-sm-row justify-content-between mb-3">
                                        <div class="text-center text-sm-left mb-2 mb-sm-0">
                                            <h4 class="pt-sm-2 pb-1 mb-0 text-nowrap">${authUser.name}</h4>
                                            <p class="mb-0">${authUser.userName}</p>
                                            <div class="text-muted"><small>${authUser.address}</small></div>
                                            <div class="mt-2">
                                                <button class="btn btn-primary" type="button">
                                                    <i class="fa fa-fw fa-camera"></i>
                                                    <span>Change Photo</span>
                                                </button>
                                            </div>
                                        </div>
                                        <c:if test="${authUser.permission == 0}">
                                            <div class="text-center text-sm-right">
                                                <span class="badge badge-success">Bidder</span>
                                            </div>
                                        </c:if>
                                        <c:if test="${authUser.permission == 1}">
                                            <div class="text-center text-sm-right">
                                                <span class="badge badge-info">Seller</span>
                                            </div>
                                        </c:if>

                                    </div>
                                </div>
                                <ul class="nav nav-tabs">
                                    <li class="nav-item"><a href="" class="active nav-link">Settings</a></li>
                                </ul>
                                <div class="tab-content pt-3">
                                    <div class="tab-pane active">
                                        <form class="form" method="post">
                                            <div class="row">
                                                <div class="col">
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Full Name</label>
                                                                <input class="form-control" type="text" name="name"
                                                                       placeholder="Name"
                                                                       value="${authUser.name}">
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Username</label>
                                                                <input class="form-control" type="text" name="username"
                                                                       readonly value="${authUser.userName}">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Email</label>
                                                                <input class="form-control" type="text" name="email"
                                                                       value="${authUser.email}">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <c:if test="${hasError}">
                                                        <div class="alert alert-warning alert-dismissible fade show"
                                                             role="alert">
                                                            <strong>Edit failed!</strong> ${errorMessage}
                                                            <button type="button" class="close" data-dismiss="alert"
                                                                    aria-label="Close">
                                                                <span aria-hidden="true">&times;</span>
                                                            </button>
                                                        </div>
                                                    </c:if>
                                                    <%--                                                    <div class="row">--%>
                                                    <%--                                                        <div class="col mb-3">--%>
                                                    <%--                                                            <div class="form-group">--%>
                                                    <%--                                                                <label>About</label>--%>
                                                    <%--                                                                <textarea class="form-control" rows="5"--%>
                                                    <%--                                                                          placeholder="My Bio"></textarea>--%>
                                                    <%--                                                            </div>--%>
                                                    <%--                                                        </div>--%>
                                                    <%--                                                    </div>--%>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="mb-2"><b>Change Password</b></div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Current Password</label>
                                                                <input class="form-control" type="password"
                                                                       name="password"
                                                                       placeholder="Current Password">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>New Password</label>
                                                                <input class="form-control" type="password"
                                                                       name="newpassword" id="newpassword"
                                                                       placeholder="New Password" onkeyup='check();'>
                                                            </div>

                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Confirm <span
                                                                        class="d-none d-xl-inline">Password</span></label>
                                                                <input class="form-control" type="password"
                                                                       name="confirm-newpassword"
                                                                       id="confirm-newpassword"
                                                                       placeholder="Confirm" onkeyup='check();'>
                                                                <span id="message"></span>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <%--                                                <div class="col-12 col-sm-5 offset-sm-1 mb-3">--%>
                                                <%--                                                    <div class="mb-2"><b>Keeping in Touch</b></div>--%>
                                                <%--                                                    <div class="row">--%>
                                                <%--                                                        <div class="col">--%>
                                                <%--                                                            <label>Email Notifications</label>--%>
                                                <%--                                                            <div class="custom-controls-stacked px-2">--%>
                                                <%--                                                                <div class="custom-control custom-checkbox">--%>
                                                <%--                                                                    <input type="checkbox" class="custom-control-input"--%>
                                                <%--                                                                           id="notifications-blog"--%>
                                                <%--                                                                           checked="">--%>
                                                <%--                                                                    <label class="custom-control-label"--%>
                                                <%--                                                                           for="notifications-blog">Blog posts</label>--%>
                                                <%--                                                                </div>--%>
                                                <%--                                                                <div class="custom-control custom-checkbox">--%>
                                                <%--                                                                    <input type="checkbox" class="custom-control-input"--%>
                                                <%--                                                                           id="notifications-news"--%>
                                                <%--                                                                           checked="">--%>
                                                <%--                                                                    <label class="custom-control-label"--%>
                                                <%--                                                                           for="notifications-news">Newsletter</label>--%>
                                                <%--                                                                </div>--%>
                                                <%--                                                                <div class="custom-control custom-checkbox">--%>
                                                <%--                                                                    <input type="checkbox" class="custom-control-input"--%>
                                                <%--                                                                           id="notifications-offers"--%>
                                                <%--                                                                           checked="">--%>
                                                <%--                                                                    <label class="custom-control-label"--%>
                                                <%--                                                                           for="notifications-offers">Personal--%>
                                                <%--                                                                        Offers</label>--%>
                                                <%--                                                                </div>--%>
                                                <%--                                                            </div>--%>
                                                <%--                                                        </div>--%>
                                                <%--                                                    </div>--%>
                                                <%--                                                </div>--%>
                                            </div>
                                            <div class="row">
                                                <div class="col d-flex justify-content-end">
                                                    <button id="submitbtn" class="btn btn-primary" type="submit"
                                                            formaction="${pageContext.request.contextPath}/Account/Edit">
                                                        Save Changes
                                                    </button>
                                                </div>
                                            </div>
                                        </form>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-md-3 mb-3">
                    <c:if test= "${authUser.permission == 0}">
                        <c:choose>
                        <c:when test = "${isRequesting == false}">
                            <div class="card">
                                <div class="card-body">
                                    <h6 class="card-title font-weight-bold">Yêu cầu trở thành người bán của bạn đang được xử lý...</h6>
                                    </a>
                                </div>
                            </div>
                        </c:when>

                        <c:otherwise>
                            <div class="card">
                                <div class="card-body">
                                    <h6 class="card-title font-weight-bold">Bạn muốn trở thành người bán?</h6>
                                    <a class="btn btn-sm btn-outline-info" href="${pageContext.request.contextPath}/Request/AddRequest?id=${authUser.userID}" role="button">
                                            <%--                        <i class="fa fa-eye" aria-hidden="true"></i>--%>
                                        Xin nâng cấp
                                    </a>
                                </div>
                            </div>
                        </c:otherwise>
                        </c:choose>
                    </c:if>
                </div>
            </div>

        </div>
    </div>
</div>
</body>
</html>