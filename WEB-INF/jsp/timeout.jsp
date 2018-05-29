<%--
  Created by IntelliJ IDEA.
  User: flyout
  Date: 2018/3/3
  Time: 下午3:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户已在其他地方登陆</title>
</head>
<body>
    <script language="JavaScript">
        alert("用户已在其他地方登陆，请重新登陆。");
        setTimeout(function () {
            window.top.location.href="./login"
        })
    </script>
</body>
</html>
