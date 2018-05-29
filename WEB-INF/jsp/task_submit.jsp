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
        			if(selectRadio===1) {
        				crack_string=$("#search_template").val();
        				if (!crack_string) {
        					alert("搜索模版不能为空!")
        					return;
        				}
        				if (!check(crack_string)) {
            				alert("搜索模版设置不正确！");
            				return;
        				}
        			}
        			else
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
            <label for="hash_key">哈希值</label><input id="hash_key" type="text"><br/>
            <label for="hash_type">哈希类型</label>
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
            
            <div id="analyze_mode">
                <label id="mode_label">分析模式</label>
                <input id="exhaustion" name="type" value="1" type="radio" checked="checked"><label for="exhaustion" style="color:#36648B">穷举</label>
                <label for="search_template">搜索模板</label><input id="search_template" type="text" placeholder="搜索模版须遵循[Aads]规则，且不得为空"><br/>
                
                <input id="dictionary" name="type" value="0" type="radio"><label for="dictionary"  style="color:#36648B">字典</label>
                <label for="dictionary_select">字典选择</label>   
                <select id="dictionary_select">
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
            <div style="margin:50px 0;text-align:center;height:10%;">
                <button id="cancel_task" type="button">取消提交</button>
                <button id="submit_task" type="button">提交任务</button>
            </div>
        </div>
    </body>
</html>