<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="authUser" scope="session" type="com.ute.auctionwebapp.beans.User"/>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/Home/Index">
        <i class="fa fa-gavel fa-2x" aria-hidden="true"></i>
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <%-- <li class="nav-item">--%>
            <%-- <a class="nav-link" href="${pageContext.request.contextPath}/Product/Index">Home <span
                    class="sr-only">(current)</span></a>--%>
            <%-- </li>--%>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/Product/Watchlist?UserID=${authUser.userID}">Watchlist</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/Product/MyBid?UserID=${authUser.userID}">My Bid</a>
                </li>
        </ul>

         <form class="form-inline mr-auto" style="width: 400px;" method="get" action="${pageContext.request.contextPath}/Home/bySearch">
             <input class="form-control mr-sm-2 w-75" type="search" placeholder="Search" aria-label="Search" name="search_input" id="search_input">
            <button class="btn btn-outline-warning my-2 my-sm-0" type="submit">
                <i class="fa fa-search" aria-hidden="true"></i>
            </button>
        </form>
        <ul class="navbar-nav">
            <c:choose>
                <c:when test="${auth}">
                    <c:if test="${authUser.getPermission() == 1}">
                        <a href="${pageContext.request.contextPath}/Misc/Upload"><button type="button" class="btn btn-outline-info mr-3">Post A Product</button></a>
                    </c:if>
                    <form id="frmLogout" action="${pageContext.request.contextPath}/Account/Logout" method="post"></form>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="" role="button"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Hi, <b>${authUser.getUserName()}</b>!
                        </a>
                        <div class="dropdown-menu dropdown-menu-right"
                             aria-labelledby="navbarDropdown">
                            <a class="dropdown-item"
                               href="${pageContext.request.contextPath}/Account/Profile">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                     fill="currentColor" class="bi bi-person-square"
                                     viewBox="0 0 16 16">
                                    <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z" />
                                    <path
                                            d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2zm12 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1v-1c0-1-1-4-6-4s-6 3-6 4v1a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12z" />
                                </svg>
                                Profile
                            </a>
                            <a class="dropdown-item" href="javascript:$('#frmLogout').submit()">
                                <i class="fa fa-sign-out" aria-hidden="true"></i>
                                Log out!
                            </a>
                        </div>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/Account/Login">
                            <i class="fa fa-sign-in" aria-hidden="true"></i>
                            Login
                        </a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>