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
            <jsp:include page="../../partials/leftAdmin.jsp"/>
        </div>

        <div class="col l-10 admin_right">
            <div class="row">
                <div class="form" id="frmCategory" style="width: 100%">
                    <form action="" class="form_accounts" method="post" style="width: 100%">
<%--                        <div class="input-form">--%>
<%--                            <span>Category ID</span>--%>
<%--                            <input type="text" name="catid">--%>
<%--                        </div>--%>
                        <div class="input-form">
                            <span>Category Name</span>
                            <input type="text" name="catname" id="catname" onkeyup="checkCat()">
                            <p style="font-size: 14px" id="checkcatname"></p>
                        </div>
                        <div class="input-form">
                            <button type="submit" class="btn btn-outline-success" id="btnAdd" style="padding: 5px 40px; font-size: 20px">
                                Thêm sản phẩm
                            </button>
                            <a href="${pageContext.request.contextPath}/Admin/Category/Detail" class="btn btn-outline-primary" role="button" style="padding: 5px 40px; font-size: 20px; margin-left: 10px;">
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

<script>
    function checkCat()
    {
        const catname = $("#catname").val();
        if(catname !== '')
        {
            document.getElementById("btnAdd").disabled = false;
            document.querySelector('#checkcatname').innerText = "Tên danh mục hợp lệ!"
            document.querySelector('#checkcatname').style.color = "green"
        }
        else
        {
            document.querySelector('#checkcatname').innerText = "Vui lòng đặt tên danh mục!"
            document.querySelector('#checkcatname').style.color = "red"
            document.getElementById("btnAdd").disabled = true;
        }
    }

    function checkMail() {
        const emailinput = document.querySelector('#content-input-email').value
        const atposition = emailinput.indexOf("@");
        const dotposition = emailinput.lastIndexOf(".");

        if (emailinput === '')
        {
            document.querySelector('.required-mail').innerText = 'required'
            document.querySelector('.required-mail').classList.add('red')
        }
        else {
            if(atposition < 1 || dotposition < (atposition + 2) || (dotposition + 2) >= emailinput.length)
            {
                document.querySelector('.required-mail').innerText = 'Please fill out a valid email format'
                document.querySelector('.required-mail').classList.add('yellow')
            }
            else {
                document.querySelector('.required-mail').innerText = 'You can use this email!'
                document.querySelector('.required-mail').classList.remove('yellow')
                document.querySelector('.required-mail').classList.add('green')
            }
        }
    }

</script>

</body>
</html>
