<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>   
<!DOCTYPE html>
<html>
<head>
    <title>管理员界面</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style2.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adminindex.css" />
    <script src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
    <script>
   	$(function(){
   		$('#account').click(function(){
        	window.location.href="./user_manage.jsp"
        });   
        $('#task').click(function(){
        	window.location.href="task_manage.jsp"
        });   
        $('#resource').click(function(){
        	window.location.href="resource_manage.jsp"
        });   
     });
    </script>
</head>
<body>
    <%@include file="head.jsp" %>
    <div class="main">
        <div class="serve" id='account'>
            <img src="${pageContext.request.contextPath}/image/account.png"><br>
            <div class="serve_name">账号管理</div>
        </div>
        <div class="serve" id='task'>
            <img src="${pageContext.request.contextPath}/image/task.png"><br>
            <div class="serve_name">任务管理</div>
        </div>
        <div class="serve" id='resource'>
            <img src="${pageContext.request.contextPath}/image/resource.png"><br>
            <div class="serve_name">计算资源管理</div>
        </div>
    </div>
    <footer class="copyright">
        © SimHash 基于超算平台的涉密文档分析平台
    </footer>
</body>
</html>