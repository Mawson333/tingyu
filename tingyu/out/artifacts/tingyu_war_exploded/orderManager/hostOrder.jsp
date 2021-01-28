<%--
  Created by IntelliJ IDEA.
  User: Mawson
  Date: 2021/1/18 0018
  Time: 19:54
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
    <title>成员订单中心</title>
    <%--    引入 easyui的资源--%>
    <%--    easyui的css --%>
    <link rel="stylesheet" type="text/css" href="static/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="static/themes/icon.css">
    <%--    easyui的js  --%>
    <script type="text/javascript" src="static/js/jquery.min.js"></script>
    <script type="text/javascript" src="static/js/jquery.easyui.min.js"></script>
</head>
<body>

<div id="p" class="easyui-panel" title="订单中心"
     style="width:900px;height:500px;padding:10px;background:#fafafa;"
     data-options="closable:false,collapsible:false,minimizable:false,maximizable:false">

    <%--创建主持人信息加载的DataGrid组件--%>
    <table id="orderDataGrid"></table>
</div>

<%--创建订单增加的对话框--%>
<div id="addOrderDialog" class="easyui-dialog" title="添加订单" style="width:400px;height:350px;"
     data-options="left:150,iconCls:'icon-save',resizable:false,modal:true,closed:true">
    <%--声明对话框的布局，左边填写角色的信息，右边显示当前项目的树状菜单--%>
    <div class="easyui-layout" data-options="fit:true">
        <%--创建角色增加的表单--%>
        <form id="orderAddForm" method="post">
            <%--角色名称--%>
            <div style="margin-bottom:20px;margin-top:35px;text-align: center">
                <label>酒店名称 :</label>
                <input class="easyui-textbox" name="hotelname" prompt="请输入酒店名称" iconWidth="28"
                       style="width:160px;height:34px;padding:10px;">
            </div>
            <%--角色描述--%>
            <div style="margin-bottom:20px;text-align: center">
                <label>婚礼地点 :</label>
                <input class="easyui-textbox" name="hoteladdress" prompt="请输入婚礼地点" iconWidth="28"
                       style="width:160px;height:34px;padding:10px;">
            </div>
            <div style="margin-bottom:20px;text-align: center">
                <label>婚礼费用 :</label>
                <input class="easyui-textbox" name="money" prompt="请输入婚礼费用" iconWidth="28"
                       style="width:160px;height:34px;padding:10px;">
            </div>
            <%--操作按钮--%>
            <div style="margin-bottom:20px;text-align: center">
                <a href="javascript:void(0)" id="addOrderFrom" class="easyui-linkbutton c3"
                   style="width:120px">添加订单</a>
            </div>
        </form>
    </div>
</div>

<%--创建订单修改的对话框--%>
<div id="editOrderDialog" class="easyui-dialog" title="修改订单" style="width:400px;height:350px;"
     data-options="left:150,iconCls:'icon-save',resizable:false,modal:true,closed:true">
    <%--声明对话框的布局，左边填写角色的信息，右边显示当前项目的树状菜单--%>
    <div class="easyui-layout" data-options="fit:true">
        <%--创建角色增加的表单--%>
        <form id="orderEditForm" method="post">
            <input name="oid" hidden>
            <%--角色名称--%>
            <div style="margin-bottom:20px;margin-top:35px;text-align: center">
                <label>酒店名称 :</label>
                <input class="easyui-textbox" name="hotelname" prompt="请输入酒店名称" iconWidth="28"
                       style="width:160px;height:34px;padding:10px;">
            </div>
            <%--角色描述--%>
            <div style="margin-bottom:20px;text-align: center">
                <label>婚礼地点 :</label>
                <input class="easyui-textbox" name="hoteladdress" prompt="请输入婚礼地点" iconWidth="28"
                       style="width:160px;height:34px;padding:10px;">
            </div>
            <div style="margin-bottom:20px;text-align: center">
                <label>婚礼费用 :</label>
                <input class="easyui-textbox" name="money" prompt="请输入婚礼费用" iconWidth="28"
                       style="width:160px;height:34px;padding:10px;">
            </div>
            <%--操作按钮--%>
            <div style="margin-bottom:20px;text-align: center">
                <a href="javascript:void(0)" id="editOrderFrom" class="easyui-linkbutton c3"
                   style="width:120px">修改订单</a>
            </div>
        </form>
    </div>
</div>

<%--创建订单中心的DataGrid的工具栏--%>
<div id="orderToolBar">
    <a id="addOrder" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加订单</a>
    <a id="editOrder" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">更新订单</a>
    <a id="delOrder" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cut',plain:true">删除订单</a>
</div>

