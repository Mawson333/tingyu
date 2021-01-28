<%--
  Created by IntelliJ IDEA.
  User: scott
  Date: 0009
  Time: 9:48
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
    <title>婚庆公司</title>
    <%--    引入 easyui的资源--%>
    <%--    easyui的css --%>
    <link rel="stylesheet" type="text/css" href="static/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="static/themes/icon.css">
    <%--    easyui的js  --%>
    <script type="text/javascript" src="static/js/jquery.min.js"></script>
    <script type="text/javascript" src="static/js/jquery.easyui.min.js"></script>
</head>
<body>
<%--    婚庆公司的数据 展示 dataGrid --%>
<div style="height: 99%;width: 99%">
    <%--  条件查询  --%>
    <div style="text-align: center">
        <form id="" class="">
            <%--            条件 公司名称 --%>
            <input id="cname" class="easyui-textbox" type="text" data-options="prompt:'姓名'" style="width:100px">
            <%--        条件 公司账号状态   --%>
            <select id="status" data-options="panelHeight:'auto',editable:false,value:'状态'" class="easyui-combobox"
                    style="width:100px;">
                <option value="1">正常</option>
                <option value="0">禁用</option>
            </select>
            <%--        条件 权重
              --%>
            <select id="ordernumber" data-options="panelHeight:'auto',editable:false,value:'订单量排序'"
                    class="easyui-combobox"
                    style="width:100px;">
                <option value="asc">升序</option>
                <option value="desc">降序</option>
            </select>
            <%--                条件发送器请求--%>
            <a id="search" href="javascript:void(0)" class="easyui-linkbutton"
               data-options="iconCls:'icon-search'">搜索</a>
        </form>

    </div>

    <table id="companyDataGrid">
    </table>
</div>

<%-- 添加公司的dialog--%>
<div id="addCompanyDialog" class="easyui-dialog" title="添加公司信息" style="width:500px;height:420px;"
     data-options="closed:true">
    <form id="addFormCompany" method="post">
        <div style="text-align: center;margin-top: 30px">
            <label>公司名称：</label>
            <input name="cname" class="easyui-textbox" data-options="prompt:'请输入公司名称'" style="width:180px">
        </div>
        <div style="text-align: center;margin-top: 30px">
            <label>公司密码：</label>
            <input name="cpwd" class="easyui-textbox" data-options="prompt:'请输入公司密码'" style="width:180px">
        </div>

        <div style="text-align: center;margin-top: 30px">
            <label>公司电话：</label>
            <input name="cphone" class="easyui-textbox" data-options="prompt:'请输入公司电话'" style="width:180px">
        </div>

        <div style="text-align: center;margin-top: 30px">
            <label>公司ceo：</label>
            <input name="ceo" class="easyui-textbox" data-options="prompt:'请输入公司ceo'" style="width:180px">
        </div>

        <div style="text-align: center;margin-top: 30px">
            <label>公司邮箱：</label>
            <input name="cmail" class="easyui-textbox" data-options="prompt:'请输入公司邮箱'" style="width:180px">
        </div>

        <div style="text-align: center;margin-top: 30px">
            <a id="submitAddCompany" href="javascript:void(0)" class="easyui-linkbutton"
               data-options="iconCls:'icon-ok'">添加公司信息</a>
        </div>
    </form>
</div>

