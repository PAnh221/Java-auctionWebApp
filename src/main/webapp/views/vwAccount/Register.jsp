<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Untitled</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"
          integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/public/css/Login-Box-En.css">
<%--    <link rel="stylesheet" href="assets\css\Login-Box-En.css">--%>
</head>

<body>

<div class="d-flex flex-column justify-content-center" id="login-box">
    <div class="login-box-header">
        <h4 style="color:rgb(139,139,139);margin-bottom:0px;font-weight:400;font-size:27px;">Register</h4>
    </div>
    <form action="" method="post" id="frmRegister">
        <div class="username-login" style="background-color:#ffffff;">
            <input type="text" class="email-input form-control" style="margin-top:10px;" required=""
                   placeholder="User Name" minlength="6" name="username" id="txtUsername" autofocus>
            <input type="text" class="email-input form-control" style="margin-top:10px;" required=""
                   placeholder="Full Name" minlength="6" name="fullname" id="txtFullname">
            <input type="date" class="email-input form-control" name="dob" id="txtDoB"
                   style="width: 460px;height: 46px;margin: 10px 0px 0px;padding: 10px 12px;color: rgb(41, 48, 59);border-width: 1px;">
            <input type="text" class="email-input form-control" style="margin-top:10px;" required=""
                   placeholder="Address" minlength="6" name="address" id="txtAddress">
            <input type="email" class="email-input form-control" style="margin-top:10px;" required=""
                   placeholder="Email" minlength="6" name="email" id="txtEmail">
            <input type="password" class="password-input form-control" style="margin-top:10px;" required=""
                   placeholder="Password" minlength="6" name="rawpass" id="txtPassword">
            <input type="password" class="password-input form-control" style="margin-top:10px;" required=""
                   placeholder="Confirm Password" id="txtConfirmPass" minlength="6">
        </div>
        <div class="submit-row" style="margin-bottom:8px;padding-top:0px;">
            <button class="btn btn-primary btn-block box-shadow" id="submit-id-submit" type="submit">
                Registor
            </button>
            <div class="d-flex justify-content-between"></div>
        </div>
    </form>
</div>
<script>
    $('#txtPassword #txtConfirmPass').on('keyup', function () {
        if ($('#txtPassword').val() === $('#txtConfirmPass').val()) {
            $('#txtConfirmPass').html('Matching').css('color', 'green');
        } else
            $('#txtConfirmPass').html('Not Matching').css('color', 'red');
    });
</script>
<script>
    $('#frmRegister').on('submit',function (e){
        e.preventDefault();
        const pass = $('#txtPassword').val();
        const confirmpass = $('txtConfirmPass').val();
        if ($('#txtPassword').val() === $('#txtConfirmPass').val()) {
            $('#txtConfirmPass').html('Matching').css('color', 'green');
        } else
        {
            $('#txtConfirmPass').html('Not Matching').css('color', 'red');
            alert("Password isn't matching!");
            return;
        }
        $('#frmRegister').off('submit').submit();
    });
</script>
<script src="https://code.jquery.com/jquery-3.6.0.slim.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
        integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js"
        integrity="sha384-VHvPCCyXqtD5DqJeNxl2dtTyhF78xXNXdkwX1CZeRusQfRKp+tA7hAShOK/B/fQ2"
        crossorigin="anonymous"></script>
</body>

</html>