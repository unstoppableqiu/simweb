<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>   
<!DOCTYPE html>
<html>
    <head>
        <title>计算资源</title>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="../../css/header.css" />
        <link rel="stylesheet" type="text/css" href="../../css/task.css" />
        <link  rel="stylesheet" type="text/css" href="../../css/datatables.min.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style2.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adminindex.css" />
        <style>
            .window{
                width:600px;
                height:400px;
                background-color:white;
                position:fixed;
                top:50%;
                left:50%;
                margin-left:-300px;
                margin-top:-200px;
                z-index:100;
                padding:20px;
                border-radius:5px;
                padding:0;
                text-align:center;
                display:none;
            }
            div#mask{
                width:100%;
                height:300%;
                position:fixed;
                background-color:#000;
                top:0;
                left:0;
                z-index:2;
                opacity:0.3;
                filter: alpha(opacity=30);
                display:none;
            }
            .window form{
                margin-top:20%;
                text-align:center;
            }
            .window table{
                display:inline-block;
            }
            table tr{
            	vertical-align:middle;
            }
             table tr td{
            	vertical-align:middle;
            }
            .show_head{
                text-align:right;
            }
        </style>
    </head>
    <body>
        <%@include file="head.jsp"%>
        <div id='main'>
            <div id="task_list">
                <div class="btngroup">
                    <button id="refresh" type="button" class="layui-btn layui-btn-radius layui-btn-primary" onclick="window.location.reload()">刷新列表</button>
                	<button id="mainMenu" type="button" class="layui-btn layui-btn-radius layui-btn-primary" onclick="window.location.href='./manage_option'">返回主菜单</button>
                    <button class="layui-btn layui-btn-radius layui-btn-primary" id="update_task" type="button">编辑资源</button>
                    <button class="layui-btn layui-btn-radius layui-btn-primary" id="create_task" type="button">添加资源</button>
                    <button class="layui-btn layui-btn-radius layui-btn-danger" id="remove_task" type="button">删除资源</button>
                </div>
                <div class="tab_card" id="history">
                    <table id="resource_table" class="display" cellspacing="0" width="100%">
                        <thead>
                            <tr id="first">
                                <th>资源名称</th>
                            	<th>描述</th>
                            	<th>位置</th>
                            	<th>资源类型</th>
                            	<th>任务状态</th>
                            	<th>信息更新时间</th>
                            	<th>ip</th>
                            	<th>可用节点</th>
                            </tr>
                         </thead>
                         <tbody id="userAnchor">
                         </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="window" id="add">
            <div class="show_head">
              <span><a href="#" class="close" title="关闭">×</a></span>
            </div>
            <form action="../cresource/add" method="POST">
                <div>添加资源</div>
                <table>
                    <tr>
                        <td class="td1"><label for="name2">名称</label></td>
                        <td class="td2"><input name="name" type="text" id="name" value=""></td>
                    </tr>
                    <tr>
                        <td class="td1"><label for="description2">描述</label></td>
                        <td class="td2"><input name="description" type="text" id="description" value=""></td>
                    </tr>
                    <tr>
                        <td class="td1"><label for="phy_loc2">位置</label></td>
                        <td class="td2"><input name="phyLoc" type="text" id="phy_loc" value=""></td>
                    </tr>
                    <tr>
                        <td class="td1"><label for="resource_type">资源类型</label></td>
                        <td class="td2" id="resource_type">
                            <input name="type" type="radio" value="1" checked="checked"/>超算
                            <input name="type" type="radio" value="0" />GPU集群
                        </td>
                    </tr>
                    <tr>
                        <td class="td1"><label for="ip2">IP地址</label></td>
                        <td class="td2"><input name="ip" type="text" id="ip" value=""></td>
                    </tr>
                    <tr>
                        <td colspan="2"><input type="submit"  class="confirm" value="确认">
                            <input type="button" class="cancel" value="取消"></td>
                    </tr>
                </table>
            </form>
        </div>
         <div class="window" id="update">
            <div class="show_head">
              <span><a href="#" class="close" title="关闭">×</a></span>
            </div>
            <form action="../cresource/update" method="POST">
              <div>编辑资源</div>
              <table>
                    <tr>
                        <td class="td1"><label for="name2">名称</label></td>
                        <td class="td2"><input name="name" readonly="readonly" type="text" id="name2" value=""></td>
                    </tr>
                    <tr>
                        <td class="td1"><label for="description2">描述</label></td>
                        <td class="td2"><input name="description" type="text" id="description2" value=""></td>
                    </tr>
                    <tr>
                        <td class="td1"><label for="phy_loc2">位置</label></td>
                        <td class="td2"><input name="phyLoc" type="text" id="phy_loc2" value=""></td>
                    </tr>
                  <tr>
                      <td class="td1"><label for="resource_type2">资源类型</label></td>
                      <td class="td2" id="resource_type2">
                          <input name="type" type="radio" value="0" />GPU集群
                          <input name="type" type="radio" value="1"/>超算
                      </td>
                  </tr>
                    <tr>
                        <td class="td1"><label for="ip2">IP地址</label></td>
                        <td class="td2"><input name="ip" type="text" id="ip2" value=""></td>
                    </tr>
                    <tr>
                        <td colspan="2"><input type="submit"  class="confirm" value="确认">
                        <input type="button" class="cancel" value="取消"></td>
                    </tr>
                  </table>
            </form>
        </div>
        <div id='detail' class="window">
            <div class="show_head">
              <span><a href="#" class="close" title="关闭">×</a></span>
            </div>
            <div>描述</div>
            <textarea id="description_text" rows=15 style="width:70%;padding:0;">
            </textarea></br>
            <input id="description_btn"type="submit" value="提交">
         </div>
         <div class="window">
            <div class="show_head">
              <span><a href="#" class="close" title="关闭">×</a></span>
            </div>
            <div>位置</div>
            <textarea id="phy_loc_text" rows=15 style="width:70%;padding:0;">
            </textarea></br>
            <input id="phy_loc_btn"type="submit" value="提交">
         </div>
         <div class="window" id="remove">
                <div class="show_head">
                  <span><a href="#" class="close" title="关闭">×</a></span>
                </div>
                <form action="../cresource/remove" method="post">
                  <div>确认删除以下资源？</div>
                  <table>
                    <tr>
                        <td class="td1"><label for="name3">名称</label></td>
                        <td class="td2"><input type="text" name="name" readonly="readonly" id="name3" value=""></td>
                    </tr>
                    <tr>
                        <td colspan="2"><input  id="deleteResource" type="submit"  class="confirm" value="确认">
                        <input type="button" class="cancel" value="取消"></td>
                    </tr>
                  </table>
                </form>
          </div>
    </body>
    <script type="text/javascript" src="../../js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="../../js/datatables.min.js"></script>
    <script type="text/javascript" src="../../js/form_no_jump.js"></script>
    <script type="text/javascript">
        $("tbody" ).on("click", ".hash_string", function (e) {
            var hash_string = $(this).children("img").attr("alt")
            $("#description_text").text(hash_string);
            $("#detail").slideDown(300).css("display", "block");
            $("#mask").fadeIn(300);
        });
        $(".close").click(function () {
            $(".window").slideUp(300);
            $("#mask").slideUp(300);
        });
        var selected = null;
        $("#resource_table").on("click", "tr", function () {
            if (!$(this).hasClass("selected"))
                $(".selected").removeClass("selected");
           $(this).toggleClass("selected");
           selected = $("#resource_table").DataTable().row($(this)).data();
        });
        $("#update_task").click(function () {
            $("#update").slideDown(300);
            $("#mask").fadeIn(300);
            $("#name2").val(selected["cname"]);
            $("#description2").val(selected["description"]);
            $("#phy_loc2").val(selected["phyLoc"]);
            console.log(selected['type'])
            $("input[name='type'][value=" + '"' + selected['type'] + '"]').attr("checked", true);
            $("#ip2").val(selected["ip"]);
        });
        $("#create_task").click(function () {
            $("#add").slideDown(300);
            $("#mask").fadeIn(300);
        });
        $("#remove_task").click(function () {
            $("#remove").slideDown(300);
            $("#mask").fadeIn(300);
            $("#name3").val(selected["cname"]);
        });
        $(".cancel").click(function () {
            $(".window").slideUp(300);
            $("#mask").fadeOut(300);
        });
        $("#resource_table").DataTable({
            "ajax": {
                "type": "POST",
                "url": "../cresource/all",
                "dataType": "json"
            },
            "columns": [
                {"data": "cname"},
                {"data": "description"},
                {"data": "phyLoc"},
                {"data": "type"},
                {"data": "status"},
                {"data": "lstSrvUpdate"},
                {"data": "ip"},
                {"data": "availNodes"},
            ],
            "columnDefs": [
                {
                    "targets": [1, 2],
                    "render": function (data) {
                        return '<span class="hash_string" style="font-size:10px;text-align:center;display:inline-block;background-color:#FFFFFF;border-radius:5px;width:60px;color:white">' +
                            '<img src="../../image/detail.png" alt="' + data + '"/></span>';
                    }
                },
                {
                    "targets": 3,
                    "render": function (data, type, row) {
                        if (data === 0)
                            return '<span style="font-size:10px;text-align:center;display:inline-block;background-color:#ADFF2F;border-radius:5px;width:60px;color:white">GPU集群</span>';
                        else if (data === 1)
                            return '<span style="font-size:10px;text-align:center;display:inline-block;background-color:#EE7600;border-radius:5px;width:60px;color:white">超算</span>';
                        else
                            return '<span style="font-size:10px;text-align:center;display:inline-block;background-color:#CCCCCC;border-radius:5px;width:60px;color:white">Unknown</span>';
                    }
                },
                {
                    "targets":4,
                    "render": function ( data, type, row ) {
                        if(data===0)
                            return '<span style="font-size:10px;text-align:center;display:inline-block;background-color:#ADFF2F;border-radius:5px;width:60px;color:white">Idle</span>';
                        else if(data===1)
                            return '<span style="font-size:10px;text-align:center;display:inline-block;background-color:#EE7600;border-radius:5px;width:60px;color:white">Busy</span>';
                        else if(data===2)
                            return '<span style="font-size:10px;text-align:center;display:inline-block;background-color:#CCCCCC;border-radius:5px;width:60px;color:white">Disconnect</span>';
                    }
                },
                {
                    "targets":7,
                    "render": function ( data, type, row ) {
                        if(data===-1)
                            return '<span style="font-size:10px;text-align:center;display:inline-block;background-color:#CCCCCC;border-radius:5px;width:60px;color:white">Unknown</span>';
                        else
                            return data;
                    }
                }
            ]});
    </script>
</html>