<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Untitled</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"
          integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn"
          crossorigin="anonymous">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/public/css/Login-Box-En.css">
</head>

<body>
<div class="container-fluid h-100">
    <div class="d-flex flex-column justify-content-center h-80" id="login-box">
        <div class="login-box-header">
            <h4 style="color:rgb(139,139,139);margin-bottom:0px;font-weight:400;font-size:27px;">
                Login
            </h4>
        </div>
        <div class="login-box-content">
            <div class="fb-login box-shadow">
                <a class="d-flex flex-row align-items-center social-login-link" href="#">
                    <i class="fa fa-facebook"
                       style="margin-left:0px;padding-right:20px;padding-left:22px;width:56px;"></i>
                    Login with Facebook
                </a>
            </div>
            <div class="gp-login box-shadow">
                <a class="d-flex flex-row align-items-center social-login-link" style="margin-bottom:10px;"
                   href="#">
                    <i class="fa fa-google" style="color:rgb(255,255,255);width:56px;"></i>
                    Login with Google+</a>
            </div>
        </div>
        <div class="d-flex flex-row align-items-center login-box-seperator-container">
            <div class="login-box-seperator"></div>
            <div class="login-box-seperator-text">
                <p
                        style="margin-bottom:0px;padding-left:10px;padding-right:10px;font-weight:400;color:rgb(201,201,201);">
                    or
                </p>
            </div>
            <div class="login-box-seperator"></div>
        </div>
        <c:if test="${hasError}">
            <div class="alert alert-danger" role="alert">
                <h4 class="alert-heading">Login failed!</h4>
                <p class="mb-0">${errorMessage}</p>
            </div>
        </c:if>

        <form action="" method="post">
            <div class="username-login" style="background-color:#ffffff;">
                <input type="text" class="username-input form-control" style="margin-top:10px;" required=""
                       placeholder="User name" minlength="6" name="username" id="txtUsername" autofocus>
                <input type="password" class="password-input form-control" style="margin-top:10px;"
                       required="" placeholder="Password" minlength="6" name="pass" id="txtPassword">
            </div>
            <div class="submit-row" style="margin-bottom:0px;padding-top:0px;">
                <button class="btn btn-primary btn-block box-shadow" id="submit-id-submit" type="submit">
                    Login
                </button>

            </div>
        </form>

        <div class="submit-row" style="margin-bottom:8px;padding-top:0px;">
            <div class="d-flex justify-content-between">
                <div class="form-check form-check-inline" id="form-check-rememberMe">
                    <input class="form-check-input" type="checkbox" id="formCheck-1" for="remember"
                           style="cursor:pointer;" name="check">
                    <label class="form-check-label" for="formCheck-1">
                                    <span class="label-text">
                                        Remember Me
                                    </span>
                    </label>
                </div>
                <a id="forgot-password-link" href="${pageContext.request.contextPath}/Account/ForgetPass">Forgot Password?</a>
            </div>
        </div>

        <div id="login-box-footer" style="padding:10px 20px;padding-bottom:23px;padding-top:18px;">
            <p style="margin-bottom:0px;">
                Don't you have an account?
                <a id="register-link" href="${pageContext.request.contextPath}/Account/Register">
                    Sign Up!
                </a>
                or
                <a id="" href="${pageContext.request.contextPath}/Home/">
                    Back to home.
                </a>
            </p>
        </div>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.6.0.slim.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
        integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js"
        integrity="sha384-VHvPCCyXqtD5DqJeNxl2dtTyhF78xXNXdkwX1CZeRusQfRKp+tA7hAShOK/B/fQ2"
        crossorigin="anonymous"></script>
</body>

</html>