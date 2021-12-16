<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                        <a href="#">Log out</a>
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
                            <a href="${pageContext.request.contextPath}/Admin/Product/add">Add Category</a>
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
            <div class="row">
                <div class="form" id="frmProduct" style="width: 100%">
                    <form action="" class="form_accounts" method="post" style="width: 100%">
                        <div class="input-form">
                            <span>Mã Sản Phẩm</span>
                            <input type="text" name="masp" value="${product.maSP}" >
                        </div>
                        <div class="input-form">
                            <span>Tên Sản Phẩm</span>
                            <input type="text" name="tensp" value="${product.tenSP}" >
                        </div>
                        <div class="input-form">
                            <span>Loại Sản Phẩm</span>
                            <input type="text" name="loaisp" value="${product.loaiSP}" >
                        </div>
                        <div class="input-form">
                            <span>Màu Sắc</span>
                            <input type="text" name="mausac" value="${product.mauSP}">
                        </div>
                        <div class="input-form">
                            <span>Chất liệu</span>
                            <input type="text" name="chatlieu" value="${product.maChatlieu}" >
                        </div>
                        <div class="input-form">
                            <span>Size sản phẩm:</span>
                            <input type="text" name="size" value="${product.sizeSP}" >
                        </div>
                        <div class="input-form">
                            <span>Số Lượng</span>
                            <input type="text" name="soluong" value="${product.soLuong}" >
                        </div>

                        <div class="input-form">
                            <button type="submit" class="btn btn-outline-success" formaction="${pageContext.request.contextPath}/Admin/Product/Update" style="padding: 5px 40px; font-size: 20px">
                                Lưu lại
                            </button>
                            <button type="submit" class="btn btn-outline-danger" formaction="${pageContext.request.contextPath}/Admin/Product/Delete" style="padding: 5px 40px; font-size: 20px">
                                Xóa sản phẩm
                            </button>
                            <a href="${pageContext.request.contextPath}/Admin/Product/Detail" class="btn btn-outline-primary" role="button" style="padding: 5px 40px; font-size: 20px">
                                Danh sách sản phẩm
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>
