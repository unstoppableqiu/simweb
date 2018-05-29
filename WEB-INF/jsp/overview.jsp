<%@page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html style="height: 100%">
   <head>
       <meta charset="utf-8">
       <link rel="stylesheet" href="js/bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
       <style> 
            body{
                font-size:12px;
            }
            td{
               border:1px solid white;
           }
       </style>
   </head>

   <body style="height: 100%; margin: 0">
       <script type="text/javascript" src="js/echarts-all-3.js"></script>
       <script type="text/javascript" src="js/ecStat.min.js"></script>
       <script type="text/javascript" src="js/china.js"></script>
       <script type="text/javascript" src="js/world.js"></script>
       <script type="text/javascript" src="js/time.js"></script>
       <script type="text/javascript" src="js/bmap.min.js"></script>
       <script type="text/javascript" src="js/jquery-3.1.1.js"></script>
       
       <script type="text/javascript">
        var statedata={"num_total_hash":102304121,"num_total_task":1293415,"num_queue_task":"4"};//静态数据
        var srcdata=[{"phy_loc":"(117.20, 42.13)","cname": "c225134","state":"1","description":"国家超算"}];
        var userdata=[{}];//用户数据
        var logdata=[{"log_id":12,"time":12341351,"content":"qkfjwl"}];//日志数
        var historydata=[
                        {'day_time':'20171005','num_total_task':'10','num_total_hash':'234566711492352'},
                        {'day_time':'20171006','num_total_task':'1','num_total_hash':'500000'},
                        {'day_time':'20171008','num_total_task':'5','num_total_hash':'2225309712'},
                        {'day_time':'20171009','num_total_task':'1','num_total_hash':'7340032'},
                        {'day_time':'20171012','num_total_task':'2','num_total_hash':'33342095359999'}
                        ]
       $(function(){
            var myLineChart = echarts.init(document.getElementById('lineMain'));
            var option2 = {
                tooltip : {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'cross',
                        label: {
                            backgroundColor: '#6a7985'
                        }
                    }
                },
                legend: {
                    data:['哈希条数(10万亿条)','任务数'],
                    textStyle:{
                        color: 'white'
                    }
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                xAxis : [
                    {
                        type : 'category',
                        boundaryGap : false,
                        axisLabel: {
                            show: true,
                            textStyle: {
                                color: 'white'
                            }
                        },
                        data : [
                            '10.08','10.09','10.10','10.11','10.12','10.13','10.14'
                        ]
                    }
                ],
                yAxis : [
                    {
                        type : 'value',
                        axisLabel: {
                            show: true,
                            textStyle: {
                                color: 'white'
                            }
                        }
                    }
                ],
                series : [
                    {
                        name:'哈希条数(10万亿条)',
                        type:'line',
                        stack: '总量',
                        areaStyle: {
                            normal: {
                                color: "red"
                            }
                        },
                        data:[120, 132, 101, 134, 90, 230, 210]
                    },
                    {
                        name:'任务数',
                        type:'line',
                        stack: '总量',
                        areaStyle: {
                            normal: {
                                color: "#ffeb3b"
                            }
                        },
                        data:[220, 182, 191, 234, 290, 330, 310]
                    }
                ]
            };
            var dom = document.getElementById("container");
            var myChart = echarts.init(dom);
            var app = {};
            option = null;

            var CSData = [
                    [  
                     {location:[113.0823,28.2568],value:{"phy_loc":""} },//起点
                     {location:[113.0823,28.2568],value:{"服务器id":"","任务id":"","开始时间":"" ,"hash_type":"","预计结束时间":"","nodeuse":0}}
                    ]
                ];


            var convertData = function (data) {//线条处理
                var res = [];
                for (var i = 0; i < data.length; i++) {
                    var dataCSData = data[i];
                    var fromCoord = dataCSData[0].location;
                    var toCoord = dataCSData[1].location;
                    if (fromCoord && toCoord) {
                        res.push({
                            fromName: dataCSData[0].location +" ",
                            toName: dataCSData[1].location + " ",
                            coords: [fromCoord, toCoord],
                            value: dataCSData[1].value
                        });
                    }
                }
                return res;
            };

            var color = ['#a6c84c', '#ffa022', '#46bee9'];
            var series = [];
            option = {
                backgroundColor: '#404a59',
                title : {
                    text: '任务进行图',
                    left: 'center',
                    textStyle : {
                        color: '#fff'
                    }
                },
                tooltip : {//hovel触发
                    trigger: 'CSData'
                },
                geo: {//背景图，中国
                    map: 'china',
                    label: {
                        emphasis: {
                            show: false
                        }
                    },
                    zoom: 1.2,//初始倍率
                    roam: 'move',
                    itemStyle: {//省份正常和hover显示
                        normal: {
                            areaColor: '#323c48',
                            borderColor: '#404a59'
                        },
                        emphasis: {
                            areaColor: '#2a333d'
                        }
                    }
                },
                series: [//点设置
                    
                    {
                        type: 'lines',
                        zlevel: 1,//图层1，即那个移动稍慢的白色轨迹
                        effect: {
                            show: true,
                            period: 6,
                            trailLength: 0.7,
                            color: '#fff',
                            symbolSize: [5,5]
                        },
                        lineStyle: {
                            normal: {
                                color: color[1],
                                width: 0,
                                curveness: 0.2//弧度
                            }
                        },
                        data: convertData(CSData)
                    },

                    {
                        type: 'lines',
                        zlevel: 2,//图层2，即那个恒显示的实线
                        symbol: ['none', 'none'],//类型
                        symbolSize: 10,
                        effect: {
                            show: true,
                            period: 6,
                            trailLength: 0,
                            symbolSize: [5,5]
                        },
                        lineStyle: {
                            normal: {
                                color: color[2],
                                width: 3,
                                opacity: 0.6,
                                curveness: 0.2
                            }
                        },
                        data: convertData(CSData)
                    },
                    //连线终点
                    {
                        type: 'scatter',//如果要改成hovel后放大，改成scatter，但肖老师说触摸屏没有hover动作，不需要
                        coordinateSystem: 'geo',
                        zlevel: 2,//点图层
                        label: {
                            normal: {
                                show: true,
                                position: 'right',
                                formatter: '{b}'
                            }
                        },
                        symbol:'image://image/国安.png',
                        symbolSize: [7.5,7.5],
                        itemStyle: {
                            normal: {
                                color:color[2],
                                borderColor: '#fff',
                                borderWidth: 3
                            }
                        },
                        data: CSData.map(function (dataCSData) {//数组映射为{location, value}格式，去掉前面的出发地
                            return {
                                location: dataCSData[1].location,
                                value: dataCSData[1].location.concat([dataCSData[1].value])
                            };
                        })
                    },
                    //连线起点
                    {
                        type: 'effectScatter',//如果要改成hovel后放大，改成scatter，但肖老师说触摸屏没有hover动作，不需要
                        coordinateSystem: 'geo',
                        showEffectOn: 'emphasis',
                        zlevel: 2,//点图层
                        label: {
                            normal: {
                                show: true,
                                position: 'right',
                                formatter: '{b}'
                            }
                        },
                        symbol:'image://image/cssupcomp.png',
                        symbolSize: [7.5,7.5],
                        itemStyle: {
                            normal: {
                                color:color[2],
                                borderColor: '#fff',
                                borderWidth: 3
                            }
                        },
                        data: CSData.map(function (dataCSData) {//数组映射为{location, value}格式，去掉前面的出发地
                            return {
                                location: dataCSData[0].location,
                                value: dataCSData[0].location.concat([dataCSData[0].value])
                            };
                        })
                    }
                ]
            };
            if (option && typeof option === "object") {
                myChart.setOption(option, true);
                myLineChart.setOption(option2,true);
            }
            //数据刷新
            //鼠标点击事件
            myChart.on('click', function (e) {
                if(e.seriesType === 'lines'){
                    Iclose();
                    var detail = "<div id=\"detail\" class=\"alert alert-success alert-dismissable\" style=\"width: auto;height: auto; position:fixed;left:35%;top:30%;font-size:12px;background-color:#FFFFFF\"><button type=\"button\" class=\"close\" onclick=\"Iclose()\" title=\"close it\">&times</button\>"
                    +"使用服务器id： " + e.value["服务器id"] + "<br>任务id： " + e.value["任务id"] + "<br>开始时间： " + e.value["开始时间"] + "<br>hash_type： " + e.value["hash_type"] + "<br>预计结束时间： " + e.value["预计结束时间"] + " <br>正在使用节点数:" + e.value["nodeuse"]; 
                    $("body").append(detail);               
               }      
                else if(e.seriesType == 'effectScatter'){
                    $("#compsrc tbody tr").remove();
                    for (var i = 0; i < srcdata.length; i++) {
                        if (srcdata[i]["phy_loc"] == e.value[2]["phy_loc"]) {
                            var srcinf = "<tr><td>"+srcdata[i]["description"] + "</td><td>" + srcdata[i]["state"] + "</td></tr>";
                            $("#compsrc tbody").append(srcinf);
                        }
                    }
                }
            });
            
            //线数据刷新
            function refresh(chart,data){
                if(!chart)
                    return;
                var option=chart.getOption();
                option.series[0].data=convertData(data);
                option.series[1].data=convertData(data);
                option.series[2].data=data.map(function (dataCSData) {
                            return {
                                location: dataCSData[1].location,
                                value: dataCSData[1].location.concat([dataCSData[1].value])
                            };
                        });
                option.series[3].data=data.map(function (dataCSData) {
                            return {
                                location: dataCSData[0].location,
                                value: dataCSData[0].location.concat([dataCSData[0].value])
                            };
                        });
                chart.setOption(option);
            };
            //左上角任务总情况刷新
            function refresh_situation(allinfparam){
                var now = new Date();
                var getsec = now.getSeconds();
                if(getsec < 10) getsec = '0' + getsec;
                var getnow1 = now.getFullYear() + "年" + (now.getMonth() + 1) + "月" + now.getDate() + "日<br>";
                var getnow2 = now.getHours() + ":" + now.getMinutes() + ":" + getsec;
                var gettask = document.getElementById("allinf");
                gettask.innerHTML = "\<span style=\"font-size:20px;\"\>" + getnow1 + "\<\/span\>" + "\<span style=\"font-size:20px;color:#24c15c;font-weight:bold\"\>" + getnow2 + "\<\/span\>"+ "<br>总计算量：<span style=\"color:#ffeb3b\">" + allinfparam[0] +"</span><br>总任务数：<span style=\"color:#ffeb3b\">" + allinfparam[1] + "<br></span>活跃任务数：<span style=\"color:#ffeb3b\">" + allinfparam[2] + "<br></span>排队任务数：<span style=\"color:#ffeb3b\">" + allinfparam[3] + "</span>"; 
            }

            //左侧图表数据更新
            function refreshline(){
                if(!myLineChart)
                    return;
                var lineoption=myLineChart.getOption();
                var datedata = [];
                var taskdata = [];
                var hashdata = [];
                for (var i = 0; i < 5; i++) {
                    datedata.push(historydata[i]["day_time"].substr(4,2)+"." + historydata[i]["day_time"].substr(6,2));
                    taskdata.push(Number(historydata[i]["num_total_task"]));
                    hashdata.push(Number(historydata[i]["num_total_hash"]/10000000000000).toFixed(2));
                }
                lineoption.xAxis[0].data = datedata;
                lineoption.series[0].data = hashdata;
                lineoption.series[1].data = taskdata;
                myLineChart.setOption(lineoption);
            }

            

            //右上角任务进度条刷新
            var old_taskdata = 0;

            function refresh_progress(taskdata){
            	$("#promenu").empty();
                for (var i = taskdata.length - 1; i >= 0; i--) {
                    var newprogress="<div id=\"delprogress" + i + "\" onclick=\"taskdetail("+taskdata[i]["task_id"]+")\" class=\"progress\"><div class=\"progress-bar\" role=\"progressbar\" aria-valuenow=\"60\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"background-color:#00CCFF;width: "+taskdata[i]["progress"]+"%;\"><span style=\"color:#484848;position:relative;float:left;left:50px\">" + taskdata[i]["task_id"]+":" + taskdata[i]["progress_name"] + "</span></div></div>";
                    $("#promenu").append(newprogress);
                    
                }
                old_taskdata = taskdata.length; 
            }

            //右下角log刷新
            var max_id = 0;//最大日志id
            var dynamic_inf_7 =[];//动态log队列
            function refresh_dyinf(infdata){;//小时

                var gettime = String(infdata[0]);
                var dynamic_inf_change = {"time":gettime, "information": infdata[1]}; 
                if(dynamic_inf_7.length == 20){
                    dynamic_inf_7.pop();
                };
                dynamic_inf_7.push(dynamic_inf_change);
                var dy_infor = document.getElementById("dy_inf");
                dy_inf.innerHTML = dynamic_inf_7[0]["time"] + ":   " + dynamic_inf_7[0]["information"] + "<br>";
                for (var i = 1; i < dynamic_inf_7.length; i ++) {
                    dy_inf.innerHTML += dynamic_inf_7[i]["time"] + ":   " + dynamic_inf_7[i]["information"] + "<br>";
                }
            }
            
            
            /*(静态信息)：
            {"num_total_hash":____,"num_total_task":_____}

            计算资源：
                [{“phy_loc”:(124.09, 341),”cname”:______},…],
            用户:
            [{“phy_loc“:____,”cname”:_____,”task_id":_____,"start_time":_____,"hash_type":_____,
            "estimated_finish”:_____,”nodes_to_use”:_____,”num_proc_hash”:___,”num_total_hash”:___},…]
                
            右下(日志比较特殊，需要一个自增id作为主键，页面间隔一段时间发送当前页面上最大id start_id给服务器以拉取服务器中id比start_id大的日志)；
                [{"log_id":_____,"time”:____,”content”:______},….] */ 

            function handle_stateinf(){
                var ltopconvert = [0,0,0];
                ltopconvert[0] = statedata["num_total_hash"];
                ltopconvert[1] = statedata["num_total_task"];
                ltopconvert[2] = userdata.length;
                ltopconvert[3] = statedata["num_queue_task"];
                refresh_situation(ltopconvert);
                
            }

            function srcanduser(chart){
                var convertdata = [
                ];
                
                for (var i = 0; i < srcdata.length; i ++){              //数组转换
                    var flag = false;//对应用户是否存在检查
                    var onedata = [  
                        {location:[113.0823,28.2568],value:{"phy_loc":""} },//起点
                        //终点
                        {location:[113.0823,28.2568],value:{"服务器id":"","任务id":"","开始时间":"" ,"hash_type":"","预计结束时间":"","nodeuse":0}}
                    ];
                    for(var j = 0; j < userdata.length;j ++) {         //找到对应的起点
                        if(userdata[j]["cname"] == srcdata[i]["cname"]){
                            flag = true;
                            //终点对应
                            var parts_1 = userdata[j]["phy_loc"].split(", ");
                            onedata[1].location[0] = Number(parts_1[0].substr(1, parts_1[0].length));
                            onedata[1].location[1] = Number(parts_1[1].substr(0, parts_1[1].length-1));
                            onedata[1].value["服务器id"] = userdata[j]["cname"];
                            onedata[1].value["任务id"] = userdata[j]["task_id"];
                            onedata[1].value["开始时间"] = String(userdata[j]["start_time"]);
                            onedata[1].value["hash_type"] = userdata[j]["hash_type"];
                            onedata[1].value["预计结束时间"] = String(userdata[j]["estimated_finish"]);
                            onedata[1].value["nodeuse"] = userdata[j]["nodes_to_use"];
                        }
                    }
                    //空闲服务器
                    if(!flag){
                        var parts_3 = srcdata[i]["phy_loc"].split(", ");
                        onedata[1].location[0] = Number(parts_3[0].substr(1, parts_3[0].length));
                        onedata[1].location[1] = Number(parts_3[1].substr(0, parts_3[1].length-1));
                        onedata[1].value["服务器id"] = "";
                        onedata[1].value["任务id"] = "";
                        onedata[1].value["开始时间"] = "";
                        onedata[1].value["hash_type"] = "";
                        onedata[1].value["预计结束时间"] = "";
                        onedata[1].value["nodeuse"] = 0;
                    }
                    //起点对应
                    //(113.10, 123.20)
                    var parts_2 = srcdata[i]["phy_loc"].split(", ");
                    onedata[0].location[0] = Number(parts_2[0].substr(1, parts_2[0].length));
                    onedata[0].location[1] = Number(parts_2[1].substr(0, parts_2[1].length-1));
                    onedata[0].value["phy_loc"] = srcdata[i]["phy_loc"];
                    if(srcdata[i]["state"] == "2"){
                        srcdata[i]["state"] = "离线";
                    }
                    else if(srcdata[i]["state"] == "1"){
                        srcdata[i]["state"] = "使用";
                    }
                    else srcdata[i]["state"] = "空闲";
                    //传入
                    convertdata.unshift(onedata);
                }
                refresh(chart,convertdata);
            }

            //右下角
            function log(){
                var rbotconvert = [0," "];
                for (var i = logdata.length - 1; i >= 0; i--) {
                    if(logdata[i]["log_id"] >= max_id) max_id = parseInt(logdata[i]["log_id"])+1;
                    rbotconvert[0] = logdata[i]["time"];
                    rbotconvert[1] = logdata[i]["content"];
                    refresh_dyinf(rbotconvert);
                }

            }
            function progress(){
                var totaltask = [];
                for (var i = userdata.length - 1; i >= 0; i--) {
                    var onetask = {"task_id":"","progress":0,"progress_name":""};
                    onetask["task_id"] = userdata[i]["task_id"];
                    onetask["progress_name"] = Number(userdata[i]["num_proc_hash"]/userdata[i]["num_total_hash"]*100.0).toFixed(2)+"%";
                    onetask["progress"] = 1.0*userdata[i]["num_proc_hash"]/userdata[i]["num_total_hash"]*100;
                    totaltask.unshift(onetask);
                }
                refresh_progress(totaltask);
            }

            //异步处理
            function ajax_stateinf(){
                $.ajax({
                        url: "<%=SERVLETPATH%>/OverviewServlet",
                        data: { 
                          "aimData": "<%=OverviewServlet.OPENUM.NUMINFO%>"
                        },
                        dataType: "json",
                        type: "GET",
                        async: false,
                        success: function(rdata) {
                            statedata = rdata;
                            //console.log("num_info", statedata)
                        },
                        error: function() { console.log("num data error!!!");}
                    });
            }

            function ajax_src(){
                $.ajax({
                        url: "<%=SERVLETPATH%>/OverviewServlet",
                        data: { 
                          "aimData":"<%=OverviewServlet.OPENUM.RESOURCEUSERINFO%>"
                        },
                        async: false,
                        dataType: "json",
                        type: "GET",
                        success: function(rdata) {
                            srcdata = rdata;
                            //console.log("resource_info", srcdata)
                        },
                        error: function() { console.log("resource data error!!!");}
                    });
            }

            function ajax_user(){
                $.ajax({
                        url: "<%=SERVLETPATH%>/OverviewServlet",
                        async: false,
                        data: { 
                          "aimData":"<%=OverviewServlet.OPENUM.TASKINFO%>"
                        },
                        dataType: "json",
                        type: "GET",
                        success: function(rdata) {
                            userdata = rdata;
                            //console.log("taskinfo", userdata)
                        },
                        error: function() { console.log("user data error!!!");}
                    });
            }

            function ajax_log(){
                $.ajax({
                        url: "<%=SERVLETPATH%>/OverviewServlet",
                        data: { 
                          "aimData": "<%=OverviewServlet.OPENUM.LOGS%>",
                          "start_id": max_id
                        },
                        async:false,
                        dataType: "json",
                        type: "GET",
                        success: function(rdata) {
                            logdata = rdata;
                            //console.log("log_data", logdata)
                        },
                        error: function() { console.log("log data error!!!");}
                    });
            }

            function ajax_history() {
            	$.ajax({
            		url: "<%=SERVLETPATH%>/OverviewServlet",
            		data: {
            			"aimData": "<%=OverviewServlet.OPENUM.CHARTINFO%>",
            		},
            		async:false,
            		dataType: "json",
            		type: "GET",
            		success: function(rdata) {
            			historydata = rdata;
            		},
            		error: function() {
            			console.log("History data error!");
            		}
            	})
            }
            
            refresh_all = function() {
                ajax_stateinf();
                ajax_src();
                ajax_user();
                ajax_log();
                ajax_history();
                
                refreshline();
                handle_stateinf();
                srcanduser(myChart);
                log();
                
                progress();

            };
            refresh_all();
			setInterval(refresh_all, 1000);

       });


        

