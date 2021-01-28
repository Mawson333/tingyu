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
    <table id="personDataGrid"></table>
</div>

<script>
    $("#personDataGrid").datagrid(
        {
            url:"order/orderInfo",//设置远程加载数据的地址
            pagination:true,                //在表格中显示分页工具栏，将此属性设置为true，就会发送ajax分页请求获取要加载的数据
            rownumbers:true,                //显示行号
            // pageNumber:1,                   //设置ajax分页查询的默认页码数
            // pageSize:3,                     //设置每页显示的数量
            checkOnSelect:false,            //设置点击行的任意位置不会选择该行，只有点击复选框时菜单选择
            // pageList:[3,6],                 //设置每页数据量下拉框框中的数据
            title:"查询结果",                 //显示标题
            columns:                        //设置表格的列以及每列和加载的数据的映射关系
                [[
                    //表示一列，并且设置该列和数据的映射关系
                    {title:"订单编号",field:"oid",width:100,align:'center'},
                    {title:"酒店名称",field:"hotelname",width:150,align:'center'},
                    {title:"婚礼地点",field:"hoteladdress",width:110,align:'center'},
                    {title:"新人婚期",field:"ordertime",width:150,align:'center',
                        formatter:function (value,rows,rowIndex) {
                            return value.year+"-"+value.monthValue+"-"+value.dayOfMonth
                        }
                    },
                    {title:"婚礼费用",field:"money",width:110,align:'center'},
                    {title:"订单状态",field:"status",width:110,align:'center',
                        formatter:function (value,rows,rowIndex) {
                            return value=="1"?"正常":"异常"
                        }
                    },
                    {title:"评价",field:"comment",width:110,align:'center',
                        formatter:function (value,rows,rowIndex) {
                            return value=="1"?"好评":"差评"
                        }
                    },
                ]]
        }
    )
</script>


</body>
</html>
