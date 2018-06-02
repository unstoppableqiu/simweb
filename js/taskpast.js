var tab = "past";
var selected = null;
var taskpastTable = $("#taskpast_table");
var mask = $("#mask");
$("#tab_buttons").on("click", "li", (function () {
    tab = $(this).attr("id");
    taskpastTable.DataTable().clear();
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
taskpastTable.on("click", "tr", function () {
    if (!$(this).hasClass("selected"))
        $(".selected").removeClass("selected");
    $(this).toggleClass("selected");
    selected = taskpastTable.DataTable().row($(this)).data();
});

$("#delete_task_btn1").click(function() {
    $("#delete").slideDown(300);
    mask.fadeIn(300);
    $("#taskpastId").val(selected["taskId"]);
    console.log('click');
});
$("#confirm_delete_btn1").click(function() {
    $.ajax({
        "type": "POST",
        "url": "../task/remove",
        "data": {
            "taskId": $("#taskpastId").val()
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
taskpastTable.DataTable({
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
        {"data": "startTime"},
        {"data": "numTotalHash"},
        {"data": "status"},
        {"data": "result"},
        {"data": "lastSrvUpdate"},
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
            "targets":7,
            "render": function ( data, type, row ) {
                if(data==="-1")
                    return '<span style="font-size:10px;text-align:center;display:inline-block;background-color:#CCCCCC;border-radius:5px;width:60px;color:white">Unknown</span>';
                else
                    return data;
            }}
    ]
});