<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
                            <input type="text" name="proid">
                        </div>
                        <div class="input-form">
                            <span>Product Name</span>
                            <input type="text" name="proname" id="productname">
                        </div>
                        <div class="input-form">
                            <span>Tiny Des</span>
                            <input type="text" name="tinydes">
                        </div>
                        <div class="input-form">
                            <span>Full Des</span><br>
                            <input type="text" name="fulldes">
                        </div>
                        <div class="input-form">
                            <span>Cat ID</span><br>
                            <input type="text" name="catid">
                        </div>
                        <div class="input-form">
                            <span>Subcat ID</span>
                            <input type="text" name="subcatid">
                        </div>
                        <div class="input-form">
                            <span>Seller ID</span><br>
                            <input type="text" name="sellerid">
                        </div>
                        <div class="input-form">
                            <span>Index Img</span><br>
                            <input type="text" name="imgindex">
                        </div>
                        <div class="input-form">
                            <span>Upload Date</span>
                            <input type="text" name="uploaddate" id="txtUploadDate">
                        </div>
                        <div class="input-form">
                            <span>Bin</span><br>
                            <input type="text" name="bin">
                        </div>
                        <div class="input-form">
                            <button type="submit" class="btn btn-outline-success" style="padding: 5px 40px; font-size: 20px">
                                Add
                            </button>
                            <a href="${pageContext.request.contextPath}/Admin/Product/Detail" class="btn btn-outline-primary" role="button" style="padding: 5px 40px; font-size: 20px; margin-left: 10px;">
                                List Product
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('#txtUploadDate').datetimepicker(
        {
            format: 'd/m/Y',
            timepicker: false,
            mask: true
        }
    );
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
