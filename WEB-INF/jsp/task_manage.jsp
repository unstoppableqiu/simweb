<%@ page import="bean.User" %>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="head.jsp"%>
        <title>任务管理</title>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="../../css/datatables.min.css" />
        <link rel="stylesheet" type="text/css" href="../../css/task.css" />
        <link rel="stylesheet" type="text/css" href="../../css/header.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style2.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adminindex.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/task_mangage.css" />
    </head>
    <body>
        <div id="mask"></div>
        <div id='main'>
        <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
            <ul class="layui-tab-title">
                <li class="layui-this">历史任务</li>
                <li>在线任务</li>
                <li>排队任务</li>
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
                    <div id="task_list">
                        <div class="btngroup">
                            <button id="mainMenu" type="button" class="layui-btn layui-btn-radius layui-btn-primary" onclick="(function() {
                                window.location.href='manage_option';
                            })();">返回主菜单</button>
                            <button id="refresh" type="button" class="layui-btn layui-btn-radius layui-btn-primary" onclick="(function() {
                                window.location.reload();})()
                            ">刷新</button>
                            <button id="delete_task_btn1" type="button" class="layui-btn layui-btn-radius layui-btn-danger">删除任务</button>
                        </div>
                        <div class="tab_card" style="display: block;">
                            <table id="taskpast_table" cellspacing="0" width="100%">
                                <thead>
                                    <tr class="first" style="font-size:15px">
                                        <th>提交时间</th>
                                        <th>任务ID</th>
                                        <th>提交者</th>
                                        <th>哈希类型</th>
                                        <th>哈希字符串</th>
                                        <th>任务分配时间</th>
                                        <th>任务开始时间</th>
                                        <th>总共计算哈希数量</th>
                                        <th>任务状态</th>
                                        <th>任务结果</th>
                                        <th>信息更新时间</th>
                                        <th>分配到</th>
                                    </tr>
                                 </thead>
                                 <tbody style="font-size:12px">

                                 </tbody >
                            </table>
                        </div>
                    </div>
                    <div class="window" id="delete" style="display: none;">
                        <div style="margin-bottom: 20px;">
                            <div class="detailtitle">确认删除任务?</div>
                            <span style="width:20%" class="show_head">
                                <a class="close" href="#" title="关闭">×</a>
                            </span>
                        </div>
                        <div class="delete_table_container">
                            <div class="deleteid">
                                <label for="taskId">任务ID</label>
                                <input class="layui-input" style="text-align: center;" type="text" id="taskpastId" name="taskId" readonly="readonly" value="" />
                            </div>
                            <div>
                                <button id="confirm_delete_btn1" class="layui-btn layui-btn-danger">确认</button>
                                <button id="cancel_delete_btn" class="layui-btn layui-btn-normal">取消</button>
                            </div>
                        </div>
                    </div>
                    <div id="detail" class="window" style="display:none;">
                            <div style="margin-bottom: 20px;">
                                <div class="detailtitle">Detail</div>
                                <span style="width:20%" class="show_head">
                                    <a class="close" href="#" title="关闭">×</a>
                                </span>
                            </div>
                            <textarea id="description_text" rows=15> </textarea><br/>
                    </div>
                    <script src="../../js/taskpast.js" type="text/javascript"></script>
                </div>
                <div class="layui-tab-item">
                    <div id="task_list">
                        <div class="btngroup">
                            <button id="mainMenu" type="button" class="layui-btn layui-btn-radius layui-btn-primary" onclick="(function() {
                                window.location.href='manage_option';
                            })();">返回主菜单</button>
                            <button id="refresh" type="button" class="layui-btn layui-btn-radius layui-btn-primary" onclick="(function() {
                                window.location.reload();})()
                            ">刷新</button>
                            <button id="delete_task_btn2" type="button" class="layui-btn layui-btn-radius layui-btn-danger">删除任务</button>
                        </div>    
                            <div class="tab_card" style="display: block;">
                                <table id="tasknow_table" cellspacing="0" width="100%">
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
                                     <tbody style="font-size:12px">

                                     </tbody >
                                </table>
                            </div>
                        </div>
                    
                    <div class="window" id="delete2" style="display: none;">
                        <div style="margin-bottom: 20px;">
                            <div class="detailtitle">确认删除任务?</div>
                            <span style="width:20%" class="show_head">
                                <a class="close" href="#" title="关闭">×</a>
                            </span>
                        </div>
                        <div class="delete_table_container">
                            <div class="deleteid">
                                <label for="taskId">任务ID</label>
                                <input class="layui-input" style="text-align: center;" type="text" id="tasknowId" name="taskId" readonly="readonly" value="" />
                            </div>
                            <div>
                                <button id="confirm_delete_btn2" class="layui-btn layui-btn-danger">确认</button>
                                <button id="cancel_delete_btn2" class="layui-btn layui-btn-normal">取消</button>
                            </div>
                        </div>
                    </div>
                    <div id="detail2" class="window" style="display:none;">
                            <div style="margin-bottom: 20px;">
                                <div class="detailtitle">Detail</div>
                                <span style="width:20%" class="show_head"><a class="close" href="#" title="关闭">×</a></span>
                            </div>
                            <textarea id="description_text2" rows=15> </textarea><br/>
                    </div>
                    <script src="../../js/tasknow.js" type="text/javascript"></script>
                </div>
                <div class="layui-tab-item">           
                    <div id="task_list">
                        <div class="btngroup">
                            <button id="mainMenu" type="button" class="layui-btn layui-btn-radius layui-btn-primary" onclick="(function() {
                                window.location.href='manage_option';
                            })();">返回主菜单</button>
                            <button id="assign_btn" type="button" class="layui-btn layui-btn-radius layui-btn-primary">任务分配</button>
                            <button id="refresh" type="button" class="layui-btn layui-btn-radius layui-btn-primary" onclick="(function() {
                                window.location.reload();})()
                            ">刷新</button>
                            <button id="delete_task_btn3" type="button" class="layui-btn layui-btn-radius layui-btn-danger">删除任务</button>
                        </div>    
                            <div class="tab_card" style="display: block;">
                                <table id="taskqueue_table" cellspacing="0" width="100%">
                                    <thead>
                                        <tr class="first" style="font-size:15px">
                                            <th>提交时间</th>
                                            <th>任务ID</th>
                                            <th>提交者</th>
                                            <th>哈希类型</th>
                                            <th>哈希字符串</th>
                                            <th>总共计算哈希数量</th>
                                            <th>任务状态</th>
                                            <th>信息更新时间</th>
                                        </tr>
                                     </thead>
                                     <tbody style="font-size:12px">

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
                    <div class="window" id="delete3" style="display: none;">
                        <div style="margin-bottom: 20px;">
                            <div class="detailtitle">确认删除任务?</div>
                            <span style="width:20%" class="show_head">
                                <a class="close" href="#" title="关闭">×</a>
                            </span>
                        </div>
                        <div class="delete_table_container">
                            <div class="deleteid">
                                <label for="taskId">任务ID</label>
                                <input class="layui-input" style="text-align: center;" type="text" id="taskqueueId" name="taskId" readonly="readonly" value="" />
                            </div>
                            <div>
                                <button id="confirm_delete_btn3" class="layui-btn layui-btn-danger">确认</button>
                                <button id="cancel_delete_btn3" class="layui-btn layui-btn-normal">取消</button>
                            </div>
                        </div>
                    </div>
                    <div id="detail3" class="window" style="display:none;">
                            <div style="margin-bottom: 20px;">
                                <div class="detailtitle">Detail</div>
                                <span style="width:20%" class="show_head"><a class="close" href="#" title="关闭">×</a></span>
                            </div>
                            <textarea id="description_text3" rows=15 > </textarea><br/>
                    </div>
                    <script src="../../js/taskqueue.js" type="text/javascript"></script>
                </div>
            </div>
        </div>
    </body>
        <script>
            layui.use(['element', 'layer'], function(){
                var element = layui.element
                ,layer = layui.layer;

                element.on('tab(docDemoTabBrief)', function(data){
                    layer.msg('正在查看' + '：' + this.innerHTML);
                });
            });
        </script>
        

    </html>