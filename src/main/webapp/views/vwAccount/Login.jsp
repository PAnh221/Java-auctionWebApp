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
    <%--    <link rel="stylesheet" href="/assets/css/styles.css" />--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/public/css/style.css"/>
</head>

<body class="bg-info">
<div class="container">
    <div class="row justify-content-center wrapper" id="login-box">
        <div class="col-lg-10 my-auto myShadow">
            <div class="row">
                <div class="col-lg-7 bg-white p-4">
                    <h1 class="text-center font-weight-bold text-primary">Sign in to Account</h1>
                    <a href="" class="btn btn-primary btn-lg btn-block myBtn" role="button">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                             class="bi bi-facebook" viewBox="0 0 20 ">
                            <path
                                    d="M16 8.049c0-4.446-3.582-8.05-8-8.05C3.58 0-.002 3.603-.002 8.05c0 4.017 2.926 7.347 6.75 7.951v-5.625h-2.03V8.05H6.75V6.275c0-2.017 1.195-3.131 3.022-3.131.876 0 1.791.157 1.791.157v1.98h-1.009c-.993 0-1.303.621-1.303 1.258v1.51h2.218l-.354 2.326H9.25V16c3.824-.604 6.75-3.934 6.75-7.951z" />
                        </svg>
                        Login with facebook
                    </a>
                    <a href="" class="btn btn-danger btn-lg btn-block myGoogleBtn" role="button">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                             class="bi bi-google" viewBox="0 0 20 20">
                            <path
                                    d="M15.545 6.558a9.42 9.42 0 0 1 .139 1.626c0 2.434-.87 4.492-2.384 5.885h.002C11.978 15.292 10.158 16 8 16A8 8 0 1 1 8 0a7.689 7.689 0 0 1 5.352 2.082l-2.284 2.284A4.347 4.347 0 0 0 8 3.166c-2.087 0-3.86 1.408-4.492 3.304a4.792 4.792 0 0 0 0 3.063h.003c.635 1.893 2.405 3.301 4.492 3.301 1.078 0 2.004-.276 2.722-.764h-.003a3.702 3.702 0 0 0 1.599-2.431H8v-3.08h7.545z" />
                        </svg>
                        Login with Google +
                    </a>
                    <hr class="my-3" />
                    <c:if test="${hasError}">
                        <div class="alert alert-danger" role="alert">
                            <h4 class="alert-heading">Login failed!</h4>
                            <p class="mb-0">${errorMessage}</p>
                        </div>
                    </c:if>
                    <form action="#" method="post" class="px-3" id="login-form">
                        <div class="input-group input-group-lg form-group">
                            <div class="input-group-prepend">
                                    <span class="input-group-text rounded-0">
                                        <i class="fa fa-user-secret fa-lg fa-fw" aria-hidden="true"></i>
                                    </span>
                            </div>
                            <input type="text" id="txtUsername" name="username" class="form-control rounded-0"
                                   placeholder="User name" required="" autofocus />
                        </div>
                        <div class="input-group input-group-lg form-group">
                            <div class="input-group-prepend">
                                    <span class="input-group-text rounded-0"><i
                                            class="fas fa-key fa-lg fa-fw"></i></span>
                            </div>
                            <input type="password" id="txtPassword" name="pass" class="form-control rounded-0"
                                   minlength="5" placeholder="Password" required autocomplete="off" />
                        </div>
                        <div class="form-group clearfix">
                            <div class="custom-control custom-checkbox float-left">
                                <input type="checkbox" class="custom-control-input" id="customCheck" name="rem" />
                                <label class="custom-control-label" for="customCheck">Remember me</label>
                            </div>
                            <div class="forgot float-right">
                                <a href="${pageContext.request.contextPath}/Account/ForgetPass" id="forgot-link">Forgot Password?</a>
                            </div>
                        </div>
                        <div class="form-group">
                            <input type="submit" id="login-btn" value="Sign In"
                                   class="btn btn-primary btn-lg btn-block myBtn" />
                        </div>
                    </form>
                </div>
                <div class="col-lg-5 d-flex flex-column justify-content-center myColor p-4">
                    <h1 class="text-center font-weight-bold text-white">Hello Friends!</h1>
                    <hr class="my-3 bg-light myHr" />
                    <p class="text-center font-weight-bolder text-light lead">
                        Enter your personal details and start your journey with us!
                    </p>
                    <a class="btn btn-outline-light btn-lg align-self-center font-weight-bolder mt-4 myLinkBtn"
                       id="register-link" role="button" href="${pageContext.request.contextPath}/Account/Register">
                        Sign Up
                        <i class="fa fa-user-plus" aria-hidden="true"></i>
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