<%@ page import="bean.User" %>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>任务管理</title>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.16/datatables.min.css" />
        <link rel="stylesheet" type="text/css" href="../../css/task.css" />
        <link rel="stylesheet" type="text/css" href="../../css/header.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style2.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adminindex.css" />
        <style>
            #select_resource{
                width:90%;
                height:90%;
                margin-left:-45%;
                margin-top:-300px;
                padding:0;
            }
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
                text-align:center;
            }
            .delete_table_container {
                margin-top: 15%;
            }
            .window table {
                text-align: center;
                display: inline-block;
            }
            .show_head{
                text-align:right;
            }
            table tr{
            	vertical-align:middle;
            }
             table tr td{
            	vertical-align:middle;
            }
            .hash_string:hover {
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <%@include file="head.jsp"%>
        <div id='main'>
        <div id='option'>
                <ul id="tab_buttons">
                    <li id="past">历史任务</li><li id="current">在线任务</li><li id="queue">排队任务</li>
                </ul>
            </div>
        <div id="task_list">
            	<button id="mainMenu" type="button" onclick="(function() {
            	    window.location.href='manage_option';
            	})();">返回主菜单</button>
                <button id="assign_btn" type="button" class="window_btn">任务分配</button>
                <button id="refresh" type="button" onclick="(function() {
                    window.location.reload();})()
                ">刷新</button>
                <button id="delete_task_btn" type="button" class="window_btn">删除任务</button>
                <div class="tab_card" style="display: block;">
                    <table id="task_table" cellspacing="0" width="100%">
                        <thead>
                            <tr class="first" style="font-size:15px">
                                <th>提交时间</th>
                            	<th>任务ID</th>
                            	<th>提交者</th>
                            	<th>哈希类型</th>
                            	<th>哈希字符串</th>
                                <th>任务分配时间</th>
                                <th>总共计算哈希数量</th>
                                <th>已计算哈希数</th>
                            	<th>任务状态</th>
                            	<th>任务结果</th>
                            	<th>信息更新时间</th>
                            	<th>预计结束时间</th>
                                <th>分配到</th>
                            </tr>
                         </thead>
                         <tbody id="historyAnchor" style="font-size:12px">
                         
                         </tbody >
                    </table>
                </div>
            </div>
        <div class="window" id="select_resource" style="display:none;overflow:scroll;">
                <div class="show_head">
                  <span><a id="close" href="#" title="关闭">×</a></span>
                </div>
                <form action="../task/assign" method="post">
                	<label for="nodes_to_use" class="gpu_hidden">节点数</label>
	                <input id="nodes_to_use" class="gpu_hidden" value="">
	                <label for="task_selected">任务</label>
	                <input id="task_selected" value="">————>
	                <label for="resource_selected">计算资源</label>
	                <input id="resource_selected" value="">
	                <input id="assign_confirm" type="button" value="确定">
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
                            	<th>预计结束时间</th>
                            </tr>
                         </thead>
                         <tbody id="resourceAnchor">
                         </tbody>
                    </table>
                </form>
          </div>
            <div class="window" id="delete" style="display: none;">
                <div class="show_head">
                    <span><a class="close" href="#" title="关闭">×</a></span>
                </div>
                <div class="delete_table_container">
                    <div>确认删除任务?</div>
                    <table>
                        <tr>
                            <td class="td1"><label for="taskId">任务ID</label></td>
                            <td class="td2"><input type="text" id="taskId" name="taskId" readonly="readonly" value="" /></td>
                        </tr>
                        <tr>
                            <td class="td1"><button id="confirm_delete_btn">确认</button></td>
                            <td class="td2"><button id="cancel_delete_btn" class="close">取消</button></td>
                        </tr>
                    </table>
                </div>
            </div>
        <div id="detail" class="window" style="display:none;">
                <div style="margin-bottom: 20px;">
                    <div style="margin-left:10%;width:80%;float:left;text-align: center">Detail</div>
                    <span style="width:20%" class="show_head"><a class="close" href="#" title="关闭">×</a></span>
                </div>
                <textarea id="description_text" rows=15 style="width:70%;padding:0;">
                </textarea><br />
            </div>
        </div>
    </body>
        <script src="../../js/jquery-3.3.1.min.js" type="text/javascript"></script>
        <script src="../../js/datatables.min.js" type="text/javascript" ></script>
        <script src="../../js/date_format.js" type="text/javascript"></script>
        <script type="text/javascript">
            var tab = "past";
            var selected = null;
            var taskTable = $("#task_table");
            var mask = $("#mask");
            var resourceTable = $("#resource_table");
            $("#tab_buttons").on("click", "li", (function () {
                tab = $(this).attr("id");
                taskTable.DataTable().clear();
                taskTable.DataTable().ajax.url("../task/"+tab).load()
            }));
            $("tbody" ).on("click", ".hash_string", function (e) {
                var hash_string = $(this).children("img").attr("alt")
                $("#description_text").text(hash_string);
                $("#detail").slideDown(300).css("display", "block");
                mask.fadeIn(300);
            });
            $(".close").click(function (e) {
                $("#detail").slideUp(300).css("display", "none");
                mask.fadeOut(300);
            });
            // 单选
            resourceTable.on("click", "tr", function () {
                if (!$(this).hasClass("selected"))
                    $(".selected").removeClass("selected");
                $(this).toggleClass("selected");

            });
            taskTable.on("click", "tr", function () {
                if (!$(this).hasClass("selected"))
                    $(".selected").removeClass("selected");
                $(this).toggleClass("selected");
                selected = taskTable.DataTable().row($(this)).data();
            });
            // 分配任务
            $("#assign_btn").click(function () {
                var selected = $(".selected");
                if (selected) {
                    $("#select_resource").slideDown(300);
                    mask.fadeIn(300);
                    var data = taskTable.DataTable().row(selected[0]).data();
                    console.log(data);
                    (function () {
                        var tableData = resourceTable.DataTable().data();
                        var rows = tableData.rows()[0].length;
                        function LoopAjax(i) {
                            if (i >= 0) {
                                $.ajax({
                                    "type": "POST",
                                    "url": "../task/cspeed",
                                    "data": {"hashType": data.hashType,
                                        "crackType": data.crackType,
                                        "cname": tableData[i].cname
                                    },
                                    "success": function (rdata) {
                                        var finish_time = "Unknown";
                                        var speed = rdata["speed"];
                                        if (speed) {
                                            finish_time = new Date().getTime() + data.numTotalHash / speed
                                            finish_time = new Date(finish_time).Format("yyyy-MM-dd hh:mm:ss");
                                        }
                                        var td = $(resourceTable.children("tbody")[0]).children("tr")[i].children[8];
                                        $(td).text(finish_time)
                                    }
                                });
                                LoopAjax(i-1);
                            }
                        }
                        LoopAjax(rows-1)
                    })();
                    resourceTable.on("click", "tr", function () {
                       var node_avail = $($(".selected")[0].children[7]).text();
                       var cname = $($(".selected")[0].children[0]).text();
                       var nodes_suggest = node_avail == 0? 0: Math.floor(Math.log(node_avail) / Math.log(2));
                       $("#nodes_to_use").val(nodes_suggest);
                       $("#resource_selected").val(cname);
                       $("#task_selected").val(data["taskId"]);
                    });
                    $("#assign_confirm").click(function () {
                        if ($("#nodes_to_use").val() <= 0)
                            return;
                        $.ajax({
                            "type": "POST",
                            "url": "../task/assign",
                            "dataType": "text",
                            "data": {
                                "taskId": $("#task_selected").val(),
                                "nodesToUse": $("#nodes_to_use").val(),
                                "cname": $("#resource_selected").val(),
                                "assignTime": new Date().getTime()
                            },
                            "success": function (XMLHttpRequest, textStatus, errorThrown) {
                                alert("提交成功！");
                                window.location.reload();
                            },
                            "error": function (XMLHttpRequest, textStatus, errorThrown) {
                                alert("提交失败!");
                                window.location.reload();
                            }
                        });
                    });
                }
            });
            $("#close").click(function () {
                $("#select_resource").slideUp(300);
                mask.fadeOut(300);
                });
            $("#delete_task_btn").click(function() {
                $("#delete").slideDown(300);
                mask.fadeIn(300);
                $("#taskId").val(selected["taskId"]);
            });
            $("#confirm_delete_btn").click(function() {
                $.ajax({
                    "type": "POST",
                    "url": "../task/remove",
                    "data": {
                        "taskId": $("#taskId").val()
                    },
                    "success": function () {
                        alert("删除成功!");
                        window.location.reload();
                    },
                    "error": function () {
                        alert("删除失败!");
                        window.location.reload();
                    }
                })
            });
            $(".close").click(function () {
               $("#delete").slideUp(300);
               mask.fadeOut(300);
            });
            resourceTable.DataTable({
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
                    {"data": null}
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
            taskTable.DataTable({
                //"aLengthMenu":[10],  //用户可自选每页展示数量 5条或10条
                "searching":false,//禁用搜索（搜索框）
                //"lengthChange":true,
                "paging": true,//开启表格分页
                "bProcessing" : true,
                "bServerSide" : true,
                "bAutoWidth" : false,
//                  "sort" : "position",
                "deferRender":true,//延迟渲染
//                  "bStateSave" : false, //在第三页刷新页面，会自动到第一页
//         "retrieve" : true,       //类似单例模式，重复利用以存在对象。
                "iDisplayLength" : 10,
                "iDisplayStart" : 0,
                "order": [[0, "desc"]],
                "ajax": {
                    "type": "POST",
                    "url": "../task/past",
                    "dataType": "json"
                },
                "columns": [
                    {"data": "submitTime"},
                    {"data": "taskId"},
                    {"data": "submitUser"},
                    {"data": "hashType"},
                    {"data": "hashString"},
                    {"data": "assignTime"},
                    {"data": "numTotalHash"},
                    {"data": "numProcHash"},
                    {"data": "status"},
                    {"data": "result"},
                    {"data": "lastSrvUpdate"},
                    {"data": "finishTime"},
                    {"data": "cname"}
                ],
                "columnDefs":[{
                    "targets":8,
                    "render": function ( data, type, row ) {
                        if(data===0)
                            return '<span style="font-size:10px;text-align:center;display:inline-block;background-color:#9BCD9B;border-radius:5px;width:60px;color:white">排队中</span>';
                        else if(data===1)
                            return '<span style="font-size:10px;text-align:center;display:inline-block;background-color:#FFC125;border-radius:5px;width:60px;color:white">已分配</span>';
                        else if(data===2)
                            return '<span style="font-size:10px;text-align:center;display:inline-block;background-color:#F08080;border-radius:5px;width:60px;color:white">已取走</span>';
                        else if(data===3)
                            return '<span style="font-size:10px;text-align:center;display:inline-block;background-color:#B3EE3A;border-radius:5px;width:60px;color:white">运行中</span>';
                        else if(data===4)
                            return '<span style="font-size:10px;text-align:center;display:inline-block;background-color:#3834E7;border-radius:5px;width:60px;color:white">成功</span>';
                        else if(data===5)
                            return '<span style="font-size:10px;text-align:center;display:inline-block;background-color:#B8B8B8;border-radius:5px;width:60px;color:white">未找到</span>';
                        else if(data===6)
                            return '<span style="font-size:10px;text-align:center;display:inline-block;background-color:#0c0c0c;border-radius:5px;width:60px;color:white">未找到</span>';
                    }},
                    {
                      "targets": [4, 9],
                      "render": function (data) {
                          return '<span class="hash_string" style="font-size:10px;text-align:center;display:inline-block;background-color:#FFFFFF;border-radius:5px;width:60px;color:white">' +
                              '<img src="../../image/detail.png" alt="' + data + '"/></span>';
                      }
                    },
                    {
                    "targets":5,
                    "render": function ( data, type, row ) {
                        if(data==="\"null\"")
                            return '<span style="font-size:10px;text-align:center;display:inline-block;background-color:#CCCCCC;border-radius:5px;width:60px;color:white">Unknown</span>';
                        else
                            return data;
                    }},
                    {
                    "targets":6,
                    "render": function ( data, type, row ) {
                        if(data==="-1")
                            return '<span style="font-size:10px;text-align:center;display:inline-block;background-color:#CCCCCC;border-radius:5px;width:60px;color:white">Unknown</span>';
                        else
                            return data;
                    }},
                    {
                    "targets":7,
                    "render": function ( data, type, row ) {
                        if(data==="-1")
                            return '<span style="font-size:10px;text-align:center;display:inline-block;background-color:#CCCCCC;border-radius:5px;width:60px;color:white">Unknown</span>';
                        else
                            return data;
                    }}
                ]
            });
    </script>
    </html>