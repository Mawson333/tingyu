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
    <title>角色管理</title>
    <%--    引入 easyui的资源--%>
    <%--    easyui的css --%>
    <link rel="stylesheet" type="text/css" href="static/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="static/themes/icon.css">
    <%--    easyui的js  --%>
    <script type="text/javascript" src="static/js/jquery.min.js"></script>
    <script type="text/javascript" src="static/js/jquery.easyui.min.js"></script>
</head>
<body>
<%--创建角色管理面板组件--%>
<div id="p" class="easyui-panel" title="角色管理"
     style="width:950px;height:500px;padding:10px;background:#fafafa;"
     data-options="closable:false,collapsible:false,minimizable:false,maximizable:false">
    <%--创建主持人信息加载的DataGrid组件--%>
    <table id="roleDataGrid"></table>
</div>

<%--创建角色更新的对话框--%>
<div id="editRoleDialog" class="easyui-dialog" title="更新角色" style="width:550px;height:500px;"
     data-options="top:50,iconCls:'icon-save',resizable:false,modal:true,closed:true">
    <%--声明对话框的布局，左边填写角色的信息，右边显示当前项目的树状菜单--%>
    <div class="easyui-layout" data-options="fit:true">
        <div data-options="region:'west',split:false,title:'角色信息',collapsible:false" style="width:300px;padding:10px;text-align: center">
            <%--创建角色更新的表单--%>
            <form id="roleEditForm"  method="post">
                <%--创建隐藏标签，记录更新的角色的Id--%>
                <input type="hidden" name="rid"  />
                <%--创建隐藏标签，记录更新的角色的菜单Id--%>
                <input type="hidden" name="mids" id="midsEdit"  />
                <%--角色名称--%>
                <div style="margin-bottom:20px;margin-top:25px;text-align: center">
                    <label>角色名称 :</label>
                    <input class="easyui-textbox" name="rname" prompt="请输入角色名称" iconWidth="28" style="width:160px;height:34px;padding:10px;">
                </div>
                <%--角色描述--%>
                <div style="margin-bottom:20px;text-align: center">
                    <label>角色描述 :</label>
                    <input class="easyui-textbox" name="rdesc" prompt="请输入角色描述" iconWidth="28" style="width:160px;height:34px;padding:10px;">
                </div>
                <%--操作按钮--%>
                <div style="margin-bottom:20px;text-align: center">
                    <a href="javascript:void(0)" id="editRoleFrom" class="easyui-linkbutton c3" style="width:120px">完成更新</a>
                </div>
            </form>
        </div>
        <div data-options="region:'center',title:'当前系统菜单'" style="padding:10px">
            <%--创建ul组件加载所有的菜单信息--%>
            <ul class="easyui-tree" id="menuEditTree" checkbox="true" data-options="url:'menu/menuAllInfoChildren'"></ul>
        </div>
    </div>
</div>

<%--创建角色增加的对话框--%>
<div id="addRoleDialog" class="easyui-dialog" title="增加角色" style="width:550px;height:500px;"
     data-options="left:150,iconCls:'icon-save',resizable:false,modal:true,closed:true">
    <%--声明对话框的布局，左边填写角色的信息，右边显示当前项目的树状菜单--%>
    <div class="easyui-layout" data-options="fit:true">
        <div data-options="region:'west',split:false,title:'角色信息',collapsible:false" style="width:300px;padding:10px;text-align: center">
            <%--创建角色增加的表单--%>
            <form id="roleAddForm"  method="post">
                <%--创建隐藏标签，记录增加的角色的菜单Id--%>
                <input type="hidden" name="mids" id="mids"  />
                <%--角色名称--%>
                <div style="margin-bottom:20px;margin-top:25px;text-align: center">
                    <label>角色名称 :</label>
                    <input class="easyui-textbox" name="rname" prompt="请输入角色名称" iconWidth="28" style="width:160px;height:34px;padding:10px;">
                </div>
                <%--角色描述--%>
                <div style="margin-bottom:20px;text-align: center">
                    <label>角色描述 :</label>
                    <input class="easyui-textbox" name="rdesc" prompt="请输入角色描述" iconWidth="28" style="width:160px;height:34px;padding:10px;">
                </div>
                <%--操作按钮--%>
                <div style="margin-bottom:20px;text-align: center">
                    <a href="javascript:void(0)" id="addRoleFrom" class="easyui-linkbutton c3" style="width:120px">完成增加</a>
                </div>
            </form>
        </div>
        <div data-options="region:'center',title:'当前系统菜单'" style="padding:10px">
            <%--创建ul组件加载所有的菜单信息--%>
            <ul class="easyui-tree" id="menuTree" checkbox="true" data-options="url:'menu/menuAllInfoChildren'"></ul>
        </div>
    </div>
</div>

<%--创建角色管理DataGrid的工具栏--%>
<div id="roleToolBar">
    <a id="addRole" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加角色</a>
    <a id="editRole" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">更新角色</a>
    <a id="delRole" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cut',plain:true">删除角色</a>
