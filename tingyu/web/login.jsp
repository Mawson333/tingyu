<%--
  Created by IntelliJ IDEA.
  User: Mawson
  Date: 2021/1/8 0008
  Time: 16:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>登录页面</title>
    <link rel='stylesheet' href='static/css/font-awesome.min.css'>
    <!--核心样式-->
    <link rel="stylesheet" href="static/css/style.css">
    <script src='static/js/jquery.min.js'></script>
</head>
<body>
<%-- 验证登录是否成功 --%>
<%--<c:if test="${sessionScope.msg != null}">
    <script>alert("${sessionScope.msg}")</script>
</c:if>--%>

<div class="container">
    <div class="card"></div>
    <div class="card">
        <h1 class="title">用户登录</h1>
        <form id="loginFormId" method="post" action="admin/login">
            <div class="input-container">
                <input type="text" id="username" name="aname" required="required"/>
                <label for="username">用户名</label>
                <div class="bar"></div>
            </div>
            <div class="input-container">
                <input type="password" id="pwd" name="apwd" required="required"/>
                <label for="pwd">密码</label>
                <div class="bar"></div>
            </div>
            <div class="button-container">
                <button id="btn"><span>登录</span></button>
            </div>
        </form>
    </div>
</div>

<script>

    //拿到表单 提交
    $("#btn").click(function () {
        // jq表单提交数据
        $("#loginFormId").submit();
    })

</script>

</body>
</html>
