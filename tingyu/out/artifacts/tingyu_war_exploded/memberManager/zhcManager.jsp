<%--
  Created by IntelliJ IDEA.
  User: Mawson
  Date: 2021/1/9 0009
  Time: 20:43
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
    <title>主持人管理页面</title>
    <%--    引入 easyui的资源--%>
    <%--    easyui的css --%>
    <link rel="stylesheet" type="text/css" href="static/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="static/themes/icon.css">
    <%--    easyui的js  --%>
    <script type="text/javascript" src="static/js/jquery.min.js"></script>
    <script type="text/javascript" src="static/js/jquery.easyui.min.js"></script>
</head>
<body>

<%--设置日期框的格式--%>
<script type="text/javascript">
    //设置日期的格式
    function myformatter(date){
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        var d = date.getDate();
        return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
    }
    function myparser(s) {
        if (!s) return new Date();
        var ss = (s.split('-'));
        var y = parseInt(ss[0], 10);
        var m = parseInt(ss[1], 10);
        var d = parseInt(ss[2], 10);
        if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
            return new Date(y, m - 1, d);
        } else {
            return new Date();
        }
    }
    /************声明函数将json类型的时间转换为日期*********/
    //日期转换
    function jsonToDate(obj) {
        return obj.year + "-" + obj.monthValue + "-" + obj.dayOfMonth;
    }
    //时间转换
    function jsonToTime(obj) {
        //return "17:45:00"
        var h = obj.hour < 10 ? ("0" + obj.hour) : obj.hour;
        var m = obj.minute < 10 ? "0" + obj.minute : obj.minute;
        var s = obj.second < 0 ? "0" + obj.second : obj.second;
        return h + ":" + m + ":" + s;
    }
</script>

<%-- 添加主持人的dialog--%>
<div id="addHostDialog" class="easyui-dialog" title="添加主持人" style="width:400px;height:300px" data-options="closed:true">
    <form id="addFormHost" method="post">

        <div style="text-align: center;margin-top: 30px">
            <label>姓&nbsp;&nbsp;&nbsp;名：</label>
            <input name="hname" class="easyui-textbox" data-options="prompt:'输入主持人姓名'" style="width:180px">
        </div>
        <div style="text-align: center;margin-top: 30px">
            <label>密&nbsp;&nbsp;&nbsp;码：</label>
            <input name="hpwd" class="easyui-textbox" data-options="prompt:'输入密码'" style="width:180px">
        </div>

        <div style="text-align: center;margin-top: 30px">
            <label>手机号：</label>
            <input name="hphone" class="easyui-textbox" data-options="prompt:'输入主持人手机'" style="width:180px">
        </div>
        <div style="text-align: center;margin-top: 30px">
            <a id="submitAddHost" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">添加主持人</a>
        </div>
    </form>
</div>

<%--  展示页面  --%>
<div style="height: 99%;width: 99%">

    <div style="text-align: center">

        <form id="" class="">
            <%--            条件 用户名 --%>
            <input id="hname" class="easyui-textbox" type="text" data-options="prompt:'姓名'" style="width:100px">
            <%--        条件 推荐   --%>
            <select id="status" data-options="panelHeight:'auto',editable:false,value:'状态'" class="easyui-combobox"
                    style="width:100px;">
                <option value="1">正常</option>
                <option value="0">禁用</option>
            </select>
            <%--        条件 权重
                    提交字符串给服务器 直接在 dao拼接sql查询
                    升序/降序 给字符串
              --%>
            <select id="strong" data-options="panelHeight:'auto',editable:false,value:'权重'" class="easyui-combobox"
                    style="width:100px;">
                <option value="asc">升序</option>
                <option value="desc">降序</option>
            </select>

            <%--    星推荐  --%>
            <select id="hpstar" data-options="panelHeight:'auto',editable:false,value:'星推荐'" class="easyui-combobox"
                    style="width:100px;">
                <option value="1">推荐</option>
                <option value="0">不推荐</option>
            </select>
            <%--    折扣条件   --%>
            <select id="hpdiscount" data-options="panelHeight:'auto',editable:false,value:'折扣'" class="easyui-combobox"
                    style="width:100px;">
                <option value="6">6</option>
                <option value="7">7</option>
                <option value="8">8</option>
                <option value="9">9</option>
            </select>

            <%--                条件发送器请求--%>
            <a id="search" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'">搜索</a>
        </form>

    </div>

    <table id="hostDatagrid"></table>
</div>