<script>
    $("#orderDataGrid").datagrid(
        {
            url: "order/orderInfo",//设置远程加载数据的地址
            pagination: true,                //在表格中显示分页工具栏，将此属性设置为true，就会发送ajax分页请求获取要加载的数据
            rownumbers: true,                //显示行号
            // pageNumber:1,                   //设置ajax分页查询的默认页码数
            // pageSize:3,                     //设置每页显示的数量
            checkOnSelect: false,            //设置点击行的任意位置不会选择该行，只有点击复选框时菜单选择
            // pageList:[3,6],                 //设置每页数据量下拉框框中的数据
            title: "查询结果",                 //显示标题
            toolbar: "#orderToolBar",
            columns:                        //设置表格的列以及每列和加载的数据的映射关系
                [[
                    //表示一列，并且设置该列和数据的映射关系
                    {field:"aa",checkbox:true},
                    {title: "订单编号", field: "oid", width: 100, align: 'center'},
                    {title: "酒店名称", field: "hotelname", width: 150, align: 'center'},
                    {title: "婚礼地点", field: "hoteladdress", width: 100, align: 'center'},
                    {
                        title: "新人婚期", field: "ordertime", width: 150, align: 'center',
                        formatter: function (value, rows, rowIndex) {
                            return value.year + "-" + value.monthValue + "-" + value.dayOfMonth
                        }
                    },
                    {title: "婚礼费用", field: "money", width: 100, align: 'center'},
                    {
                        title: "订单状态", field: "status", width: 100, align: 'center',
                        formatter: function (value, rows, rowIndex) {
                            return value == "1" ? "正常" : "异常"
                        }
                    },
                    {
                        title: "评价", field: "comment", width: 100, align: 'center',
                        formatter: function (value, rows, rowIndex) {
                            return value == "1" ? "好评" : "差评"
                        }
                    },
                ]]
        }
    )
    //添加订单
    $("#addOrder").click(function () {
        $("#addOrderDialog").dialog("open");
    })
    //添加订单表单提交
    $("#addOrderFrom").click(function () {
        $("#orderAddForm").form(
            'submit',
            {
                url:"order/orderAdd",
                success:function (data) {
                    //转为json
                    var d = JSON.parse(data);
                    if (d.success){
                        $.messager.alert("提示",d.msg,"info");
                        //关闭对话框
                        $("#addOrderDialog").dialog('close');
                        //清除表单数据
                        $("#orderAddForm").form('clear');
                        //重新加载角色 的datagrid
                        $("#orderDataGrid").datagrid('reload');
                    }else {
                        $.messager.alert("提示", d.msg, "info");
                    }
                }
            }
        )
    })

    //修改订单
    $("#editOrder").click(function () {
        //拿到datagrid的数据
        var trs = $("#orderDataGrid").datagrid('getChecked');

        if (trs.length == 1) {
            // 02 在编辑dialog展示数据
            $("#orderEditForm").form('load', trs[0]);
            $("#editOrderDialog").dialog("open")

        } else if (trs.length > 1) {
            $.messager.alert("提示", "只能选择一个公司进行修改", "info")
        } else {
            $.messager.alert("提示", "请选择一个公司进行修改", "info")
        }
    })

    //修改表单的提交
    $("#editOrderFrom").click(function () {
        $("#orderEditForm").form(
            'submit',
            {
                url:"order/orderUpdate",
                success:function (data) {
                    //转为json
                    var d = JSON.parse(data);
                    if (d.success){
                        $.messager.alert("提示",d.msg ,"info");
                        //关闭对话框
                        $("#editOrderDialog").dialog('close');
                        //清除表单数据
                        $("#orderEditForm").form('clear');
                        //重新加载角色 的datagrid
                        $("#orderDataGrid").datagrid('reload');
                    }else {
                        $.messager.alert("提示", d.msg , "info");
                    }
                }
            }
        )
    })

    //删除订单
    $("#delOrder").click(function () {
        //拿到datagrid的数据
        var trs = $("#orderDataGrid").datagrid('getChecked');
        if (trs.length == 1) {
            var oid = trs[0].oid;
            $.messager.confirm("提示","确认删除此角色?",function (r) {
                    if (r){
                        //发送ajax
                        $.get(
                            "order/orderDel",
                            {oid:oid},
                            function (data) {
                                if(data.success){
                                    $.messager.alert("提示",data.msg)
                                    // dataGrid 更新数据
                                    $("#orderDataGrid").datagrid('reload');
                                }
                            }
                        )
                    }
                }
            )
        } else if (trs.length > 1) {
            $.messager.alert("提示", "只能选择一个订单进行删除", "info")
        } else {
            $.messager.alert("提示", "请选择一个订单进行删除", "info")
        }
    })

</script>


</body>
</html>
