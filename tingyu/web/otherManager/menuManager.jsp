<%--
  Created by IntelliJ IDEA.
  User: Mawson
  Date: 2021/1/12 0012
  Time: 15:55
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
    <title>菜单管理</title>
    <%--    引入 easyui的资源--%>
    <%--    easyui的css --%>
    <link rel="stylesheet" type="text/css" href="static/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="static/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="static/themes/color.css">
    <%--    easyui的js  --%>
    <script type="text/javascript" src="static/js/jquery.min.js"></script>
    <script type="text/javascript" src="static/js/jquery.easyui.min.js"></script>
</head>
<body>

<%--创建菜单管理面板，并完成嵌套布局效果--%>
<div class="easyui-panel" style="width:900px;height:600px;padding:10px;">
    <div id="cc" class="easyui-layout" style="width:860px;height:550px;">
        <div data-options="region:'west',title:'操作',split:false,collapsible:false" style="width:260px;text-align: center;padding-top: 20px">
            <a  id="menuAdd" href="javascript:void(0)" class="easyui-linkbutton c1" style="width:120px;margin: 20px;">增加菜单</a>
            <a  id="editMenu" href="javascript:void(0)" class="easyui-linkbutton c2" style="width:120px;margin: 20px;">编辑菜单</a>
            <a id="delMenu"  href="javascript:void(0)" class="easyui-linkbutton c3" style="width:120px;margin: 20px;">删除菜单</a>
            <%--            <a href="#" class="easyui-linkbutton c4" style="width:120px;margin: 15px;">刷新菜单</a>--%>
        </div>
        <div data-options="region:'center',title:'系统菜单'" style="padding:5px;background:#eee;">
            <%--创建ul组件加载所有的菜单信息--%>
            <ul class="easyui-tree" id="menuTree" data-options="url:'menu/menuAllInfo'"></ul>
        </div>
    </div>
</div>

<%--创建增加菜单信息的对话框--%>
<div id="addMenuDialog" class="easyui-dialog" title="增加菜单" style="width:400px;height:300px;"
     data-options="iconCls:'icon-save',resizable:false,modal:true,closed:true">
    <%--创建菜单增加的表单--%>
    <form id="menuAddForm"  method="post">
        <%--创建隐藏标签记录要增加的菜单的上级ID--%>
        <input type="hidden" id="pid" name="pid" value="">
        <%--菜单名称--%>
        <div style="margin-bottom:20px;margin-top:25px;text-align: center">
            <label>菜单名称：</label>
            <input class="easyui-textbox" name="mname" prompt="请输入菜单名称" iconWidth="28" style="width:200px;height:34px;padding:10px;">
        </div>
        <%--菜单的url地址--%>
        <div style="margin-bottom:20px;text-align: center">
            <label>资源地址：</label>
            <input  class="easyui-textbox" name="url;" prompt="请输入资源地址" iconWidth="28" style="width:200px;height:34px;padding:10px">
        </div>
        <%--菜单的描述--%>
        <div style="margin-bottom:20px;text-align: center">
            <label>菜单描述：</label>
            <input class="easyui-textbox" name="mdesc" prompt="请输入菜单描述" iconWidth="28" style="width:200px;height:34px;padding:10px;">
        </div>
        <%--操作按钮--%>
        <div style="margin-bottom:20px;text-align: center">
            <a href="javascript:void(0)" id="addMenuFrom" class="easyui-linkbutton c3" style="width:120px">完成添加</a>
        </div>
    </form>
</div>

