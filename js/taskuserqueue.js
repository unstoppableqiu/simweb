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
$("#taskqueue_table").DataTable({
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
        "url": "../task/user_queue",
        "dataType": "json"
    },
    "columns": [
        {"data": "submitTime"},
        {"data": "taskId"},
        {"data": "hashType"},
        {"data": "hashString"},
        {"data": "numTotalHash"},
        {"data": "status"},
        {"data": "lastSrvUpdate"}
    ],
    "columnDefs":[{
        "targets":5,
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
          "targets": 3,
          "render": function (data) {
              return '<span class="hash_string" style="font-size:10px;text-align:center;display:inline-block;background-color:#FFFFFF;border-radius:5px;width:60px;color:white">' +
                  '<img src="../../image/detail.png" alt="' + data + '"/></span>';
          }
        },
        {
        "targets":4,
        "render": function ( data, type, row ) {
            if(data==="\"null\"")
                return '<span style="font-size:10px;text-align:center;display:inline-block;background-color:#CCCCCC;border-radius:5px;width:60px;color:white">Unknown</span>';
            else
                return data;
        }}
    ]
});