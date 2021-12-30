<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="products" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>" />

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
                    Products:
                </div>
                <a href="${pageContext.request.contextPath}/Admin/Product/Add" class="btn btn-success addProduct" role="button">
                    <i class="fa fa-plus" aria-hidden="true"></i>
                    Add Product
                </a>
            </div>
            <div class="row">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th scope="col">#</th> <br>
                        <th scope="col">Name </th>
                        <th scope="col">SubCat ID</th>
                        <th scope="col">Seller ID</th>
                        <th scope="col">Start Price</th>
                        <th scope="col">Step Price</th>
                        <th scope="col">Tiny Des</th>
<%--                        <th scope="col">Full Des</th>--%>
                        <th scope="col">Bin</th>
                        <th scope="col">Upload Date</th>
                        <th scope="col">End Date</th>
                        <th scope="col">Img Index</th>
                        <th scope="col">Status</th>
                        <th scope="col">Handle</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${products}" var="p">
                        <tr>
                            <th scope="row">${p.proID}</th>
                            <td>${p.proName}</td>
                            <td>${p.subCatID}</td>
                            <td>${p.sellerID}</td>
                            <td>${p.startPrice}</td>
                            <td>${p.stepPrice}</td>
                            <td>${p.tinyDes}</td>
<%--                            <td>${p.fullDes}</td>--%>
                            <td>${p.bin}</td>
                            <td>${p.uploadDate}</td>
                            <td>${p.endDate}</td>
                            <td>${p.imgIndex}</td>
                            <td>${p.status}</td>
                            <td style="width: 9%">
                                <a href="${pageContext.request.contextPath}/Admin/Product/Edit?id=${p.proID}">Edit</a><br>
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