<%--创建编辑菜单信息的对话框--%>
<div id="EditMenuDialog" class="easyui-dialog" title="编辑菜单" style="width:400px;height:300px;"
     data-options="iconCls:'icon-save',resizable:false,modal:true,closed:true,top:100,left:240">
    <%--创建菜单增加的表单--%>
    <form id="menuEditForm"  method="post">
        <%--创建隐藏标签，记录要更新的菜单的ID--%>
        <input type="hidden" name="mid">
        <%--菜单名称--%>
        <div style="margin-bottom:20px;margin-top:25px;text-align: center">
            <input class="easyui-textbox" name="mname" prompt="请输入菜单名称" iconWidth="28" style="width:300px;height:34px;padding:10px;">
        </div>
        <%--菜单的url地址--%>
        <div style="margin-bottom:20px;text-align: center">
            <input  class="easyui-textbox" name="url" prompt="请输入资源地址" iconWidth="28" style="width:300px;height:34px;padding:10px">
        </div>
        <%--菜单的描述--%>
        <div style="margin-bottom:20px;text-align: center">
            <input class="easyui-textbox" name="mdesc" prompt="请输入菜单描述" iconWidth="28" style="width:300px;height:34px;padding:10px;">
        </div>
        <%--操作按钮--%>
        <div style="margin-bottom:20px;text-align: center">
            <a href="javascript:void(0)" id="editMenuFrom" class="easyui-linkbutton c3" style="width:120px">完成更新</a>
        </div>
    </form>
</div>

<script>

    //添加菜单
    $("#menuAdd").click(function () {
        // 拿到选中的节点 如果没有为null
        var node = $("#menuTree").tree('getSelected');

        if (node != null){
            //选中，提交pid
            $("#pid").val(node.id);
        }
        //展示添加dialog
        $("#addMenuDialog").dialog('open');
    })

    //添加菜单表单的提交
    $("#addMenuFrom").click(function () {
        $("#menuAddForm").form(
            'submit',
            {
                url:"menu/menuAdd",
                success:function (data) {
                    var d = JSON.parse(data);
                    //更新的判断
                    if (d.success){
                        // 01 信息提示
                        $.messager.alert("提示",d.msg, "info")
                        // 02 dialog 关闭
                        $("#addMenuDialog").dialog('close');
                        // 03 表单的清理
                        $("#menuAddForm").form("clear");
                        // 04  tree的刷新
                        // reload target 重新加载树的数据。
                        $("#menuTree").tree('reload');
                    }
                }
            }
        )
    })

    //给编辑菜单按钮 增加点击事件
    $("#editMenu").click(function () {
        // 拿到选中的节点 如果没有为null
        var node = $("#menuTree").tree('getSelected');
        console.log(node)
        if (node != null){
            //回显菜单 数据到表单中
            $("#menuEditForm").form(
                'load',
                {
                    mid:node.id,
                    mname:node.text,
                    url: node.attributes.url,
                    mdesc:node.attributes.mdesc
                },
                //显示编辑菜单的 dialog
                $("#EditMenuDialog").dialog("open")
            )
        }else{
            $.messager.alert("提示","请选择需要编辑的菜单","info");
        }
    })

    //编辑菜单表单的提交
    $("#editMenuFrom").click(function () {
        $("#menuEditForm").form(
            'submit',
            {
                url:"menu/meunEdit",
                success:function (data) {
                    var d = JSON.parse(data);
                    if (d.success){
                        $.messager.alert("提示","更新成功","info");
                        //刷新异步树
                        $("#menuTree").tree('reload');
                        //关闭 对话框
                        $("#EditMenuDialog").dialog('close');
                    }else{
                        $.messager.alert("提示","更新失败","info");
                    }
                }
            }
        )
    })

    //删除菜单
    $("#delMenu").click(function () {
        // 拿到选中的节点 如果没有为null
        var node = $("#menuTree").tree('getSelected');

        if (node != null){
            // 确认框是否要删除
            $.messager.confirm("提示","确认删除此菜单吗",
                function (r) {
                    //确认后发送ajax
                    $.post(
                        "menu/menuDel",
                        {
                            mid:node.id,
                            pid:node.attributes.pid
                        },
                        function (data) {
                            if (data.success){
                                $.messager.alert("提示","删除成功","info");
                                //重新加载菜单树
                                $("#menuTree").tree('reload');
                            }
                        },
                        "json"
                    )
            })
        } else {
            $.messager.alert("提示","请选中一个菜单删除","info")
        }
    })
</script>

</body>
</html>