</script>


 <div id="allshow" style="display: block;position:fixed;top:0%;height: 100%;width: 100%;right: 0%;background-color: #404a59;">
 <!--中间块-->

 <div id="middle" style="position: fixed;left: 25%;width: 55%;height: 100%">
     <div id="container" style="height: 70%"></div>
     <!--下方动态信息框-->
     <div style="height: 30%;background-color:rgba(50,60,72,0.75);border-style: solid;border-color: rgba(48,48,48,0.3);border-width: 4px;">
        <div id="dy_inf" style="height: 100%;color: #E0E0E0;overflow: auto;"></div>
     </div>
 </div>
<!--右侧数据-->
 <div id="rightshow" style="display: block;position: fixed;right: 0%;width: 20%;height: 100%;float: right;background-color: rgba(50,60,72,0.75)">
    <!--右侧任务完成进度等显示-->
    <div style="height: 100%;background-color:rgba(50,60,72,0.75);border-style: solid;border-color: rgba(48,48,48,0.3);border-width: 4px;color: #E0E0E0;text-align: center;">
        <p style="height:3%">任务进度</p> 
        <ul  id="promenu"  style="text-align: center;height: 90%;overflow: auto;padding: 5px;opacity: 0.75">
        </ul>
    </div>

</div>
<!--左侧数据-->
<div id="leftshow" style="display: block; position: fixed;left: 0%;width: 25%;height: 100%;float: left;background-color: rgba(50,60,72,0.75)">

    <!--左上角显示-->
    <div style="height: 30%;background-color:rgba(50,60,72,0.75);border-style: solid;border-color: rgba(48,48,48,0.3);border-width: 4px;">
    <div id="allinf" style="position: relative;font-size:15px;width: 98%; top:13%; left: 2%;color: #E0E0E0; float: left; opacity: 0.75;text-align:center">
        <br>总计算量
        <br>总任务数
        <br>活跃任务数
    </div>
    </div>
    <!--左侧图表-->
     <div id="lineMain" style="height: 40%;background-color:rgba(50,60,72,0.75);border-style: solid;border-color: rgba(48,48,48,0.3);border-width: 4px;color: #E0E0E0;text-align: left;overflow: auto;">

    </div>
    <!--左下角-->
    <div class="panel panel-inverse" style="height: 30%; bottom: 10%;left: 2%;overflow: auto;background-color: #212529;text-align: center;color: white;">
        <div class="panel-heading">超算节点资源信息</div>
        <table class="table table-inverse" id="compsrc" style="width:97%">
            <thead>
                <tr>
                  <th style="text-align: center;">节点描述</th>
                  <th style="text-align: center;">使用状态</th>
                </tr>
            </thead>
            <tbody>
            <tr>
              <td>国家超算长沙中心</td>
              <td>使用</td>
            </tr>
            <tr>
              <td>gpu节点1</td>
              <td>空闲</td>
            </tr>
          </tbody>
        </table>
    </div>
