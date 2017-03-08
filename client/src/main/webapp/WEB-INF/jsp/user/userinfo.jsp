<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/2/27
  Time: 10:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../commons/jsptag.jsp"%>
<html>
<head>
    <title>Title</title>
    <link type="text/css" rel="stylesheet" href="${ctx}/theme/css/fileinput.css" />
    <%@include file="../commons/headjs.jsp"%>
    <script type="text/javascript" src="${ctx}/theme/js/fileinput.js"></script>
    <script type="text/javascript" src="${ctx}/theme/js/fileinput_locale_zh.js"></script>
    <script type="text/javascript" src="${ctx}/theme/js/ajaxfileupload.js"></script>
</head>
<script>
    $(function(){
        $("#editinfo").click(function(){
            $.ajax({
                type: "POST",
                url: "/user/editinfo",
                data: $("#editform").serialize(),
                dataType: "json",
                success: function(data){
                    temp = eval(data);
                    if(temp.status == "success"){
                        alert("修改成功");
                        location.reload();
                    }else if(temp.status == "fail"){
                        alert("用户名或密码错误");
                    }
                },
                error: function(data){
                    alert("系统错误");
                }
            });
        });

        $("#logout").click(function(){
            $.ajax({
                type: "POST",
                url: "/login/logout",
                dataType: "json",
                success: function(data){
                    temp = eval(data);
                    if(temp.status == "success"){
                        alert("已登出");
                        history.go(0);
                    }
                },
                error: function(data){
                    alert("系统错误");
                }
            })
        })

        $("#goZhibo").click(function(){
            window.location.href = "/user/myZhibo?userId=${user.id}";
        })

        //文件上传
        var projectfileoptions = {
            showUpload : false,
            showRemove : false,
            language : 'zh',
            allowedPreviewTypes : [ 'image' ],
            allowedFileExtensions : [ 'jpg', 'png', 'gif' ],
            maxFileSize : 2000,
        };
        // 文件上传框
        $('input[class=projectfile]').each(function() {
            var imageurl = $(this).attr("value");

            if (imageurl) {
                var op = $.extend({
                    initialPreview : [ // 预览图片的设置
                        "<img src='" + imageurl + "' class='file-preview-image'>", ]
                }, projectfileoptions);

                $(this).fileinput(op);
            } else {
                $(this).fileinput(projectfileoptions);
            }
        });
        //文件上传按钮
        //TODO:预览文件直接保存。filename为空，需要后台处理
        $("#upload_btn").click(function(){
            if($("#uploadfile").val() == ""){
                alert("请上传正确的文件");
            }else{
                $.ajaxFileUpload({
                    secureuri:false,
                    url:'${ctx}/user/uploadlogo',
                    beforeSend:function(){},
                    fileElementId:'uploadfile',
                    type: 'post',
                    dataType: 'json',
                    //data:{sessionId:'${sessionId}'},
                    success:function(data, status){
                        temp = eval(data);
                        if(temp.status == "success"){
                            alert("上传成功!");
                            history.go(0);
                        }else if(temp.status == "error"){
                            alert("文件为空");
                        }
                    },
                    error:function(XmlHttpRequest,textStatus,errorThrown){
    //                    alert(XmlHttpRequest.status);
    //                    alert(XmlHttpRequest.readyState);
    //                    alert(textStatus);
                        alert("上传失败！");
                    }
                });
            }
        });
    });
</script>
<body>
<form action="" id="editform" method="post">
    <input type="hidden" name="id" value="${userinfo.id}">
    <input type="hidden" name="uid" value="${user.id}">
    用户名：<input type="text" id="username" value="${user.username}" readonly="readonly">
    昵称：<input type="text" id="nickname" name="nickname" value="${userinfo.nickname}">
    年龄: <input type="text" id="age" name="age" value="${userinfo.age}">
    手机号：<input type="text" id="phone" name="phone" value="${userinfo.phone}">
    <input type="button" id="editinfo" value="修改">
</form>
<button id="logout">登出</button>
<br>
头像：<input type="hidden" id="headimg" name="headimg" value="${userinfo.headimg}">
<div><img src="${ctx}/upload/logo/${userinfo.headimg}" width="150" height="150" alt="头像"></div>
<div class="row">
    <div class="col-xs-6">
        <form class="form-horizontal required-validate" action="" enctype="multipart/form-data" method="post">
            <div class="form-group">
                <label class="col-md-1 control-label">头像设置</label>
                <div class="col-md-10 tl th">
                    <input type="file" id="uploadfile" name="uploadfile" class="projectfile" value="${ctx}/upload/logo/${userinfo.headimg}" />
                    <p class="help-block">支持jpg、jpeg、png、gif格式，大小不超过2.0M</p>
                </div>
            </div>
            <div class="form-group text-center ">
                <div class="col-md-10 col-md-offset-1">
                    <button id="upload_btn" type="button" class="btn btn-primary btn-lg">保存</button>
                </div>
            </div>
        </form>
    </div>
</div>

<div><button id="goZhibo">进入我的直播间</button></div>
</body>
</html>
