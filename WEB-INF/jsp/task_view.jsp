<%@page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
                display: none;
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
            .update_table_container {
                margin-top: 10%;
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
             input[type="text"] {
                 width: 250px;
                 text-align:center;
             }
            .hash_string:hover {
                cursor: pointer;
            }
        </style>
    </head>
    <body>
    <%@include file="head.jsp"%>
        <div id="mask"></div>
        <div id='main'>
            <div id='option'>
                <ul id="tab_buttons">
                    <li id="past">历史任务</li><li id="current">在线任务</li><li id="queue">排队任务</li>
                </ul>
            </div>
            <div id="task_list">
                <button id="logout" onclick="window.location.href='../verify/logout'">退出</button>
                <button id="refresh" type="button" onclick="(function() {
                    window.location.reload();})()
                ">刷新</button>
                <button id="submit_task_btn" type="button" onclick="window.location.href='./task_submit'">提交任务</button>
                <button id="update_task_btn" type="button">重新提交</button>
                <div class="tab_card" style="display: block;">
                    <table id="task_table" cellspacing="0" width="100%">
                        <thead>
                            <tr class="first" style="font-size:15px">
                                <th>提交时间</th>
                            	<th>任务ID</th>
                            	<th>哈希类型</th>
                            	<th>哈希字符串</th>
                            	<th>破解类型</th>
                                <th>破解参数</th>
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
            <div class="window" id="update" style="display: none;">
                <div class="show_head">
                    <span><a class="close" href="#" title="关闭">×</a></span>
                </div>
                <div class="update_table_container">
                    <div>重新提交</div>
                    <table>
                        <tr>
                            <td class="td1"><label for="taskId">任务ID</label></td>
                            <td class="td2"><input type="text" id="taskId" name="taskId" readonly="readonly" value="" /></td>
                        </tr>
                        <tr>
                            <td class="td1"><label for="hashType">哈希类型</label></td>
                            <td class="td2"><input type="text" id="hashType" name="hashType" value="" /></td>
                        </tr>
                        <tr>
                            <td class="td1"><label for="hashString">哈希字符串</label></td>
                            <td class="td2"><input type="text" id="hashString" name="hashString" value="" /></td>
                        </tr>
                        <tr>
                            <td class="td1"><label for="crackType">破解类型</label></td>
                            <td class="td2" id="crackType">
                                <input type="radio" name="crackType" value="0" />字典破解
                                <input type="radio" name="crackType" value="1" />枚举破解
                            </td>
                        </tr>
                        <tr>
                            <td class="td1"><label for="crackString">破解参数</label></td>
                            <td class="td2"><input type="text" id="crackString" name="crackString" value="" /></td>
                        </tr>
                        <tr>
                            <td class="td1"><button id="submit_update_btn">提交</button></td>
                            <td class="td2"><button id="cancel_update_btn" class="close">取消</button></td>
                        </tr>
                </table>
                </div>
            </div>
            <div id="detail" class="window">
            <div style="margin-bottom: 20px;">
                <div style="margin-left:10%;width:80%;float:left;text-align: center">Detail</div>
                <span style="width:20%" class="show_head"><a class="close" href="#" title="关闭">×</a></span>
            </div>
            <textarea id="description_text" rows=15 style="width:70%;padding:0;">
            </textarea><br />
            </div>
        </div>
        <script src="../../js/jquery-3.3.1.min.js" type="text/javascript"></script>
        <script src="../../js/datatables.min.js" type="text/javascript" ></script>
        <script src="../../js/date_format.js" type="text/javascript"></script>
        <script type="text/javascript">
            var tab = "past";
            $("#tab_buttons li").click(function () {
                tab = $(this).attr("id");
                $("#task_table").DataTable().clear();
                $("#task_table").DataTable().ajax.url("../task/user_"+tab).load()
            });
            $("tbody" ).on("click", ".hash_string", function (e) {
                var hash_string = $(this).children("img").attr("alt")
                $("#description_text").text(hash_string);
                $("#detail").slideDown(300).css("display", "block");
                $("#mask").fadeIn(300);
            });
            $(".close").click(function () {
                $(".window").slideUp(300).css("display", "none");
                $("#mask").fadeOut(300);
            });
            // 单选
            var selected = null;
            $("tbody").on("click", "tr", function () {
                if (!$(this).hasClass("selected"))
                    $(".selected").removeClass("selected");
                $(this).toggleClass("selected");
                selected = $("#task_table").DataTable().row($(this)).data();
            });
            $("#update_task_btn").click(function () {
                $("#taskId").val(selected["taskId"]);
                $("#hashType").val(selected["hashType"]);
                $("#hashString").val(selected["hashString"]);
                console.log(selected);
                $("input[name='crackType'][value=" + '"' + selected['crackType'] + '"]').attr("checked", true);
                $("#crackString").val(selected["crackString"]);
                $("#update").slideDown(300);
                $("#mask").fadeIn(300);
            });
            $("#submit_update_btn").click(function () {
                var crackType = null;
                var name = $("input[name='crackType']");
                for (var i = 0; i < name.length; i++) {
                    if (name[i].checked) {
                        crackType = $(name[i]).val();
                        break;
                    }
                };
                $.ajax({
                    "url": "../task/resubmit",
                    "type": "POST",
                    "data": {
                        "taskId": $("#taskId").val(),
                        "hashType": $("#hashType").val(),
                        "hashString": $("#hashString").val(),
                        "crackType": crackType,
                        "crackString": $("#crackString").val()
                    },
                    "success": function () {
                        alert("操作成功!");
                        window.location.reload();
                    },
                    "error": function () {
                        alert("操作失败!");
                        window.location.reload();
                    }
                });
            });
            $("#task_table").DataTable({
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
                    "url": "../task/user_past",
                    "dataType": "json"
                },
                "columns": [
                    {"data": "submitTime"},
                    {"data": "taskId"},
                    {"data": "hashType"},
                    {"data": "hashString"},
                    {"data": "crackType"},
                    {"data": "crackString"},
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
                    "targets":9,
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
                      "targets": [3, 5, 10],
                      "render": function (data) {
                          return '<span class="hash_string" style="font-size:10px;text-align:center;display:inline-block;background-color:#FFFFFF;border-radius:5px;width:60px;color:white">' +
                              '<img src="../../image/detail.png" alt="' + data + '"/></span>';
                      }
                    },
                    {
                    "targets":4,
                    "render": function ( data, type, row ) {
                        if(data===1)
                            return '<span style="font-size:10px;text-align:center;display:inline-block;background-color:#B8B8B8;border-radius:5px;width:60px;color:white">枚举</span>';
                        else
                            return '<span style="font-size:10px;text-align:center;display:inline-block;background-color:#B3EE3A;border-radius:5px;width:60px;color:white">字典</span>';
                    }},
                    {
                    "targets":6,
                    "render": function ( data, type, row ) {
                        if(data==="\"null\"")
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
    </body>
    </html>