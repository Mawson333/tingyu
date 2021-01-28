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
    <title>新人管理</title>
    <%--    引入 easyui的资源--%>
    <%--    easyui的css --%>
    <link rel="stylesheet" type="text/css" href="static/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="static/themes/icon.css">
    <%--    easyui的js  --%>
    <script type="text/javascript" src="static/js/jquery.min.js"></script>
    <script type="text/javascript" src="static/js/jquery.easyui.min.js"></script>
</head>
<body>

<%--创建新人管理面板组件--%>
<div id="p" class="easyui-panel" title="新人管理"
     style="width:900px;height:500px;padding:10px;background:#fafafa;"
     data-options="closable:false,collapsible:false,minimizable:false,maximizable:false">

    <%--创建检索条件组件效果--%>
    <div style="margin: auto;width: 700px;">
        <%--创建检索条件表单--%>
        <form>
            <input class="easyui-textbox" prompt="新人姓名" id="pname" name="pname" style="width:150px"><%--姓名条件--%>
            <input class="easyui-textbox" prompt="新人手机号" id="phone" name="phone" style="width:150px"><%--手机号条件--%>
            <a id="search" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false">查询</a>
        </form>
    </div>

    <%--创建主持人信息加载的DataGrid组件--%>
    <table id="personDataGrid"></table>
</div>

<script>

    $("#personDataGrid").datagrid(
        {
            url:"marriedPerson/marriedPersonInfo",//设置远程加载数据的地址
            pagination:true,                //在表格中显示分页工具栏，将此属性设置为true，就会发送ajax分页请求获取要加载的数据
            rownumbers:true,                //显示行号
            pageNumber:1,                   //设置ajax分页查询的默认页码数
            pageSize:3,                     //设置每页显示的数量
            checkOnSelect:false,            //设置点击行的任意位置不会选择该行，只有点击复选框时菜单选择
            pageList:[3,6],                 //设置每页数据量下拉框框中的数据
            title:"查询结果",                 //显示标题
            columns:                        //设置表格的列以及每列和加载的数据的映射关系
                [[
                    //表示一列，并且设置该列和数据的映射关系
                    {title:"新人名称",field:"pname",width:150,align:'center'},
                    {title:"新人邮箱",field:"pmail",width:150,align:'center'},
                    {title:"新人手机号",field:"phone",width:150,align:'center'},
                    {title:"新人婚期",field:"marrydate",width:150,align:'center',
                        formatter:function (value,rows,rowIndex) {
                            return value.year+"-"+value.monthValue+"-"+value.dayOfMonth
                        }
                    },
                    {title:"账号状态",field:"status",width:150,align:'center',
                        formatter:function (value,rows,rowIndex) {
                            return value=="1"?"正常":"禁用"
                        }
                    },
                ]]
        }
    )

    //给查询按钮增加单击时间
    $("#search").click(function () {
        //dataGrid按照条件重新分页加载主持人信息
        $("#personDataGrid").datagrid(
            'load',
            {
                pname:$("#pname").val(),
                phone:$("#phone").val()
            }
        )
    })

</script>
</body>
</html>