<%-- 修改公司的dialog--%>
<div id="editCompanyDialog" class="easyui-dialog" title="修改公司信息" style="width:500px;height:420px;"
     data-options="closed:true">
    <form id="editFormCompany" method="post">

        <%--        隐藏域 提交cid 进行修改 --%>
        <input type="hidden" name="cid">

        <div style="text-align: center;margin-top: 30px">
            <input name="cname" class="easyui-textbox" data-options="prompt:'输入公司名称'" style="width:180px">
        </div>
        <div style="text-align: center;margin-top: 30px">
            <input name="cpwd" class="easyui-textbox" data-options="prompt:'输入公司的密码'" style="width:180px">
        </div>

        <div style="text-align: center;margin-top: 30px">
            <input name="cphone" class="easyui-textbox" data-options="prompt:'输入公司的电话'" style="width:180px">
        </div>

        <div style="text-align: center;margin-top: 30px">
            <input name="ceo" class="easyui-textbox" data-options="prompt:'输入公司ceo'" style="width:180px">
        </div>

        <div style="text-align: center;margin-top: 30px">
            <input name="cmail" class="easyui-textbox" data-options="prompt:'输入公司的邮箱'" style="width:180px">
        </div>

        <div style="text-align: center;margin-top: 30px">
            <a id="submitEditCompany" href="javascript:void(0)" class="easyui-linkbutton"
               data-options="iconCls:'icon-ok'">修改公司信息</a>
        </div>
    </form>
</div>

<%--策划师列表布局--%>
<div id="plannerDialog" class="easyui-dialog" title="公司策划师展示" style="width:600px;height:320px;"
     data-options="closed:true,top:'50px'">
    <table id="plannerDataGrid">
    </table>
</div>

<%-- 工具栏 --%>
<div id="toolbar" style="padding:5px 0;">
    <a id="addBtn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加公司</a>
    <a id="editBtn" href="javascript:void(0)" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-edit'">修改公司信息</a>
    <a id="plannerBtn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-man'">策划师列表</a>
    <a id="disableBtn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">公司状态修改</a>
