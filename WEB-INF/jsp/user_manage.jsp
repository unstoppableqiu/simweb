<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>   
<!DOCTYPE html>
<html>
    <head>
        <title>管理员界面</title>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="../../css/header.css" />
        <link rel="stylesheet" type="text/css" href="../../css/acnt_manage.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style2.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adminindex.css" />
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.16/datatables.min.css"/>
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
            .detail {
                display: none;
            }
        </style>
    </head>
    <body>
        <%@include file="head.jsp"%>
        <div id='main'>
            <div id="task_list">
                <button id="refresh" type="button" class="layui-btn layui-btn-radius layui-btn-primary" onclick="window.location.reload();
                ">刷新列表</button>
                <button id="mainMenu" type="button" class="layui-btn layui-btn-radius layui-btn-primary" onclick="window.location.href='./manage_option'">返回主菜单</button>
                <button id="create_account" class="layui-btn layui-btn-radius layui-btn-primary" type="button">新建账号</button>
                <button id="delete_account" type="button" class="layui-btn layui-btn-radius layui-btn-danger">删除账号</button>
                <button id="update_account" class="layui-btn layui-btn-radius layui-btn-primary" type="button">修改账号</button>
                <table id="user_table" class="display" cellspacing="0" width="100%">
                    <thead>
                        <tr id="first">
                            <th>用户ID</th>
                            <th>盐值</th>
                            <th>用户类型</th>
                            <th>描述</th>
                            <th>物理地址</th>
                            <th>令牌</th>
                            <th>密钥哈希</th>
                        </tr >
                     </thead>
                     <tbody id="userAnchor" style="font-size:12px">
                       
                     </tbody>
                </table>
            </div>
        </div>
        <div id="mask"></div>
        <div class="window" id="create">
            <div class="show_head">
              <span><a href="#" class="close" title="关闭">×</a></span>
            </div>
            <form action="../account/add" method="post">
              <div>创建账户</div>
              <table>
                    <tr>
                        <td class="td1"><label for="name">账号</label></td>
                        <td class="td2"><input type="text" id="name" value="" name="name" readonly="readonly"></td>
                    </tr>
                    <tr>
                        <td class="td1"><label for="password">密码</label></td>
                        <td class="td2"><input type="text" id="password" value="" name="password" readonly="readonly"></td>
                    </tr>
                    <tr>
                        <td class="td1"><label for="token">令牌</label></td>
                        <td class="td2"><input type="text" id="token" value="" name="token"></td>
                    </tr>
                    <tr>
                        <td class="td1"><label for="authkey">密钥</label></td>
                        <td class="td2"><input type="text" id="authkey" value="" name="authkey"></td>
                    </tr>
                   <tr>
                      <td class="td1"><label for="description">描述</label></td>
                      <td class="td2"><input type="text" id="description" name="description" value=""/></td>
                   </tr>
                   <tr>
                      <td class="td1"><label for="phyloc">物理地址</label></td>
                      <td class="td2"><input type="text" id="phyloc" name="phyLoc" value=""/></td>
                   </tr>
                   <tr>
                        <td colspan="2"><input type="submit"  id="create_confirm" class="confirm" value="确认">
                   <input type="button" class="cancel" value="取消"></td>
                   </tr>
                  </table>
            </form>
        </div>
        <div class="window" id="delete">
                <div class="show_head">
                  <span><a href="#" class="close" title="关闭">×</a></span>
                </div>
                <form action="../account/remove" method="post">
                  <div>确认删除以下用户</div>
                  <table>
                    <tr>
                        <td class="td1"><label for="name2">账号</label></td>
                        <td class="td2"><input type="text" id="name2" name="name" readonly="readonly" value=""></td>
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
                  <span><a class="close" href="#" title="关闭">×</a></span>
                </div>
                <form action="../account/update" method="post">
                  <div>信息修改</div>
                  <table>
                    <tr>
                        <td class="td1"><label for="name3">账号</label></td>
                        <td class="td2"><input type="text" id="name3" name="name" readonly="readonly" value="" /></td>
                    </tr>
                    <tr>
                        <td class="td1"><label for="token3">令牌</label></td>
                        <td class="td2"><input type="text" id="token3" name="token" value="" /></td>
                    </tr>
                    <tr>
                        <td class="td1"><label for="authkey3">密钥</label></td>
                        <td class="td2"><input type="text" id="authkey3" name="authkey" value="" /></td>
                    </tr>
                    <tr>
                        <td class="td1"><label for="description2">描述</label></td>
                        <td class="td2"><input type="text" id="description2" name="description" value=""/></td>
                    </tr>
                      <tr>
                          <td class="td1"><label for="phyloc2">物理地址</label></td>
                          <td class="td2"><input type="text" id="phyloc2" name="phyLoc" value=""/></td>
                      </tr>
                    <tr>
                        <td colspan="2"><input type="submit"  class="confirm" value="确认">
                        <input type="button" class="cancel" value="取消"></td>
                    </tr>
                  </table>
                </form>
          </div>
          <div class="window detail">
            <div class="show_head">
              <span><a href="#" class="close" title="关闭">×</a></span>
            </div>
            <div>描述</div>
            <textarea id="description_text" rows=15 style="width:70%;padding:0;">
            </textarea><br />
            <input id="description_btn"type="submit" value="提交">
          </div>
          <div class="window detail">
            <div id="show_head">
              <span><a href="#" class="close" title="关闭">×</a></span>
            </div>
            <div>物理地址</div>
            <textarea id="phy_loc_text" rows=15 style="width:70%;padding:0;">
            </textarea><br />
            <input id="phy_loc_btn"type="submit" value="提交">
          </div>
        </body>
        <script type="text/javascript" src="../../js/jquery-3.3.1.min.js"></script>
        <script type="text/javascript" src="../../js/datatables.min.js"></script>
    <script type="text/javascript" src="../../js/form_no_jump.js"></script>
        <script type="text/javascript">
            var selected = null;
            $("#user_table tbody").on("click", "tr", function () {
                selected = $("#user_table").DataTable().row($(this)).data();
                if (!$(this).hasClass("selected"))
                    $(".selected").removeClass("selected");
                $(this).toggleClass("selected");
            });
            $("#create_account").click(function () {
                $("#create").slideDown(300);
                $("#mask").slideDown(300);
            });
            $("#delete_account").click(function () {
                $("#mask").slideDown(300);
                $("#delete").slideDown(300);
                $("#name2").val(selected["name"]);
            });
            $("#update_account").click(function () {
                $("#mask").slideDown(300);
                $("#update").slideDown(300);
                $("#name3").val(selected["name"]);
                $("#token3").val(selected["token"]);
                $("#authkey3").val(selected["authkey"]);
                $("#description2").val(selected["description"]);
                $("#phyloc2").val(selected["phyLoc"]);
            });
            $(".close").click(function () {
                $(".window").slideUp(300);
                $("#mask").slideUp(300);
            });
            $(".cancel").click(function () {
                $(".window").slideUp(300);
                $("#mask").slideUp(300);
            });
            $("#user_table").DataTable({
                "iDisplayLength": 10,
                "iDisplayStart": 0,
                "bAutoWidth": false,
                "deferRender": true,
                "ajax": {
                    "type": "POST",
                    "url": "../account/all",
                    "dataType": "json"
                },
                "columns": [
                    {"data": "name"},
                    {"data": "salt"},
                    {"data": "type"},
                    {"data": "description"},
                    {"data": "phyLoc"},
                    {"data": "authkey"},
                    {"data": "token"}
                ],
                "columnDefs":[{
                    "targets":2,
                    "render": function ( data, type, row ) {
                        if(data===0)
                            return '<span style="font-size:10px;text-align:center;display:inline-block;background-color:#ADFF2F;border-radius:5px;width:60px;color:white">普通用户</span>';
                        else if(data===1)
                            return '<span style="font-size:10px;text-align:center;display:inline-block;background-color:#EE7600;border-radius:5px;width:60px;color:white">管理员</span>';
                        else
                            return '<span style="font-size:10px;text-align:center;display:inline-block;background-color:#6C7B8B;border-radius:5px;width:60px;color:white">Boss</span>';
                    }
                }]
            });
        </script>
</html>