<%@page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
        <style>]
            
            .update_table_container {
                margin-top: 10%;
            }
            .window table {
                text-align: center;
                display: inline-block;
            }
             input[type="text"] {
                 width: 250px;
                 text-align:center;
             }
        </style>
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
                            <button id="logout" class="layui-btn layui-btn-radius layui-btn-primary" onclick="window.location.href='../verify/logout'">退出</button>
                            <button id="refresh" class="layui-btn layui-btn-radius layui-btn-primary" type="button" onclick="(function() {
                                window.location.reload();})()
                            ">刷新</button>
                            <button id="submit_task_btn" class="layui-btn layui-btn-radius" type="button" onclick="window.location.href='./task_submit'">提交任务</button>
                            <button id="update_task_btn" class="layui-btn layui-btn-radius layui-btn-warm" type="button">重新提交</button>
                        </div>
                        <div class="tab_card" style="display: block;">
                            <table id="taskpast_table" cellspacing="0" width="100%">
                                <thead>
                                    <tr class="first" style="font-size:15px">
                                        <th>提交时间</th>
                                        <th>任务ID</th>
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
                    <div id="detail1" class="window">
                    <div style="margin-bottom: 20px;">
                        <div class="detailtitle">Detail</div>
                        <span style="width:20%" class="show_head"><a class="close" href="#" title="关闭">×</a></span>
                    </div>
                    <textarea id="description_text1" rows=15>
                    </textarea><br />
                    </div>
                    <script src="../../js/taskuserpast.js" type="text/javascript"></script>
                </div>
                <div class="layui-tab-item">
                    <div id="task_list">
                        <div class="btngroup">
                            <button id="logout" class="layui-btn layui-btn-radius layui-btn-primary" onclick="window.location.href='../verify/logout'">退出</button>
                            <button id="refresh" class="layui-btn layui-btn-radius layui-btn-primary" type="button" onclick="(function() {
                                window.location.reload();})()
                            ">刷新</button>
                            <button id="submit_task_btn" class="layui-btn layui-btn-radius" type="button" onclick="window.location.href='./task_submit'">提交任务</button>
                            <button id="update_task_btn" class="layui-btn layui-btn-radius layui-btn-warm" type="button">重新提交</button>
                        </div>
                        <div class="tab_card" style="display: block;">
                            <table id="tasknow_table" cellspacing="0" width="100%">
                                <thead>
                                    <tr class="first" style="font-size:15px">
                                        <th>提交时间</th>
                                        <th>任务ID</th>
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
                    <div id="detail2" class="window">
                    <div style="margin-bottom: 20px;">
                        <div class="detailtitle">Detail</div>
                        <span style="width:20%" class="show_head"><a class="close" href="#" title="关闭">×</a></span>
                    </div>
                    <textarea id="description_text2" rows=15>
                    </textarea><br />
                    </div>
                    <script src="../../js/taskusernow.js" type="text/javascript"></script>
                </div>
                <div class="layui-tab-item">
                    <div id="task_list">
                        <div class="btngroup">
                            <button id="logout" class="layui-btn layui-btn-radius layui-btn-primary" onclick="window.location.href='../verify/logout'">退出</button>
                            <button id="refresh" class="layui-btn layui-btn-radius layui-btn-primary" type="button" onclick="(function() {
                                window.location.reload();})()
                            ">刷新</button>
                            <button id="submit_task_btn" class="layui-btn layui-btn-radius" type="button" onclick="window.location.href='./task_submit'">提交任务</button>
                            <button id="update_task_btn" class="layui-btn layui-btn-radius layui-btn-warm" type="button">重新提交</button>
                        </div>
                        <div class="tab_card" style="display: block;">
                            <table id="taskqueue_table" cellspacing="0" width="100%">
                                <thead>
                                    <tr class="first" style="font-size:15px">
                                        <th>提交时间</th>
                                        <th>任务ID</th>
                                        <th>哈希类型</th>
                                        <th>哈希字符串</th>
                                        <th>总共计算哈希数量</th>
                                        <th>任务状态</th>
                                        <th>信息更新时间</th>
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
                    <div id="detail3" class="window">
                    <div style="margin-bottom: 20px;">
                        <div class="detailtitle">Detail</div>
                        <span style="width:20%" class="show_head"><a class="close" href="#" title="关闭">×</a></span>
                    </div>
                    <textarea id="description_text3" rows=15>
                    </textarea><br />
                    </div>
                    <script src="../../js/taskuserqueue.js" type="text/javascript"></script>
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