</div>
<script>

    // dataGrid 的初始化
    $("#companyDataGrid").datagrid(
        {
            url: "company/companyInfo",
            fitColumns: true,
            pagination: true,
            rownumbers: true,
            pageNumber: 1,
            pageSize: 3,
            pageList: [3,6],        //当设置了 pagination 属性时，初始化页面尺寸的选择列表。
            toolbar:"#toolbar",
            columns: [[
                {field: 'aa', checkbox: true},
                {field: 'cname', title: '公司名称', width: 150,align:'center'},
                {field: 'ceo', title: '公司法人', width: 100,align:'center'},
                {field: 'cphone', title: '手机号', width: 100,align:'center'},
                {
                    field: 'starttime', title: '开通时间', width: 150,align:'center',
                    formatter: function (value, rowData, index) {
                        var year = value.year;
                        var m = value.monthValue;
                        var day = value.dayOfMonth;
                        return year + "-" + m + "-" + day;
                    }
                },
                {field: 'ordernumber', title: '订单量', width: 100,align:'center'},
                {
                    field: 'status', title: '账号状态', width: 100,align:'center',
                    formatter: function (value, rowData, index) {
                        return value == "1" ? "正常" : "禁用";
                    }
                },
            ]]
        }
    )

    //公司信息的条件查询
    $("#search").click(function () {

        $("#companyDataGrid").datagrid(
            "load",
            {
                cname: $("#cname").val(),
                status: $("#status").val(),
                ordernumber: $("#ordernumber").val(),
            }
        )
    });

    //添加公司
    $("#addBtn").click(function () {
        //展示添加的dialog
        $("#addCompanyDialog").dialog("open");
    })
    // 提交添加表单数据
    $("#submitAddCompany").click(function () {
        $("#addFormCompany").form(
            'submit',
            {
                url: 'company/companyAdd',
                success: function (data) {
                    console.log(data);
                    var d = JSON.parse(data);
                    // 判断是否成功
                    if (d.success) {
                        // 01 信息提示
                        $.messager.alert("提示", d.msg, "info")
                        // 02 关闭dialog
                        $("#addCompanyDialog").dialog('close');
                        // 03 form 清理
                        $("#addFormCompany").form('clear');
                        // 04 datagrid 刷新
                        $("#companyDataGrid").datagrid('reload');
                    }
                }
            }
        )
    })

    //修改公司的信息
    $("#editBtn").click(function () {
        //拿到datagrid的数据
        var trs = $("#companyDataGrid").datagrid('getChecked');

        if (trs.length == 1) {

            // 02 在编辑dialog展示数据
            $("#editFormCompany").form('load', trs[0]);
            $("#editCompanyDialog").dialog('open');

        } else if (trs.length > 1) {
            $.messager.alert("提示", "只能选择一个公司进行修改", "info")
        } else {
            $.messager.alert("提示", "请选择一个公司进行修改", "info")
        }
    })

    //提交修改表单数据
    $("#submitEditCompany").click(function () {
        $("#editFormCompany").form(
            "submit",
            {
                url: 'company/companyUpdate',
                success: function (data) {
                    console.log(data);
                    var d = JSON.parse(data);
                    // 判断是否成功
                    if (d.success) {
                        // 01 信息提示
                        $.messager.alert("提示", d.msg, "info")
                        // 02 关闭dialog
                        $("#editCompanyDialog").dialog('close');
                        // 03 form 清理
                        $("#editFormCompany").form('clear');
                        // 04 datagrid 刷新
                        $("#companyDataGrid").datagrid('reload');
                    }
                }
            }
        )
    })

    //查看公司策划师
    // 初始化plannerDataGrid
    $("#plannerDataGrid").datagrid({

        url: "planner/plannerInfo",
        // fitColumns: true,
        rownumbers: true,
        columns: [[
            {field: 'aa', checkbox: true},
            {field: 'nname', title: '策划师姓名', width: 100,align:'center'},
            {field: 'nphone', title: '手机号', width: 100,align:'center'},
            {
                field: 'addtime', title: '开通时间', width: 100,align:'center',
                formatter: function (value, rowData, index) {
                    var year = value.year;
                    var m = value.monthValue;
                    var day = value.dayOfMonth;
                    return year + "-" + m + "-" + day;
                }
            },
            {field: 'ordernumber', title: '订单量', width: 100,align:'center'},
            {
                field: 'status', title: '账号状态', width: 100,align:'center',
                formatter: function (value, rowData, index) {
                    return value == "1" ? "正常" : "禁用";
                }
            }
        ]]
    })

    //点击 查看策划师列表
    $("#plannerBtn").click(function () {

        //拿到datagrid的数据
        var trs = $("#companyDataGrid").datagrid('getChecked');
        if (trs.length == 1) {
            // 拿到公司的数据 datagrid 通过cid 查询指定的策划师
            var cid = trs[0].cid;

            $("#plannerDataGrid").datagrid(
                'load',
                {
                    cid: cid
                }
            )

            //展示策划师的数据
            $("#plannerDialog").dialog('open');
        } else if (trs.length > 1) {
            $.messager.alert("提示", "只能选择一条数据进行公司策划师查看", "info")
        } else {
            $.messager.alert("提示", "请选择一条数据进行公司策划师查看", "info")
        }
    })

    //公司的账号状态修改
    $("#disableBtn").click(function () {

        // 01 拿到 datagrid选中公司的数据
        var trs = $("#companyDataGrid").datagrid('getChecked');
        if (trs.length > 0) {
            // 把多个cid / status 拼接成字符串发送到服务器
            // 01 cid / status 进行拼接
            var cids = "";
            var statuss = "";
            for (var i = 0; i < trs.length; i++) {
                cids  += trs[i].cid + ",";
                statuss  += trs[i].status + ",";
            }
            // 02 发送数据 ajax发送
            $.post(
                "company/companyStatues",
                {
                    cids:cids,
                    statuss:statuss,
                },
                function (data) {
                    // 判断是否成功
                    if (data.success) {
                        // 01 信息提示
                        $.messager.alert("提示", data.msg, "info")
                        // 04 datagrid 刷新
                        $("#companyDataGrid").datagrid('reload');
                    }
                },
                "json"
            );
        } else {
            $.messager.alert("提示", "至少选用一个公司进行状态的修改", "info")
        }
    });
</script>

</body>
</html>
