<%@page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="org.springframework.web.context.ContextLoader" %>
<%@ page import="mapper.DictionaryMapper" %>
<%@ page import="bean.Dictionary" %>
<%@ page import="bean.Hash" %>
<%@ page import="mapper.HashMapper" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
    <head>
        <title>任务提交  </title>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="../../css/submit.css" />
        <link rel="stylesheet" type="text/css" href="../../css/header.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style2.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adminindex.css" />
        <script src="../../js/jquery-3.3.1.min.js"></script>
        <script src="../../js/datatables.min.js"></script>
        <script src="../../js/hash_check.js"></script>
        <script>
        	$(function(){
                var selectRadio = 1, crack_string = null;
        		function displayResult(option){
					selectRadio=option;
				}
        		$("input[type='radio']").click(function(){
        			displayResult(this.value);
        		});
        		$("#submit_task").click(function(){
        			crack_string=$("#dictionary_select option:selected").val();
        			var hash_str = $("#hash_key").val()
        			if (!hash_str) {
        				alert("请设置哈希值！");
        				return;
        			}
	        		$.ajax({
				          url: "../task/submit",
				          type: "post",
				          dataType: "text",
				          data: {
				            hashType:$("#hash_type").val(),
				            hashString:hash_str,
				            crackType:selectRadio,
				            crackString:crack_string
				          },
				          success:function(rdata){
				              alert("提交成功!");
				          },
				          error:function() {
                              alert("提交错误!");
				          }
				     });
	        	});
	        	$("#cancel_task").click(function(){
	        	    window.location.href="./task_view";
	        		return false;
	        	});
        	});
        	
        </script>
    </head>
    <body>
        <%@include file="head.jsp"%>
        <div id='main'>
            <form class="layui-form" style="text-align: center;margin: 100px;">
                <div class="layui-form-item">
                    <label for="hash_key" class="layui-form-label">SimHash值</label>
                    <div class="layui-input-block">
                        <input id="hash_key" type="text" class="layui-input" placeholder="请输入SimHash值">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label for="hash_type" class="layui-form-label">哈希类型</label>
                    <div class="layui-input-block">
                        <select id="hash_type">
                            <%
                                ApplicationContext context = ContextLoader.getCurrentWebApplicationContext();
                                HashMapper hashMapper = context.getBean(HashMapper.class);
                                List<Hash> hashes = hashMapper.getHashes();
                                for (Hash hash: hashes) {
                                    out.println("<option value=\""+hash.getId()+"\">"+ hash.getId() + "  " + hash.getName()+"</option>");
                                }
                            %>
                        </select>
                    </div>
                    
                </div>
                <fieldset class="layui-elem-field">
                    <legend>分析模式</legend>
                    <div class="layui-field-box">
                        <div class="layui-form-item">
                            <label for="dictionary_select" style="font-weight: 200">选择分析字典</label> 
                            <select id="dictionary_select" lay-search>
                            <%
                                DictionaryMapper dictionaryMapper = context.getBean(DictionaryMapper.class);
                                List<Dictionary> dictionaries = dictionaryMapper.getDictionaries();
                                for(Dictionary dictionary: dictionaries) {
                                     out.println("<option value=\""+dictionary.getName()+"\">"+
                                     dictionary.getName()+ "&nbsp&nbsp&nbsp[" + dictionary.getNumHash() + "条哈希]</option>");
                                }
                            %>
                        </select>
                        </div>
                    </div>
                </fieldset>
                <div style="margin:50px 0;text-align:center;height:10%;">
                    <button id="cancel_task" class="layui-btn layui-btn-lg layui-btn-warm" type="button">取消提交</button>
                    <button id="submit_task" class="layui-btn layui-btn-lg" type="button">提交任务</button>
                </div>
            </form>
        </div>
    </body>
    <script>
        layui.use('form', function(){
          var form = layui.form;
          form.render();
        });
    </script>
</html>