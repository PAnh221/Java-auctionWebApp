<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Responsive Login, Registration & Forgot Form Design</title>
    <!-- Bootstrap 4 CSS CDN -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.1/css/bootstrap.min.css" />
    <!-- Fontawesome CSS CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/public/css/style.css" />
</head>

<body class="bg-info">
<div class="container">
    <div class="row justify-content-center wrapper" id="forgot-box">
        <div class="col-lg-10 my-auto myShadow">
            <div class="row">
                <div class="col-lg-7 bg-white p-4">
                    <h1 class="text-center font-weight-bold text-primary">Forgot Your Password?</h1>
                    <hr class="my-3" />
                    <p class="lead text-center text-secondary">To reset your password, enter the registered e-mail
                        adddress and we will send you password reset instructions on your e-mail!</p>
                    <form action="#" method="post" class="px-3" id="forgot-form">
                        <div id="forgotAlert"></div>
                        <div class="input-group input-group-lg form-group">
                            <div class="input-group-prepend">
                                    <span class="input-group-text rounded-0"><i
                                            class="far fa-envelope fa-lg"></i></span>
                            </div>
                            <input type="email" id="email" name="email" class="form-control rounded-0"
                                   placeholder="E-Mail" required />
                        </div>
                        <div class="form-group">
                            <input type="submit" id="forgot-btn" value="Reset Password"
                                   class="btn btn-primary btn-lg btn-block myBtn" />
                        </div>
                    </form>
                </div>
                <div class="col-lg-5 d-flex flex-column justify-content-center myColor p-4">
                    <h1 class="text-center font-weight-bold text-white">Reset Password!</h1>
                    <hr class="my-4 bg-light myHr" />
                    <a href="${pageContext.request.contextPath}/Account/Login"
                       class="btn btn-outline-light btn-lg font-weight-bolder mt-4 align-self-center myLinkBtn"
                       id="login-link" role="button">
                        Sign In
                        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor"
                             class="bi bi-box-arrow-in-left" viewBox="0 0 10 16">
                            <path fill-rule="evenodd"
                                  d="M10 3.5a.5.5 0 0 0-.5-.5h-8a.5.5 0 0 0-.5.5v9a.5.5 0 0 0 .5.5h8a.5.5 0 0 0 .5-.5v-2a.5.5 0 0 1 1 0v2A1.5 1.5 0 0 1 9.5 14h-8A1.5 1.5 0 0 1 0 12.5v-9A1.5 1.5 0 0 1 1.5 2h8A1.5 1.5 0 0 1 11 3.5v2a.5.5 0 0 1-1 0v-2z" />
                            <path fill-rule="evenodd"
                                  d="M4.146 8.354a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H14.5a.5.5 0 0 1 0 1H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3z" />
                        </svg>
                    </a>
                    <a class="btn btn-outline-light btn-lg align-self-center font-weight-bolder mt-4 myLinkBtn"
                       role="button" href="${pageContext.request.contextPath}/Home/">
                        Back home
                        <i class="fa fa-home" aria-hidden="true"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>

</html>