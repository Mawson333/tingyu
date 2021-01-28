<%--
  Created by IntelliJ IDEA.
  User: Mawson
  Date: 2021/1/8 0008
  Time: 19:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>主页</title>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
    <%--  设置根目录   --%>
    <base href="<%=basePath%>"/>
    <%--    导入 easyui的资源--%>
    <%--    easyui的css --%>
    <link rel="stylesheet" type="text/css" href="static/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="static/themes/icon.css">
    <%--    easyui的js  --%>
    <script type="text/javascript" src="static/js/jquery.min.js"></script>
    <script type="text/javascript" src="static/js/jquery.easyui.min.js"></script>

</head>
<body>

<div style="padding: 12px;height: 100%;width: 100%">
    <div id="cc" class="easyui-layout" data-options="fit:true" style="">
        <div data-options="region:'north',title:'North Title',split:false,collapsible:false,noheader:true" style="height:100px;">

            <%--使用layout的嵌套布局，将头部分为，西，中，东三部分--%>
            <div class="easyui-layout" data-options="fit:true">
<%--                <div data-options="region:'west',border:false" style="width:20%;text-align: center;background-image: url('static/images/bg.png');overflow: hidden">
                    &lt;%&ndash;显示网站的logo&ndash;%&gt;
                    <img src="static/images/logo.png" style="margin-left: 10px;margin-top: 5px; display:block; width:90%; height:96%;padding: 12px 2px">
                </div>--%>
                <div data-options="region:'center',border:false" style="background-image: url('static/images/bg.png');text-align: center">
                    <%--声明网站的标题--%>
                    <span style="color: beige;font-size: 25px;position: relative;line-height: 98px;">
                        Ting&nbsp;&nbsp;&nbsp;域&nbsp;&nbsp;&nbsp;主&nbsp;&nbsp;&nbsp;持&nbsp;&nbsp;&nbsp;人&nbsp;&nbsp;&nbsp;
                        后&nbsp;&nbsp;&nbsp;台&nbsp;&nbsp;&nbsp;管&nbsp;&nbsp;&nbsp;理&nbsp;&nbsp;&nbsp;系&nbsp;&nbsp;&nbsp;统
                    </span>
                </div>
                <div data-options="region:'east',border:false" style="width:20%;background-image: url('static/images/bg.png');">
                    <%--设置网站登录信息--%>
                    <span style="position: relative;top:40px;font-size:15px;">
                        <span style="color: beige">您好，${sessionScope.admin.aname}</span>
                        &nbsp;&nbsp;&nbsp;
                        <span><a href="admin/logout"  style="color: beige;text-decoration: none">退出</a></span>
                    </span>
                </div>
            </div>
        </div>
        <div data-options="region:'west',title:'菜单系统',split:false,collapsible:false" style="width:240px;">
            <%--            使用easy的tree 异步加载数据
                             01 请求服务器的数据
                             02 服务器要给你返回指定的数据
                                请求服务器的地址:
                             到了指定的页面 自动发送请求 查询 服务器的数据
                             如果是父节点, 点开父节点 会自动发送请求查询子节点
            --%>
            <ul id="myMenu" class="easyui-tree" data-options="url:'menu/menuInfo'">
            </ul>
        </div>

        <div data-options="region:'center',title:'主页',split:false,collapsible:false"
             style="padding:5px;background:#eee;">
            <div id="menuTabs" class="easyui-tabs" data-options="fit:true">

            </div>
        </div>
    </div>
</div>

<script>
    // 给 tree节点添加点击事件
    $("#myMenu").tree({
        // 判断是否是父节点  子节点才切换 tab
        onClick:function (node) {
            console.log(node);
            if (node != null){
                //子节点
                if (node.attributes.isparent == "0"){
                    // 判断 tab是否存在 tab选项卡
                    // exists 通过 index 和title 判断 tab选项卡是否存在
                    var flag = $("#menuTabs").tabs("exists",node.text);

                    if (flag){
                        $("#menuTabs").tabs("select",node.text);
                    } else {
                        //创建和选中
                        $("#menuTabs").tabs(
                            'add',
                            {
                                title:node.text,    //标题
                                selected:true,      //是否选中
                                closable:true,        //是否可以关闭
                                // content 这里可以放html代码
                                // 存放一个iframe 标签 在这里可以嵌套一个页面
                                content:"<iframe src='"+ node.attributes.url+"' width='99%' height='99%' style='border: none'></iframe>"  // 文本的显示++++++
                            }
                        )
                    }

                }
            }


        }
    })

</script>

</body>
</html>