<%--创建主持人权限设置的对话框--%>
<div id="hostPowerDialog" class="easyui-dialog" title="权限设置" style="width:600px;height:550px;"
     data-options="iconCls:'icon-save',resizable:false,modal:true,closed:true,left:300,top:10">
    <%--创建主持人增加的表单--%>
    <form id="hostPowerForm" method="post">
        <%--创建隐藏标签存储要进行数据权限更新的ID--%>
        <input type="hidden" name="hpid" id="hpid" value="">
        <%--创建隐藏标签存储要进行数据权限更新的主持人的ID--%>
        <input type="hidden" name="hostid" id="hostid" value="">
        <%--创建表格--%>
        <table cellpadding="10px" style="margin: auto;margin-top: 20px;">
            <tr>
                <td>是否星推荐:</td>
                <td>
                    <input class="easyui-radiobutton" id="hpstart_yes" name="hpstar" value="1" label="是"
                           labelPosition="after">
                    <input class="easyui-radiobutton" id="hpstart_no" name="hpstar" value="0" label="否"
                           labelPosition="after">
                </td>
            </tr>
            <tr>
                <td>星推荐日期:</td>
                <td>
                    <input id="hpstar_begindate" data-options="formatter:myformatter,parser:myparser"
                           data-options="showSeconds:true" name="hpstartBegindate" type="text" class="easyui-datebox">
                    -
                    <input id="hpstar_enddate" data-options="formatter:myformatter,parser:myparser" name="hpstarEnddate"
                           type="text" class="easyui-datebox">
                </td>
            </tr>
            <tr>
                <td>星推荐时间:</td>
                <td>
                    <input id="hpstar_begintime" name="hpstarBegintime" type="text" data-options="showSeconds:true"
                           class="easyui-timespinner">
                    -
                    <input id="hpstar_endtime" name="hpstarEndtime" type="text" data-options="showSeconds:true"
                           class="easyui-timespinner">
                </td>
            </tr>
            <tr>
                <td>自填订单:</td>
                <td>
                    <input class="easyui-radiobutton" id="hpOrderPower_yes" name="hpOrderPower" value="1" label="是"
                           labelPosition="after">
                    <input class="easyui-radiobutton" id="hpOrderPower_no" name="hpOrderPower" value="0" label="否"
                           labelPosition="after">
                </td>
            </tr>
            <tr>
                <td>折扣:</td>
                <td>
                    <input class="easyui-textbox" id="hp_discount" name="hpdiscount" prompt="请输入折扣" iconWidth="28"
                           style="width:300px;height:34px;padding:10px;">
                </td>
            </tr>
            <tr>
                <td>折扣日期:</td>
                <td>
                    <input id="hp_dis_starttime" data-options="formatter:myformatter,parser:myparser"
                           name="hpDisStarttime" type="text" class="easyui-datebox">
                    -
                    <input id="hp_dis_endtime" data-options="formatter:myformatter,parser:myparser" name="hpDisEndtime"
                           type="text" class="easyui-datebox">
                </td>
            </tr>
            <tr>
                <td>价格:</td>
                <td>
                    <input class="easyui-textbox" id="hpprice" name="hpprice" prompt="请输入价格" iconWidth="28"
                           style="width:300px;height:34px;padding:10px;">
                </td>
            </tr>
            <tr>
                <td>管理费:</td>
                <td>
                    <input class="easyui-textbox" id="hpcosts" name="hpcosts" prompt="请输入管理费" iconWidth="28"
                           style="width:300px;height:34px;padding:10px;">
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <a href="javascript:void(0)" id="hostPowerFromSubmit" class="easyui-linkbutton c3"
                       style="width:120px">点击完成</a>
                </td>
            </tr>
        </table>
    </form>
</div>