</div>

<script>
    //datagrid 初始化数据
    $("#roleDataGrid").datagrid({
        url:"role/roleInfo",//设置远程连接
        pagination:true,// 分页导航条
        rownumbers:true, // 显示行号
        pageNumber:1,
        pageSize:3,
        checkOnSelect:false,  // 选中checkBox 才选中一行数据
        pageList:[3,6],
        title:"查询结果",
        toolbar:"#roleToolBar",
        columns:[[
            //表示 一列数据  并且 设置列和数据的映射关系
            {field:"aa",checkbox:true},
            {title:"角色编号",field: "rid",width:270,align:'center'},
            {title:"角色名称",field: "rname",width:270,align:'center'},
            {title:"角色描述",field: "rdesc",width:270,align:'center'}
        ]]
    });

    //添加角色
    $("#addRole").click(function () {
        $("#addRoleDialog").dialog("open");
    })

    //提交添加角色表单
    $("#addRoleFrom").click(function () {

        //拿到选中标签id
        var nodes = $("#menuTree").tree('getChecked', ['checked', 'indeterminate']);
        //记录id
        var mids = "";
        if (nodes.length > 0){
            for (var i = 0; i < nodes.length; i++) {
                mids += nodes[i].id + ",";
            }
        }
        //把菜单id 数据记录在表单的隐藏标签中  提交到服务器
        $("#mids").val(mids);

        $("#roleAddForm").form(
            'submit',
            {
                url: "role/roleAdd",
                success:function (data) {
                    //把data转成 json
                    var d = JSON.parse(data);
                    if (d.success){
                        $.messager.alert("提示","角色增加成功","info");
                        //关闭对话框
                        $("#addRoleDialog").dialog('close');
                        //清除表单数据
                        $("#roleAddForm").form('clear');
                        //重新加载menuTree
                        $("#menuTree").tree('reload');
                        //重新加载角色 的datagrid
                        $("#roleDataGrid").datagrid('reload');
                    }else {
                        $.messager.alert("提示", "角色增加失败", "info");
                    }
                }
            }
        )
    })

    //修改角色
    $("#editRole").click(function () {
        // 校验 用户是否选中 更新的角色信息
        var tr = $("#roleDataGrid").datagrid('getChecked');
        console.log(tr)
        if (tr.length == 1){
            //数据回显
            var obj = tr[0];
            //将角色信息回显在表单中
            $("#roleEditForm").form('load',tr[0]);

            var mids = tr[0].mids;

            for (var i = 0; i < mids.length; i++) {
                var node = $("#menuEditTree").tree('find',mids[i]);
                if (node != null){
                    $("#menuEditTree").tree('check',node.target);
                }
            }
            //显示角色更新的对话框
            $("#editRoleDialog").dialog('open');
        }else if (tr.length > 1){
            $.messager.alert("提示","只能选择一个角色信息","info");
        }else{
            $.messager.alert("提示","请选择一个角色","info");
        }
    })

    //修改角色表单提交
    $("#editRoleFrom").click(function () {
        // 获取 当前角色分配的菜单 id数据
        var nodes = $("#menuEditTree").tree('getChecked',['checked']);
        var mids= "";

        if (nodes.length){
            for (var i = 0; i < nodes.length; i++) {
                mids+=nodes[i].id + ",";
            }
            // 将 id数据记录在表单的隐藏标签中
            $("#midsEdit").val(mids);
            //异步提交表单
            $("#roleEditForm").form(
                'submit',
                {
                    url:"role/roleEdit",
                    success:function (data) {
                        var d = JSON.parse(data);
                        if (d.success){
                            $.messager.alert("提示","角色更新成功","info");
                            //关闭角色修改对话框
                            $("#editRoleDialog").dialog('close');
                            // 重新加载角色的 datagrid 数据
                            $("#roleDataGrid").datagrid('reload');
                            //重新加载menuTree
                            $("#menuEditTree").tree('reload');
                        }else{
                            //角色更新失败
                            $.messager.alert("提示","角色更新失败","info");
                        }
                    }
                }

            )
        }
    })

    //删除角色
    $("#delRole").click(function () {
        // 校验 用户是否选中 删除的角色信息
        var trs = $("#roleDataGrid").datagrid('getChecked');

        if(trs.length > 0 ){
            $.messager.confirm("提示","确认删除此角色?",function (r) {
                if (r){
                    // 获取要删除的角色id
                    var rids = "";
                    for(var i = 0 ; i < trs.length ; i++){
                        rids += trs[i].rid + ",";
                    }
                    //发送ajax
                    $.get(
                        "role/roleDel",
                        {rids:rids},
                        function (data) {
                            if(data.success){
                                $.messager.alert("提示","删除成功")
                                // dataGrid 更新数据
                                $("#roleDataGrid").datagrid('reload');
                            }
                        }
                    )
                }
            })
        }else{
            $.messager.alert("提示","请选择要删除的角色","info");
        }
    })
</script>
</body>
</html>
