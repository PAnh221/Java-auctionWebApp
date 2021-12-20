<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="categories" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Category>" />
<html>
<head>
    <title>Admin Page</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/public/css/grid.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/public/css/admin.css">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
</head>
<body>
<div class="main grid">
    <div class="row">
        <div class="col l-2 admin_left">
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
                        <a href="${pageContext.request.contextPath}/Admin/Product/Index">Log out</a>
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
                            <a href="#">Add Category</a>
                        </div>
                        <a href="#">Delete Category</a>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="admin_product">
                    <div class="admin_login_info">
                        <i class="fal fa-boxes"></i>
                        Manage Product
                        <a data-toggle="collapse" href="#3" aria-expanded="false" aria-controls="collapseExample">
                            <i class="arrow down"></i>
                        </a>
                    </div>
                    <div class="collapse" id="3">
                        <div>
                            <a href="${pageContext.request.contextPath}/Admin/Product/Add">Add Category</a>
                        </div>
                        <a href="#">Delete Category</a>
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
                        <div>
                            <a href="#">Add User</a>
                        </div>
                        <a href="#">Delete Category</a>
                    </div>
                </div>
            </div>

        </div>

        <div class="col l-10 admin_right">
            <div class="row admin_product_title">
                <div>
                    Category:
                </div>
                <a href="${pageContext.request.contextPath}/Admin/Category/Add" class="btn btn-success addProduct" role="button">
                    <i class="fa fa-plus" aria-hidden="true"></i>
                    Add Product
                </a>
            </div>
            <div class="row">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Category Name</th>
                        <th scope="col">Handle</th>
                    </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${categories}" var="c">
                            <tr>
                                <th scope="row">${c.catID}</th>
                                <td>${c.catName}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/Admin/Category/Edit?id=${c.catID}">Edit</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>