<!--隐藏-->
<div id="detail" class="alert alert-success alert-dismissable" style="display:none;width: 0px;height: 0px; position:fixed;left:0px;top:0px;font-size:12px;background-color:#FFFFFF">
<button type="button" class="close" onclick="Iclose()" title="close it">&times</button>

</div>
<script>
    function Iclose(){
        $("#detail").remove();
    }
    function taskdetail(tid){        
        for (var i = userdata.length - 1; i >= 0; i--) {
                if(userdata[i]["task_id"] == tid){
                    Iclose();
                    var detail = "<div id=\"detail\" class=\"alert alert-success alert-dismissable\" style=\"width: auto;height: auto; position:fixed;left:35%;top:30%;font-size:12px;background-color:#FFFFFF\"><button type=\"button\" class=\"close\" onclick=\"Iclose()\" title=\"close it\">&times</button\>"
                    +"使用服务器id： " + userdata[i]["cname"] + "<br>任务id： " + userdata[i]["task_id"] + "<br>开始时间： " + userdata[i]["start_time"] + "<br>hash_type： " + userdata[i]["hash_type"] + "<br>预计结束时间： " + userdata[i]["estimated_finish"] + " <br>正在使用节点数:" + userdata[i]["nodes_to_use"]; 
                    $("body").append(detail);
                    console.log(userdata[i]);
                    break;
                }
        }       
    }
</script>

</div>

   </body>
</html>