<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/3/1
  Time: 15:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../commons/jsptag.jsp"%>

<!DOCTYPE html>
<!--
Template Name: Metronic - Responsive Admin Dashboard Template build with Twitter Bootstrap 3.3.5
Version: 4.1.0
Author: KeenThemes
Website: http://www.keenthemes.com/
Contact: support@keenthemes.com
Follow: www.twitter.com/keenthemes
Like: www.facebook.com/keenthemes
Purchase: http://themeforest.net/item/metronic-responsive-admin-dashboard-template/4021469?ref=keenthemes
License: You must have a valid license purchased only from themeforest(the above link) in order to legally use the theme for your project.
-->
<!-- BEGIN HEAD -->
<head>
    <meta charset="utf-8"/>
    <title>QjTV-所有直播</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport"/>
    <%@include file="../commons/headjs.jsp"%>
</head>
<!-- END HEAD -->
<script>
    $(function(){
        $("#myFollow").click(function(){
            $.ajax({
                type: "POST",
                url: "/index/myFollow",
                dataType: "json",
                success: function(data){
                    temp = eval(data);
                    if(temp.status == "success"){
                        $("#followList").removeClass("hidden");
                        if(temp.followList == 0){
                            $("#noFollow").removeClass("hidden");
                            $("#followed").addClass("hidden");
                        }else{
                            $("#noFollow").addClass("hidden");
                            $("#followed").removeClass("hidden");
                            if(temp.kaibos == 0){
                                $("#kaibos").html("还没有关注的主播开播");
                            }else {
                                //拼接字符串
                                var result1 = "";
                                result1 += "<ul>";
                                for (i = 0; i < temp.kaibos.length; i++) {
                                    result1 += "<li>";
                                    result1 += "<a href='/index/toRoom/" + temp.kaibos[i].roomnum + "' title='点击进入直播间'>";
                                    result1 += temp.kaibos[i].title + "</a>";
                                    result1 += "</li>";
                                }
                                result1 += "</ul>";
                                $("#kaibos").html(result1);
                            }
                            if(temp.weikaibos == 0){
                                $("#weikaibos").html("还没有关注的主播未开播");
                            }else{
                                var result2 = "";
                                result2 += "<ul>";
                                for(i = 0; i < temp.weikaibos.length; i++){
                                    result2 += "<li>";
                                    result2 += "<a href='/index/toRoom/" + temp.weikaibos[i].roomnum + "' title='点击进入直播间'>";
                                    result2 += temp.weikaibos[i].title + "</a>";
                                    result2 += "</li>";
                                }
                                result2 += "</ul>";
                                $("#weikaibos").html(result2);
                            }
                        }

                    }else if(temp.status == "nologin"){
                        alert("请先登录");
                    }
                },
                error: function(data){
                    alert("系统错误");
                }
            })
        });

        $("#fold").click(function(){
            $("#followList").addClass("hidden");
        })
    })
</script>
<!-- BEGIN BODY -->
<body class="page-md page-header-fixed page-quick-sidebar-over-content page-sidebar-closed-hide-logo ">
<%@include file="../commons/top.jsp"%>
<div class="clearfix">
</div>
<!-- BEGIN CONTAINER -->
<div class="page-container">
    <%@include file="../commons/left.jsp"%>
    <!-- BEGIN CONTENT -->
    <div class="page-content-wrapper">
        <div class="page-content">
            <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
            <div class="modal fade" id="portlet-config" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                            <h4 class="modal-title">模态框示例</h4>
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
                所有直播 <small>我 & 你</small>
            </h3>
            <div class="page-bar">
                <ul class="page-breadcrumb">
                    <li>
                        <i class="fa fa-home"></i>
                        <a href="index.html">所有分类</a>
                        <i class="fa fa-angle-right"></i>
                    </li>
                    <li>
                        <a href="#">守望先锋</a>
                    </li>
                </ul>
            </div>
            <!-- END PAGE HEADER-->
            <button id="myFollow">我的关注</button>
            <div class="hidden" id="followList">
                <div id="noFollow" class="hidden">
                    还没有关注过主播
                </div>
                <div id="followed">
                    已开播：<br>
                    <div id="kaibos">

                    </div>
                    未开播：<br>
                    <div id="weikaibos">

                    </div>
                </div>
                <button id="fold">收起</button>
            </div>
            <div class="row">
                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <c:if test="${liveroom == 'none'}">
                        当前没有任何直播
                    </c:if>
                    <c:if test="${liveroom != 'none'}">
                        <a href="/index/toRoom/${liveroom.roomnum}" title="点击进入直播间">
                            <img src="${ctx}/upload/cover/${liveroom.img}" width="300" height="200" alt="点击进入直播间">
                        </a><br>
                        <strong>${liveroom.title}</strong>
                    </c:if>
                </div>
            </div>
            <div class="clearfix">
            </div>

        </div>
    </div>
    <!-- END CONTENT -->

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
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<%@include file="../commons/footjs.jsp"%>
<script>
    jQuery(document).ready(function() {
        Metronic.init(); // init metronic core componets
        Layout.init(); // init layout
        QuickSidebar.init(); // init quick sidebar
        Demo.init(); // init demo features
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