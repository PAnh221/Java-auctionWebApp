<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:useBean id="user" scope="request" type="com.ute.auctionwebapp.beans.User"/>

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
            <jsp:include page="../../partials/leftAdmin.jsp"/>
        </div>

        <div class="col l-10 admin_right">
            <div class="row">
                <div class="form" id="frmCategory" style="width: 100%">
                    <form action="" class="form_accounts" method="post" style="width: 100%">
                        <div class="input-form">
                            <span>#</span><br>
                            <input type="text" name="userid" value="${user.userID}" >
                        </div>
                        <div class="input-form">
                            <span>User Name</span>
                            <input type="text" name="username" value="${user.userName}" >
                        </div>
                        <div class="input-form">
                            <span>Password</span>
                            <input type="text" name="password" value="${user.password}" >
                        </div>
                        <div class="input-form">
                            <span>Address</span>
                            <input type="text" name="address" value="${user.address}" >
                        </div>
                        <div class="input-form">
                            <span>Email</span>
                            <input type="text" name="email" value="${user.email}" >
                        </div>
                        <div class="input-form">
                            <span>Date of birth</span>
                            <input type="text" name="dob" value="${user.dob}" >
                        </div>
                        <div class="input-form">
                            <span>Permission</span>
                            <input type="text" name="permission" value="${user.permission}" >
                        </div>
                        <div class="input-form">
                            <span>Rating</span>
                            <input type="text" name="rating" value="${user.rating}" >
                        </div>
                        <div class="input-form">
                            <button type="submit" class="btn btn-outline-success" formaction="${pageContext.request.contextPath}/Admin/User/Update" style="padding: 5px 40px; font-size: 20px">
                                Save
                            </button>
                            <button type="submit" class="btn btn-outline-danger" formaction="${pageContext.request.contextPath}/Admin/User/Delete" style="padding: 5px 40px; font-size: 20px">
                                Delete
                            </button>
                            <a href="${pageContext.request.contextPath}/Admin/SubCategory/Detail" class="btn btn-outline-primary" role="button" style="padding: 5px 40px; font-size: 20px">
                                Sub Category List
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
