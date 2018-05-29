<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>登录</title>
    <meta charset="utf-8"/>
    <link rel="stylesheet" type="text/css" href="../../css/login.css" />
    <link rel="stylesheet" type="text/css" href="../../css/style2.css" />

</head>
<body>
<div class="login-container">
    <div class="login-aside">
        <div class="logo">
            <h1>SimHash</h1>
        </div>
        <div class="descri">
            <h2>基于超算平台的涉密文档分析平台</h2>
        </div>
    </div>
    <div class="login-content">
        <div class="content-heading">
            <h2>登录</h2>
        </div>
        <div class="content-body">
            <form id="slick-login" action="${pageContext.request.contextPath}/my/verify/login_verify" method="post">
                <div class="input-wrapper">
                    <input type="text" id="name" name="name" placeholder="账户名" required="required"
                           autofocus="autofocus">
                    <label for="name" class="fa fa-envelope" aria-hidden="true"></label>
                </div>
                <div class="input-wrapper">
                    <input type="password" id="passwd" name="passwd" placeholder="密码" required="required">
                    <label for="passwd" class="fa fa-lock fa-lg" aria-hidden="true"></label>
                </div>
                <div class="checkcode-wrapper input-wrapper">
                    <input type="text" id="command" name="command" placeholder="动态口令">
                </div>
                <input class="submit" type="submit" value="登录">
            </form>
        </div>
    </div>
</div>
</body>
</html>