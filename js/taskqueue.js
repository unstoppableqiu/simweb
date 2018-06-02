var tab = "past";
var selected = null;
var taskqueueTable = $("#taskqueue_table");
var mask = $("#mask");
var resourceTable = $("#resource_table");
$("#tab_buttons").on("click", "li", (function () {
    tab = $(this).attr("id");
    taskqueueTable.DataTable().clear();
}));
$("tbody" ).on("click", ".hash_string", function (e) {
    var hash_string = $(this).children("img").attr("alt")
    $("#description_text3").text(hash_string);
    $("#detail3").slideDown(300).css("display", "block");
    mask.fadeIn(300);
});
$(".close").click(function (e) {
    $("#detail3").slideUp(300).css("display", "none");
    mask.fadeOut(300);
});
// 单选
resourceTable.on("click", "tr", function () {
    if (!$(this).hasClass("selected"))
        $(".selected").removeClass("selected");
    $(this).toggleClass("selected");

});
taskqueueTable.on("click", "tr", function () {
    if (!$(this).hasClass("selected"))
        $(".selected").removeClass("selected");
    $(this).toggleClass("selected");
    selected = taskqueueTable.DataTable().row($(this)).data();
});
// 分配任务
$("#assign_btn").click(function () {
    var selected = $(".selected");
    if (selected) {
        $("#select_resource").slideDown(300);
        mask.fadeIn(300);
        var data = taskqueueTable.DataTable().row(selected[0]).data();
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
$("#delete_task_btn3").click(function() {
    $("#delete3").slideDown(300);
    mask.fadeIn(300);
    $("#taskqueueId").val(selected["taskId"]);
});
$("#confirm_delete_btn3").click(function() {
    $.ajax({
        "type": "POST",
        "url": "../task/remove",
        "data": {
            "taskId": $("#taskqueueId").val()
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
    $("#delete3").slideUp(300);
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
taskqueueTable.DataTable({
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
        "url": "../task/queue",
        "dataType": "json"
    },
    "columns": [
        {"data": "submitTime"},
        {"data": "taskId"},
        {"data": "submitUser"},
        {"data": "hashType"},
        {"data": "hashString"},
        {"data": "numTotalHash"},
        {"data": "status"},
        {"data": "lastSrvUpdate"}
    ],
    "columnDefs":[{
        "targets":6,
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
            "targets": [4, 7],
            "render": function (data) {
                return '<span class="hash_string" style="font-size:10px;text-align:center;display:inline-block;background-color:#FFFFFF;border-radius:5px;width:60px;color:white">' +
                    '<img src="../../image/detail.png" alt="' + data + '"/></span>';
            }
        }
    ]
});