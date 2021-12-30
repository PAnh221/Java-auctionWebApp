<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="users" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.User>" />

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
            <div class="row admin_product_title">
                <div>
                    List Upgrade User:
                </div>
            </div>

            <c:choose>
                <c:when test="${users.size() == null}">
                    <div class="card-body">
                        <p class="card-text">Không có dữ liệu.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th scope="col">#</th> <br>
                                <th scope="col">Username </th>
                                    <%--                        <th scope="col">Password</th>--%>
                                <th scope="col">Name</th>
                                <th scope="col">Address</th>
                                <th scope="col">Email</th>
                                <th scope="col">Date of birth</th>
                                <th scope="col">Permission</th>
                                <th scope="col">Handle</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${users}" var="u">
                                <tr>
                                    <th scope="row">${u.userID}</th>
                                    <td>${u.userName}</td>
                                        <%--                            <td>${u.password}</td>--%>
                                    <td>${u.name}</td>
                                    <td>${u.address}</td>
                                    <td>${u.email}</td>
                                    <td>${u.dob}</td>
                                    <td>${u.permission}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/Admin/User/DenyUpgrade?id=${u.userID}">Deny |</a>
                                        <a href="${pageContext.request.contextPath}/Admin/User/Upgrade?id=${u.userID}"> Accept </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>
