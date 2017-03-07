<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/2/27
  Time: 11:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../commons/jsptag.jsp"%>
<html>
<head>
    <title>我的直播间</title>
    <%@include file="../commons/headjs.jsp"%>
    <link type="text/css" rel="stylesheet" href="${ctx}/theme/css/fileinput.css" />
    <script type="text/javascript" src="${ctx}/theme/js/fileinput.js"></script>
    <script type="text/javascript" src="${ctx}/theme/js/fileinput_locale_zh.js"></script>
    <script type="text/javascript" src="${ctx}/theme/js/ajaxfileupload.js"></script>
    <script type="text/javascript" src="${ctx}/theme/flowplayer/flowplayer-3.2.8.min.js"></script>
</head>
<script>
    $(function(){
        $("#openRoom").click(function(){
            $.ajax({
                type: "POST",
                url: "/live/openRoom",
                data: {
                    id: "${liveroom.id}",
                    islive: 1
                },
                dataType: "json",
                success: function(data){
                    temp = eval(data);
                    if(temp.status == "success"){
                        alert("直播间已开启，请按下方串流码进行直播");
                    }
                },
                error: function(data){
                    alert("系统错误");
                }
            });

        })

        $("#closeRoom").click(function(){
            $.ajax({
                type: "POST",
                url: "/live/openRoom",
                data: {
                    id: "${liveroom.id}",
                    islive: 0
                },
                dataType: "json",
                success: function(data){
                    temp = eval(data);
                    if(temp.status == "success"){
                        alert("直播间已关闭，请停止串流，不然依旧可以在直播间看见画面");
                    }
                },
                error: function(data){
                    alert("系统错误");
                }
            });
        });

        $("#setCover").click(function(){
            $("#uploadCover").removeClass("hidden");
        });
        $("#cancel_btn").click(function(){
            $("#uploadCover").addClass("hidden");
        });

        //文件上传
        var projectfileoptions = {
            showUpload : false,
            showRemove : false,
            language : 'zh',
            allowedPreviewTypes : [ 'image' ],
            allowedFileExtensions : [ 'jpg', 'png' ],
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
                    url:'${ctx}/live/setCover',
                    beforeSend:function(){},
                    fileElementId:'uploadfile',
                    type: 'post',
                    dataType: 'json',
                    data:{id: "${liveroom.id}"},
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

        $("#saveTitle").click(function(){
            $.ajax({
                type: "POST",
                url: "/live/editRoomInfo",
                data: {
                    id: "${liveroom.id}",
                    title: $("#roomTitle").val()
                },
                dataType: "json",
                success: function(data){
                    temp = eval(data);
                    if(temp.status == "success"){
                        alert("房间标题修改成功");
                        history.go(0);
                    }
                },
                error: function(data){
                    alert("系统错误");
                }
            });
        });
    })
</script>
<body>
<h1>${userinfo.nickname}的直播间</h1>
<h2>直播标题：${liveroom.title}</h2>
<%--TODO: 修改标题待做--%>
<button id="changeTitle" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#titleModal">修改标题</button>
<div>
    <button id="openRoom">开启直播间</button>
    <button id="closeRoom">关闭直播间</button>
    <br>
    <strong>串流地址</strong><p id="app">${liveroom.app}</p><br>
    <strong>串流码</strong><p id="stream">${liveroom.stream}</p><br>
    <button id="setCover">设置直播封面</button>
</div>
<div class="row hidden" id="uploadCover">
    <div class="col-xs-6">
        <form class="form-horizontal required-validate" action="" enctype="multipart/form-data" method="post">
            <div class="form-group">
                <label class="col-md-1 control-label">封面设置</label>
                <div class="col-md-10 tl th">
                    <input type="file" id="uploadfile" name="uploadfile" class="projectfile" value="${ctx}/upload/cover/${liveroom.img}" />
                    <p class="help-block">支持jpg、jpeg、png、gif格式，大小不超过2.0M</p>
                </div>
            </div>
            <div class="form-group text-center ">
                <div class="col-md-10 col-md-offset-1">
                    <button id="upload_btn" type="button" class="btn btn-primary btn-lg">保存</button>
                    <button id="cancel_btn" type="button" class="btn btn-primary btn-lg">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- this A tag is where your Flowplayer will be placed. it can be anywhere -->
<a
        href="#"
style="display:block;width:720px;height:576px"
id="player">
</a>
<!-- this will install flowplayer inside previous A- tag. -->
<script>
    flowplayer("player", "${ctx}/theme/flowplayer/flowplayer-3.2.8.swf",{
        clip: {
            url: '${liveroom.stream}', //流名称
            provider: 'rtmp',
            live: true,
        },
        plugins: {
            rtmp: {
                url: '${ctx}/theme/flowplayer/flowplayer.rtmp-3.2.8.swf',
                netConnectionUrl: 'rtmp://115.159.62.204:1935/${liveroom.app}/' //服务器地址
            }
        }
    });
</script>

<p>
    <%--Sample RTMP URL (Live) is "rtmp://115.159.62.204:1935/qunima/123"--%>
</p>

<div class="modal fade" id="titleModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">修改标题</h4>
            </div>
            <div class="modal-body">
                <input id="roomTitle" type="text" value="${liveroom.title}">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="saveTitle">提交更改</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</body>
</html>
