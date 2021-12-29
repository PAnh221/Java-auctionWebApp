<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:useBean id="product" scope="request" type="com.ute.auctionwebapp.beans.Product"/>
<jsp:useBean id="categories" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Category>" />
<jsp:useBean id="subcategories" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.SubCategory>" />
<jsp:useBean id="users" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.User>" />

<html>
<head>
    <title>Admin Page</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/public/css/grid.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/public/css/admin.css">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css" integrity="sha512-f0tzWhCwVFS3WeYaofoLWkTP62ObhewQ1EZn65oSYDZUg1+CyywGKkWzm8BxaJj5HGKI72PnMH9jYyIFz+GH7g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js" integrity="sha512-AIOTidJAcHBH2G/oZv9viEGXRqDNmfdPVPYOYKGy3fti0xIplnlgMHUGfuNRzC6FkzIo0iIxgFnr9RikFxK+sw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<body>
<div class="main grid">
    <div class="row">
        <div class="col l-2 admin_left">
            <jsp:include page="../../partials/leftAdmin.jsp"/>
        </div>

        <div class="col l-10 admin_right">
            <div class="row">
                <div class="form" id="frmProduct" style="width: 100%">
                    <form action="" class="form_accounts" method="post" style="width: 100%">
                        <div class="input-form">
                            <span>#</span> <br>
                            <input type="text" name="proid" value="${product.proID}" readonly>
                        </div>
                        <div class="input-form">
                            <span>Product Name</span>
                            <input type="text" name="proname" id="productname" value="${product.proName}">
                        </div>
                        <div class="input-form">
                            <span>Sub Category</span><br>
                            <select id="subcatid" name="subcatid"  style="width: 94%;
                                                                    padding: 6.5px 10px;
                                                                    outline: none;
                                                                    border: 1px solid #607d8b;
                                                                    font-size: 16px;
                                                                    letter-spacing: 1px;
                                                                    background: transparent;
                                                                    border-radius: 3px;
                                                                    margin-bottom: 5px;">
                                <c:forEach items="${subcategories}" var="c">
                                    <option value="${c.subCatID}">${c.subCatName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="input-form">
                            <span>User</span><br>
                            <select id="sellerid" name="sellerid"  style="width: 94%;
                                                                    padding: 6.5px 10px;
                                                                    outline: none;
                                                                    border: 1px solid #607d8b;
                                                                    font-size: 16px;
                                                                    letter-spacing: 1px;
                                                                    background: transparent;
                                                                    border-radius: 3px;
                                                                    margin-bottom: 5px;">
                                <c:forEach items="${users}" var="c">
                                    <option value="${c.userID}">${c.userName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="input-form">
                            <span>Start Price</span><br>
                            <input type="text" name="startprice" value="${product.startPrice}">
                        </div>
                        <div class="input-form">
                            <span>Step Price</span><br>
                            <input type="text" name="stepprice" value="${product.stepPrice}">
                        </div>
                        <div class="input-form">
                            <span>Tiny Des</span>
                            <input type="text" name="tinydes" value="${product.tinyDes}">
                        </div>
                        <div class="input-form">
                            <span>Full Des</span><br>
                            <input type="text" name="fulldes" value="${product.fullDes}">
                        </div>

                        <div class="input-form">
                            <span>Bin</span><br>
                            <input type="text" name="bin" value="${product.bin}">
                        </div>

                        <div class="input-form">
                            <span>Index Img</span><br>
                            <input type="text" name="imgindex" value="${product.imgIndex}">
                        </div>

                        <div class="input-form">
                            <span>Status</span><br>
                            <input type="text" name="status" value="${product.status}">
                        </div>
<%--                        <div class="input-form">--%>
<%--                            <span>Upload Date</span>--%>
<%--                            <input type="text" name="uploaddate" id="txtUploadDate" value="${product.uploadDate}">--%>
<%--                        </div>--%>
                        <div class="input-form">
                            <button type="submit" class="btn btn-outline-success" formaction="${pageContext.request.contextPath}/Admin/Product/Update" style="padding: 5px 40px; font-size: 20px">
                                Save
                            </button>
                            <button type="submit" class="btn btn-outline-danger" formaction="${pageContext.request.contextPath}/Admin/Product/Delete" style="padding: 5px 40px; font-size: 20px">
                                Delete
                            </button>
                            <a href="${pageContext.request.contextPath}/Admin/Product/Detail" class="btn btn-outline-primary" role="button" style="padding: 5px 40px; font-size: 20px">
                                Product List
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    const dates = $('#txtUploadDate').val();
    $('#txtUploadDate').datetimepicker(
        {
            format: 'd/m/Y',
            timepicker: false,
            mask: true
        }
    );
    $('#txtUploadDate').value = dates;
    $('#frmProduct').on('submit', function (e) {
        e.preventDefault();
        const proname = $('#productname').val();
        if(proname.length ===0)
        {
            alert("Mời bạn điền đầy đủ thông tin!");
            return;
        };

        <%--$.getJSON('${pageContext.request.contextPath}/Admin/User/IsAvailable?user=' + username, function (data) {--%>
        <%--    if (data ==true)--%>
        <%--    {--%>
        <%--        $('#frmUser').off('submit').submit();--%>
        <%--        alert("Đăng ký thành công!");--%>
        <%--    }--%>
        <%--    else--%>
        <%--    {--%>
        <%--        alert("Tên người dùng đã tồn tại!")--%>
        <%--    }--%>
        <%--});--%>
        $('#frmProduct').off('submit').submit();
    });
</script>
</body>
</html>