<%-- 批处理 主持人权限设置的对话框--%>
<div id="hostPowerBatchDialog" class="easyui-dialog" title="权限设置" style="width:600px;height:550px;"
     data-options="iconCls:'icon-save',resizable:false,modal:true,closed:true,left:300,top:10">
    <%--创建主持人增加的表单--%>
    <form id="hostPowerBatchForm" method="post">
        <%--创建隐藏标签存储要进行数据权限更新的主持人的ID--%>
        <input type="hidden" name="hids" id="hids" value="">
        <%--创建表格--%>
        <table cellpadding="10px" style="margin: auto;margin-top: 20px;">
            <tr>
                <td>是否星推荐:</td>
                <td>
                    <input class="easyui-radiobutton" name="hpstar" value="1" label="是"
                           labelPosition="after">
                    <input class="easyui-radiobutton" name="hpstar" value="0" label="否"
                           labelPosition="after">
                </td>
            </tr>
            <tr>
                <td>星推荐日期:</td>
                <td>
                    <input  data-options="formatter:myformatter,parser:myparser"
                            data-options="showSeconds:true" name="hpstartBegindate" type="text" class="easyui-datebox">
                    -
                    <input data-options="formatter:myformatter,parser:myparser" name="hpstarEnddate"
                           type="text" class="easyui-datebox">
                </td>
            </tr>
            <tr>
                <td>星推荐时间:</td>
                <td>
                    <input name="hpstarBegintime" type="text" data-options="showSeconds:true"
                           class="easyui-timespinner">
                    -
                    <input name="hpstarEndtime" type="text" data-options="showSeconds:true"
                           class="easyui-timespinner">
                </td>
            </tr>
            <tr>
                <td>自填订单:</td>
                <td>
                    <input class="easyui-radiobutton" name="hpOrderPower" value="1" label="是"
                           labelPosition="after">
                    <input class="easyui-radiobutton" name="hpOrderPower" value="0" label="否"
                           labelPosition="after">
                </td>
            </tr>
            <tr>
                <td>折扣:</td>
                <td>
                    <input class="easyui-textbox" name="hpdiscount" prompt="请输入折扣" iconWidth="28"
                           style="width:300px;height:34px;padding:10px;">
                </td>
            </tr>
            <tr>
                <td>折扣日期:</td>
                <td>
                    <input data-options="formatter:myformatter,parser:myparser"
                           name="hpDisStarttime" type="text" class="easyui-datebox">
                    -
                    <input data-options="formatter:myformatter,parser:myparser" name="hpDisEndtime"
                           type="text" class="easyui-datebox">
                </td>
            </tr>
            <tr>
                <td>价格:</td>
                <td>
                    <input class="easyui-textbox" name="hpprice" prompt="请输入价格" iconWidth="28"
                           style="width:300px;height:34px;padding:10px;">
                </td>
            </tr>
            <tr>
                <td>管理费:</td>
                <td>
                    <input class="easyui-textbox" name="hpcosts" prompt="请输入管理费" iconWidth="28"
                           style="width:300px;height:34px;padding:10px;">
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <a href="javascript:void(0)" id="hostPowerBatchFromSubmit" class="easyui-linkbutton c3"
                       style="width:120px">点击完成</a>
                </td>
            </tr>
        </table>
    </form>
</div>

<%--工具栏布局--%>
<div id="toolbar" style="padding:5px 0;">
    <a id="addBtn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加主持人</a>
    <a id="powerBtn" href="javascript:void(0)" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-edit'">权限设置</a>
    <a id="disableBtn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cut'">状态修改</a>
    <a id="batchBtn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">批量操作</a>
</div>

