<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
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
    <div class="row justify-content-center wrapper" id="register-box">
        <div class="col-lg-10 my-auto myShadow">
            <div class="row">
                <div class="col-lg-5 d-flex flex-column justify-content-center myColor p-4">
                    <h1 class="text-center font-weight-bold text-white">Welcome Back!</h1>
                    <hr class="my-4 bg-light myHr" />
                    <p class="text-center font-weight-bolder text-light lead">To keep connected with us please login
                        with your personal info.</p>
                    <a href="${pageContext.request.contextPath}/Account/Login"
                       class="btn btn-outline-light btn-lg font-weight-bolder mt-4 align-self-center myLinkBtn"
                       id="login-link" role="button">Sign In</a>
                    <a class="btn btn-outline-light btn-lg align-self-center font-weight-bolder mt-4 myLinkBtn"
                       role="button" href="${pageContext.request.contextPath}/Home/">
                        Back home
                        <i class="fa fa-home" aria-hidden="true"></i>
                    </a>
                </div>
                <div class="col-lg-7 bg-white p-4">
                    <h1 class="text-center font-weight-bold text-primary">Create Account</h1>
                    <hr class="my-3" />
                    <form action="#" method="post" class="px-3" id="frmRegister">
                        <div class="input-group input-group-lg form-group">
                            <div class="input-group-prepend">
                                    <span class="input-group-text rounded-0">
                                        <i class="fa fa-user-secret fa-lg fa-fw" aria-hidden="true"></i>
                                    </span>
                            </div>
                            <input type="text" class="form-control rounded-0" placeholder="Username" name="username"
                                   id="txtUsername" required="" autofocus/>
                        </div>
                        <div class="input-group input-group-lg form-group">
                            <div class="input-group-prepend">
                                    <span class="input-group-text rounded-0"><i
                                            class="far fa-user fa-lg fa-fw"></i></span>
                            </div>
                            <input type="text" name="fullname" id="txtFullname" class="form-control rounded-0"
                                   placeholder="Full Name" required />
                        </div>
                        <div class="input-group input-group-lg form-group">
                            <div class="input-group-prepend">
                                    <span class="input-group-text rounded-0">
                                        <i class="fa fa-birthday-cake fa-lg fa-fw" aria-hidden="true"></i>
                                    </span>
                            </div>
                            <input type="date" name="dob" id="txtDoB" class="form-control rounded-0"
                                   placeholder="Full Name" required />
                        </div>
                        <div class="input-group input-group-lg form-group">
                            <div class="input-group-prepend">
                                    <span class="input-group-text rounded-0">
                                        <i class="fa fa-address-card fa-lg fa-fw" aria-hidden="true"></i>
                                    </span>
                            </div>
                            <input type="text" name="address" id="txtAddress" class="form-control rounded-0"
                                   placeholder="Address" required="" />
                        </div>
                        <div class="input-group input-group-lg form-group">
                            <div class="input-group-prepend">
                                    <span class="input-group-text rounded-0"><i
                                            class="far fa-envelope fa-lg fa-fw"></i></span>
                            </div>
                            <input type="email" name="email" id="txtEmail" class="form-control rounded-0"
                                   placeholder="E-Mail" required />
                        </div>
                        <div class="input-group input-group-lg form-group">
                            <div class="input-group-prepend">
                                    <span class="input-group-text rounded-0"><i
                                            class="fas fa-key fa-lg fa-fw"></i></span>
                            </div>
                            <input type="password" name="rawpass" id="txtPassword" class="form-control rounded-0"
                                   minlength="5" placeholder="Password" required />
                        </div>
                        <div class="input-group input-group-lg form-group">
                            <div class="input-group-prepend">
                                    <span class="input-group-text rounded-0"><i
                                            class="fas fa-key fa-lg fa-fw"></i></span>
                            </div>
                            <input type="password" id="txtConfirmPass" class="form-control rounded-0" minlength="5"
                                   placeholder="Confirm Password" required />
                        </div>
                        <div class="form-group">
                            <div id="passError" class="text-danger font-weight-bolder"></div>
                        </div>
                        <div class="form-group">
                            <input type="submit" id="register-btn" value="Sign Up"
                                   class="btn btn-primary btn-lg btn-block myBtn" />
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>

</html>