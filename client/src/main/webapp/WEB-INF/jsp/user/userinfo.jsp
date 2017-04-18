<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/2/27
  Time: 10:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../commons/jsptag.jsp"%>
<!DOCTYPE html>
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <meta charset="utf-8"/>
    <title>QjTV-后台管理</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport"/>
    <meta content="" name="description"/>
    <meta content="" name="author"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/theme/css/fileinput.css" />
    <%@include file="../commons/userheadjs.jsp"%>
    <script type="text/javascript" src="${ctx}/theme/js/fileinput.js"></script>
    <script type="text/javascript" src="${ctx}/theme/js/fileinput_locale_zh.js"></script>
    <script type="text/javascript" src="${ctx}/theme/js/ajaxfileupload.js"></script>
</head>
<!-- END HEAD -->
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
<!-- BEGIN BODY -->
<body class="page-md page-boxed page-header-fixed page-sidebar-closed-hide-logo page-container-bg-solid page-sidebar-closed-hide-logo">
<%@include file="../commons/usertop.jsp"%>
<div class="clearfix">
</div>
<!-- BEGIN CONTAINER -->
<div class="container">
    <div class="page-container">
        <%@include file="../commons/userleft.jsp"%>
        <!-- BEGIN CONTENT -->
        <div class="page-content-wrapper">
            <div class="page-content">
                <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
                <div class="modal fade" id="portlet-config" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                <h4 class="modal-title">Modal title</h4>
                            </div>
                            <div class="modal-body">
                                Widget settings form goes here
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn blue">Save changes</button>
                                <button type="button" class="btn default" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
                <!-- /.modal -->
                <!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->
                <!-- BEGIN PAGE HEADER-->
                <h3 class="page-title">
                    Dashboard</h3>
                <div class="page-bar">
                    <ul class="page-breadcrumb">
                        <li>
                            <i class="fa fa-home"></i>
                            <a href="index.html">Home</a>
                            <i class="fa fa-angle-right"></i>
                        </li>
                        <li>
                            <a href="#">Dashboard</a>
                        </li>
                    </ul>
                    <div class="page-toolbar">
                        <div id="dashboard-report-range" class="tooltips btn btn-fit-height btn-sm green-haze btn-dashboard-daterange" data-container="body" data-placement="left" data-original-title="Change dashboard date range">
                            <i class="icon-calendar"></i>
                            &nbsp;&nbsp; <i class="fa fa-angle-down"></i>
                            <!-- uncomment this to display selected daterange in the button
&nbsp; <span class="thin uppercase visible-lg-inline-block"></span>&nbsp;
<i class="fa fa-angle-down"></i>
 -->
                        </div>
                    </div>
                </div>
                <!-- END PAGE HEADER-->

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


            </div>
        </div>
        <!-- END CONTENT -->
        <!-- BEGIN QUICK SIDEBAR -->
        <!--Cooming Soon...-->
        <!-- END QUICK SIDEBAR -->
    </div>
    <!-- END CONTAINER -->
    <!-- BEGIN FOOTER -->
    <div class="page-footer">
        <div class="page-footer-inner">
            2017 &copy; QjTV by QJKOBE.
        </div>
        <div class="scroll-to-top">
            <i class="icon-arrow-up"></i>
        </div>
    </div>
    <!-- END FOOTER -->
</div>
<%@include file="../commons/userfootjs.jsp"%>
<script>
    jQuery(document).ready(function() {
        Metronic.init(); // init metronic core componets
        Layout.init(); // init layout
        Demo.init(); // init demo features
        QuickSidebar.init(); // init quick sidebar
        Index.init();
        Index.initDashboardDaterange();
        Index.initJQVMAP(); // init index page's custom scripts
        Index.initCalendar(); // init index page's custom scripts
        Index.initCharts(); // init index page's custom scripts
        Index.initChat();
        Index.initMiniCharts();
        Tasks.initDashboardWidget();
    });
</script>
<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>