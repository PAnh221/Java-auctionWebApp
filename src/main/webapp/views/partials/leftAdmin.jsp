<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="row">
    <img src="${pageContext.request.contextPath}/public/imgs/admin/logo3.jpg" alt="" style="width: 84%; margin-top: 25px">
    <div class="admin_title">4. ADMINISTRATOR</div>
</div>
<div class="row">
    <div class="admin_login">
        <!-- <img src="./imgs/icon-yahoo.png" alt="" class="admin_login_avt"> -->
        <div class="admin_login_info">
            <i class="fas fa-user"></i>
            Welcome Admin
            <a data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
                <i class="arrow down"></i>
            </a>
        </div>

        <div class="collapse" id="collapseExample">
            <a href="${pageContext.request.contextPath}/Admin/Logout">Log out</a>
        </div>
    </div>
</div>


<div class="row">
    <div class="admin_category">
        <div class="admin_login_info">
            <i class="fal fa-books"></i>
            Manage Category
            <a data-toggle="collapse" href="#2" aria-expanded="false" aria-controls="collapseExample">
                <i class="arrow down"></i>
            </a>
        </div>
        <div class="collapse" id="2">
            <div>
                <a href="${pageContext.request.contextPath}/Admin/Category/Detail">Category</a>
            </div>
            <a href="${pageContext.request.contextPath}/Admin/SubCategory/Detail">Sub Category</a>
        </div>
    </div>
</div>

<div class="row">
    <div class="admin_product">
        <div class="admin_login_info">
            <i class="fal fa-boxes"></i>
            Manage Auction
            <a data-toggle="collapse" href="#3" aria-expanded="false" aria-controls="collapseExample">
                <i class="arrow down"></i>
            </a>
        </div>
        <div class="collapse" id="3">
            <div>
                <a href="${pageContext.request.contextPath}/Admin/Product/Detail">Product List</a>
            </div>
<%--            <div>--%>
<%--                <a href="${pageContext.request.contextPath}/Admin/Product/Live">Live Auction</a>--%>
<%--            </div>--%>
<%--            <div>--%>
<%--                <a href="${pageContext.request.contextPath}/Admin/Product/Won">Won Auction</a>--%>
<%--            </div>--%>
        </div>
    </div>
</div>
<div class="row">
    <div class="admin_user">
        <div class="admin_login_info">
            <i class="far fa-users"></i>
            Manage User
            <a data-toggle="collapse" href="#4" aria-expanded="false" aria-controls="collapseExample">
                <i class="arrow down"></i>
            </a>
        </div>
        <div class="collapse" id="4">
            <a href="${pageContext.request.contextPath}/Admin/User/UpgradeSeller">Upgrade Bidder</a><br>
            <a href="${pageContext.request.contextPath}/Admin/User/Seller">Seller</a><br>
            <a href="${pageContext.request.contextPath}/Admin/User/Bidder">Bidder</a><br>
            <div>
                <a href="${pageContext.request.contextPath}/Admin/User/Detail">List User</a>
            </div>
        </div>
    </div>
</div>
