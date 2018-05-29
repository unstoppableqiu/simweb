<%--
  Created by IntelliJ IDEA.
  User: flyout
  Date: 2018/3/8
  Time: 下午6:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注销登陆</title>
</head>
<body>
    <% session.invalidate(); %>
    <script type="text/javascript">
        window.location.href="./login";
    </script>
</body>
</html>
