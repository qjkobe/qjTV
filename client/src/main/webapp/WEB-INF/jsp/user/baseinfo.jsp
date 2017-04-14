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
<%
    menuActive = "userinfo";
    subMenuActive = "baseinfo";
%>
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
                    信息管理</h3>
                <div class="page-bar">
                    <ul class="page-breadcrumb">
                        <li>
                            <i class="fa fa-home"></i>
                            <a href="index.html">信息管理</a>
                            <i class="fa fa-angle-right"></i>
                        </li>
                        <li>
                            <a href="#">基本信息</a>
                        </li>
                    </ul>

                </div>
                <!-- END PAGE HEADER-->

                <div class="col-md-8 ">
                    <!-- BEGIN SAMPLE FORM PORTLET-->
                    <div class="portlet light">
                        <div class="portlet-title">
                            <div class="caption font-green">
                                <i class="icon-pin font-green"></i>
                                <span class="caption-subject bold uppercase"> Floating Labels</span>
                            </div>
                        </div>
                        <div class="portlet-body form">
                            <form role="form" id="editform">
                                <input type="hidden" name="id" value="${userinfo.id}">
                                <input type="hidden" name="uid" value="${user.id}">
                                <div class="form-body">
                                    <div class="form-group form-md-line-input form-md-floating-label has-error">
                                        <input type="text" class="form-control" id="username" readonly value="${user.username}">
                                        <label for="username">用户名</label>
                                    </div>
                                    <div class="form-group form-md-line-input form-md-floating-label">
                                        <input type="text" class="form-control" id="nickname" name="nickname" value="${userinfo.nickname}">
                                        <label for="nickname">昵称</label>
                                        <span class="help-block">请修改昵称...</span>
                                    </div>
                                    <div class="form-group form-md-line-input form-md-floating-label">
                                        <input type="text" class="form-control" id="age" name="age" value="${userinfo.age}">
                                        <label for="nickname">年龄</label>
                                        <span class="help-block">请修改年龄...</span>
                                    </div>
                                    <div class="form-group form-md-line-input form-md-floating-label">
                                        <input type="text" class="form-control" id="phone" name="phone" value="${userinfo.phone}">
                                        <label for="nickname">手机号</label>
                                        <span class="help-block">请修改手机号...</span>
                                    </div>
                                </div>
                                <div class="form-actions noborder">
                                    <button type="button" class="btn blue" id="editinfo">修改</button>
                                    <%--<button type="button" class="btn default">Cancel</button>--%>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- END SAMPLE FORM PORTLET-->
                </div>

                <div><button id="goZhibo">进入我的直播间</button></div>
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
            2014 &copy; Metronic by keenthemes. <a href="http://themeforest.net/item/metronic-responsive-admin-dashboard-template/4021469?ref=keenthemes" title="Purchase Metronic just for 27$ and get lifetime updates for free" target="_blank">Purchase Metronic!</a>
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