<script>

    //批处理的操作
    $("#batchBtn").click(function () {
        //点击批处理  拿到 datagrid 选中的数据
        var trs = $("#hostDatagrid").datagrid("getChecked");
        if (trs.length > 0 ){
            //dialog弹窗,显示编辑权限表单
            $("#hostPowerBatchDialog").dialog('open');
            //把多个hid 拼接成字符串 发送到服务器
            var hids = "";
            for(var i = 0 ; i < trs.length ;i ++){
                hids += trs[i].hid + ","
            }
            // 设置隐藏域 带过去
            $("#hids").val(hids);
        }else{
            $.messager.alert("提示","必须选中至少一条数据","info");
        }
    })

    //批处理表单提交
    $("#hostPowerBatchFromSubmit").click(function () {
        $("#hostPowerBatchForm").form(
            'submit',
            {
                url:"hostPower/batch",
                success:function (data) {
                    console.log(data)
                    // 添加成功给信息提示
                    var d = JSON.parse(data);
                    if (d.success){
                        // 01 信息提示
                        $.messager.alert("提示",d.msg,"info");
                        // 02 关闭dialog
                        $("#hostPowerBatchDialog").dialog("close")
                        // 03 把表单清理
                        $("#hostPowerBatchForm").form("clear");
                        // datagird 重新加载
                        $("#hostDatagrid").datagrid("reload");
                    }
                }
            }
        )
    })

    //权限修改
    $("#powerBtn").click(function () {

        //拿到 dataGrid 行的数据
        var trs = $("#hostDatagrid").datagrid('getChecked');

        if (trs.length == 1){

            //如果存在power展示, 添加hostPower
            var hostPower = trs[0].hostPower;

            //设置修改那个主持人的权限
            $("#hostid").val(trs[0].hid);

            if (hostPower){
                // 修改hpid (如果存在hostpower 修改 hostPower )
                $("#hpid").val(hostPower.hpid);
                // 权限设置的回显
                // 星推荐的回显
                hostPower.hpstar == "1" ? $("#hpstart_yes").radiobutton({checked:true}):
                $("#hpstart_no").radiobutton({checked:true})
                //星推荐的日期
                $("#hpstar_begindate").datebox('setValue',jsonToDate(hostPower.hpstartBegindate));
                $("#hpstar_enddate").datebox('setValue',jsonToDate(hostPower.hpstarEnddate));
                //星推荐的时间
                $("#hpstar_begintime").timespinner('setValue',jsonToTime(hostPower.hpstarBegintime));
                $("#hpstar_endtime").timespinner('setValue',jsonToTime(hostPower.hpstarEndtime));
                //自填订单
                hostPower.hpOrderPower == "1" ? $("#hpOrderPower_yes").radiobutton({checked:true}):
                    $("#hpOrderPower_no").radiobutton({checked:true});
                // 折扣
                $("#hp_discount").textbox('setValue',hostPower.hpdiscount);
                //折扣的时间
                $("#hp_dis_starttime").datebox('setValue',jsonToDate(hostPower.hpDisStarttime));
                $("#hp_dis_endtime").datebox('setValue',jsonToDate(hostPower.hpDisEndtime));
                //价格
                $("#hpprice").textbox('setValue',hostPower.hpprice);
                //管理费
                $("#hpcosts").textbox('setValue',hostPower.hpcosts);
            }
            // 显示主持人权限修改dialog
            $("#hostPowerDialog").dialog("open");
        } else if (trs.length > 1){
            $.messager.alert("提示","不能同时修改多位主持人的权限","info");
        } else {
            $.messager.alert("提示","请选中一位主持人","info");
        }
    })

    // 权限表单提交数据
    $("#hostPowerFromSubmit").click(function () {
        $("#hostPowerForm").form(
            'submit',
            {
                url:"hostPower/update",
                success:function (data) {
                    // 添加成功给信息提示
                    var d = JSON.parse(data);
                    if (d.success){
                        // 01 信息提示
                        $.messager.alert("提示",d.msg,"info");
                        // 02 关闭dialog
                        $("#hostPowerDialog").dialog("close")
                        // 03 把表单清理
                        $("#hostPowerForm").form("clear");
                        // datagird 重新加载
                        $("#hostDatagrid").datagrid("reload");
                    }
                }
            }
        )
    })

    //账号状态修改
    $("#disableBtn").click(function () {

        //   01 拿到 选中的 每一行的值
        var trs = $("#hostDatagrid").datagrid("getChecked");

        if (trs.length >0){

            var hids = "";
            var statuss = "";

            for(var i =0; i < trs.length; i++){
                hids +=  trs[i].hid + ",";
                statuss +=  trs[i].status + "," ;
            }
            console.log(hids);
            console.log(statuss);

            // ajax的操作发送数据
            $.post(
                "host/updatestatus",
                {
                    hids:hids,
                    statuss:statuss,
                },
                function (d) {
                    // 01 信息提示
                    if(d.success){
                        $.messager.alert("提示",d.msg,"info");
                        // datagird 重新加载
                        $("#hostDatagrid").datagrid("reload");
                    }
                },
                "json"
            );
        }else{
            $.messager.alert("提示","必须选中至少一条数据","info");
        }
    });

    //添加主持人的功能
    $("#addBtn").click(function () {
        // 显示添加dialog
        $("#addHostDialog").dialog("open");
    });

    $("#submitAddHost").click(function () {
        //表单提交数据
        $("#addFormHost").form(
            "submit",
            {
                url:"host/add",
                success:function (data) {
                    // 01 信息提示
                    var d = JSON.parse(data);
                    $.messager.alert("提示",d.msg,"info");
                    // 02 关闭dialog
                    $("#addHostDialog").dialog("close")
                    // 03 把表单清理
                    $("#addFormHost").form("reset");
                    // datagird 重新加载
                    $("#hostDatagrid").datagrid("reload");
                }
            }
        )
    })

    $("#search").click(function () {
        //发送条件查询
        $("#hostDatagrid").datagrid("load",
            { // 把条件查询的数据发送给服务器
                hname:$("#hname").val(),
                status:$("#status").val(),
                strong:$("#strong").val(),
                hpstar:$("#hpstar").val(),
                hpdiscount:$("#hpdiscount").val(),
            }
        )
    });

    // 动态的初始化datagrid
    $("#hostDatagrid").datagrid({
        url:"host/hostInfo",    //    查询服务器的地址
        pagination: true,       //    置为 true，则在数据网格（datagrid）底部显示分页工具栏。
        checkOnSelect: false,   //    如果设置为 true，当用户点击某一行时，则会选中/取消选中复选框。如果设置为 false 时，只有当用户点击了复选框时，才会选中/取消选中复选框。
        fitColumns: true,       //    设置为 true，则会自动扩大或缩小列的尺寸以适应网格的宽度并且防止水平滚动。
        rownumbers: true,       //    置为 true，则显示带有行号的列。
        pageNumber: 1,          //    当设置了 pagination 属性时，初始化页码。 默认是1
        pageSize: 3,            //    当设置了 pagination 属性时，初始化页面尺寸。
        pageList: [3,6],        //当设置了 pagination 属性时，初始化页面尺寸的选择列表。
        toolbar:"#toolbar",
        columns:[[
            {field: 'aa', checkbox: true},
            {field:'strong',title:'权重',width:50,align:'center',
                // 权重会修改 把权重的值放到 input标签中进行显示可以修改
                formatter: function (value, rowData, index) {
                    // 修改权限的操作

                    // 01 给 input标签添加失去焦点事件,数据修改后发送ajax修改权重
                    // 02 修改权重: 拿到 strong, host有权限 hid
                    return "<input type='text' value='" + value + "' style='width: 50px;text-align: center' onblur='changeStrong(this," + rowData.hid + "," + rowData.strong + ")'/>";
                }
            },
            {field:'hname',title:'姓名',width:50,align:'center'},
            {field:'hphone',title:'手机号码',width:70,align:'center'},
            {field:'starttime',title:'开通时间',width:70,align:'center',
                formatter: function (value, rowdata, rowIndex) {
                    console.log("rowdata:" + rowdata)
                    console.log("rowIndex:" + rowIndex)
                    console.log("value:" + value)

                    var year = rowdata.starttime.year;
                    console.log(year);
                    var m = rowdata.starttime.monthValue;
                    var day = rowdata.starttime.dayOfMonth;
                    var h = rowdata.starttime.hour;
                    var min = rowdata.starttime.minute;

                    if (min > 10) {
                        return year + "-" + m + "-" + day + " " + h + ":" + min;
                    } else {
                        return year + "-" + m + "-" + day + " " + h + ":0" + min;

                    }
                }
            },
            {field:'hhprice',title:'价格',width:30,align:'center',
                formatter: function (value, rowdata, value) {
                    // 价格在hostpower中
                    // 判断是否有hostpower
                    if (rowdata.hostPower) {
                        return rowdata.hostPower.hpprice;
                    } else {
                        return "";
                    }
                }
            },
            {field:'ordernumber',title:'订单量',width:30,align:'center'},
            {field:'hpdiscount',title:'折扣',width:30,align:'center',
                formatter: function (value, rowdata, value) {
                    if (rowdata.hostPower) {
                        return rowdata.hostPower.hpdiscount;
                    } else {
                        return "";
                    }
                }
            },
            {field:'hpstar',title:'星推荐',width:30,align:'center',
                formatter: function (value, rowdata, value) {
                    if (rowdata.hostPower) {
                        return rowdata.hostPower.hpstar == 1 ? "推荐" : "不推荐";
                    } else {
                        return "";
                    }
                }
            },
            {field:'status',title:'账号状态',width:50,align:'center',
                formatter: function (value, rowData, index) {
                    // 直接拿到选中的值
                    console.log(value);
                    return value == "1" ? "正常" : "禁用";
                }
            },
        ]]
    })

    //修改权重
    /**
     * @param obj   input的对象
     * @param hid   host的id
     * @param oldStrong   input修改之前的权重的值
     */
    function changeStrong(obj, hid, oldStrong) {
        // 如果新值 和 旧值不一样 就发送ajax修改strong
        var newStrong = Number(obj.value);
        if (newStrong != oldStrong){
            //发送ajax
            $.post(
                "host/strongUp",
                {
                    hid: hid,
                    strong: newStrong
                },
                function (data) {
                    console.log(data);
                    // 判断修改返回结果的操作
                    if (data.success) {
                        $.messager.alert("提示", data.msg, "info");
                        // dataGrid 重新加载数据
                        // reload param 重新加载行，就像 load 方法一样，但是保持在当前页。
                        $("#hostDatagrid").datagrid("reload");
                    }
                },
                "json"
            )
        }
    }
</script>

</body>
</html>
