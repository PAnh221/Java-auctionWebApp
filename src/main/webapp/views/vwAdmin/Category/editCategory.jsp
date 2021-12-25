<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:useBean id="category" scope="request" type="com.ute.auctionwebapp.beans.Category"/>

<html>
<head>
    <title>Admin Page</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/public/css/grid.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/public/css/admin.css">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

</head>
<body>

<div class="main grid">
    <div class="row">
        <div class="col l-2 admin_left">
            <jsp:include page="../../partials/leftAdmin.jsp"/>
        </div>

        <div class="col l-10 admin_right">
            <c:if test="${hasError}">
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                    <strong>Delete Fail!</strong> ${errorMessage}
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            </c:if>
            <div class="row">
                <div class="form" id="frmCategory" style="width: 100%">
                    <form action="" class="form_accounts" method="post" style="width: 100%">
                        <div class="input-form">
                            <span>Category ID</span>
                            <input type="text" id="catid" name="catid" value="${category.catID}" >
                        </div>
                        <div class="input-form">
                            <span>Category Name</span>
                            <input type="text" name="catname" value="${category.catName}" >
                        </div>

                        <div class="input-form">
                            <button type="submit" class="btn btn-outline-success" formaction="${pageContext.request.contextPath}/Admin/Category/Update" style="padding: 5px 40px; font-size: 20px">
                                Save
                            </button>
                            <button type="submit" class="btn btn-outline-danger" id="btnDelete" formaction="${pageContext.request.contextPath}/Admin/Category/Delete" style="padding: 5px 40px; font-size: 20px">
                                Delete
                            </button>
                            <a href="${pageContext.request.contextPath}/Admin/Category/Detail" class="btn btn-outline-primary" role="button" style="padding: 5px 40px; font-size: 20px">
                                Category List
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>
    $("#btnDelete").on('click', function (e) {
        e.preventDefault();
        const catid = $("#catid").val();
        //check
        $.getJSON('${pageContext.request.contextPath}/Admin/Category/IsAvailable?id='+catid, function (data)
        {
            if (data === false)
            {
                alert('Can not delete category have product!');
            }
            else
            {
                $("#btnDelete").off('click').click();
            }
        })
    })

</script>

</body>
</html>
