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
    <%@include file="../commons/userheadjs.jsp"%>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href="${ctx}/theme/assets/global/plugins/select2/select2.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/theme/assets/global/plugins/datatables/extensions/Scroller/css/dataTables.scroller.min.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/theme/assets/global/plugins/datatables/extensions/ColReorder/css/dataTables.colReorder.min.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/theme/assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"/>
    <!-- END PAGE LEVEL STYLES -->
</head>
<!-- END HEAD -->
<%
    menuActive = "chengjiu";
    subMenuActive = "chengjiu";
%>
<script>
    $(function(){
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
                    成就管理</h3>
                <div class="page-bar">
                    <ul class="page-breadcrumb">
                        <li>
                            <i class="fa fa-home"></i>
                            <a href="index.html">成就管理</a>
                            <i class="fa fa-angle-right"></i>
                        </li>
                        <li>
                            <a href="#">成就管理</a>
                        </li>
                    </ul>
                </div>
                <!-- END PAGE HEADER-->
                <div class="row">
                    <div class="col-md-12">
                        <!-- BEGIN EXAMPLE TABLE PORTLET-->
                        <div class="portlet box blue-hoki">
                            <div class="portlet-title">
                                <div class="caption">
                                    <i class="fa fa-globe"></i>成就排行
                                </div>
                            </div>
                            <div class="portlet-body">
                                <table class="table table-striped table-bordered table-hover" id="sample_1">
                                    <thead>
                                    <tr>
                                        <th>
                                            主播昵称
                                        </th>
                                        <th>
                                            直播间号
                                        </th>
                                        <th class="hidden-xs">
                                            总共送礼
                                        </th>
                                        <th class="hidden-xs">
                                            直播间排行
                                        </th>
                                        <th class="hidden-xs">
                                            全站排行
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:if test="${chengjiuList == 'nogift'}">
                                        <tr>
                                            <td >
                                                你还没有给别人送礼过
                                            </td>
                                            <td >

                                            </td>
                                            <td >

                                            </td>
                                            <td >

                                            </td>
                                            <td >

                                            </td>
                                        </tr>
                                    </c:if>
                                    <c:if test="${chengjiuList != 'nogift'}">
                                    <c:forEach items="${chengjiuList}" var="item" varStatus="st">
                                    <tr>
                                        <td id="${item.zhuboid}name">
                                            <script>
                                                $.ajax({
                                                    type: "POST",
                                                    url: "/index/getnick",
                                                    data: {
                                                        uid: "${item.zhuboid}"
                                                    },
                                                    dataType: "json",
                                                    success: function(data){
                                                        temp = eval(data);
                                                        if(temp.status == "success"){
                                                            $("#${item.zhuboid}name").html(temp.nickname);
                                                        }
                                                    },
                                                    error: function(data){
                                                        alert("系统错误");
                                                    }
                                                });
                                            </script>
                                        </td>
                                        <td id="${item.zhuboid}room">
                                            <script>
                                                $.ajax({
                                                    type: "POST",
                                                    url: "/index/getRoomNum",
                                                    data: {
                                                        uid: "${item.zhuboid}"
                                                    },
                                                    dataType: "json",
                                                    success: function(data){
                                                        temp = eval(data);
                                                        if(temp.status == "success"){
                                                            $("#${item.zhuboid}room").html(temp.roomNum);
                                                        }
                                                    },
                                                    error: function(data){
                                                        alert("系统错误");
                                                    }
                                                });
                                            </script>
                                        </td>
                                        <td>
                                            ${item.total}
                                        </td>
                                        <td>
                                            x
                                        </td>
                                        <td>
                                            x
                                        </td>
                                    </tr>
                                    </c:forEach>
                                    </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!-- END EXAMPLE TABLE PORTLET-->
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
<!-- BEGIN PAGE LEVEL PLUGINS -->

<!-- END PAGE LEVEL PLUGINS -->
<script>
    jQuery(document).ready(function() {
        Metronic.init(); // init metronic core components
        Layout.init(); // init current layout
        Demo.init(); // init demo features
        TableAdvanced.init();
    });
</script>
<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>