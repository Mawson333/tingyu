<%--
  Created by IntelliJ IDEA.
  User: Mawson
  Date: 2021/1/12 0012
  Time: 19:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%--  设置根目录   --%>
<base href="<%=basePath %>"/>
<html>
<head>
    <title>注册页面</title>
    <link rel='stylesheet' href='static/css/font-awesome.min.css'>
    <!--核心样式-->
    <link rel="stylesheet" href="static/css/style.css">
    <script src='static/js/jquery.min.js'></script>
    <%--    easyui的js  --%>
    <script type="text/javascript" src="static/js/jquery.easyui.min.js"></script>
</head>
<body>
<div class="container">
    <div class="card"></div>
    <div class="card">
        <h1 class="title">用户注册</h1>
        <form id="registeredFormId" method="post">
            <div class="input-container">
                <input type="text" id="username" name="aname" required="required"/>
                <label for="username">用户名:</label>
                <div class="bar"></div>
            </div>
            <div class="input-container">
                <input type="password" id="pwd" name="apwd" required="required"/>
                <label for="pwd">密&nbsp;&nbsp;&nbsp;码:</label>
                <div class="bar"></div>
            </div>
            <div class="input-container">
                <input type="text" id="aphone" name="aphone" required="required" />
                <label for="aphone">手机号:</label>
                <div class="bar"></div>
            </div>
            <div class="button-container">
                <button id="btn"><span>提交注册</span></button>
            </div>
        </form>
    </div>
</div>

<script>
    //拿到表单 提交
    $("#btn").click(function () {
        // jq表单提交数据
        $("#registeredFormId").form(
            'submit',
            {
                url: "admin/registered",
                success:function (data) {
                    var d = JSON.parse(data);
                    if (d.success){
                        // 信息提示
                        alert(d.msg);
                        // 重定向到登录页面
                        window.location.href="login.jsp";
                    }
                }
            }
        )
        return false;
    })
</script>
</body>
</html>
