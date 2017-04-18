<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- BEGIN HEADER -->
<div class="page-header md-shadow-z-1-i navbar navbar-fixed-top">
    <!-- BEGIN HEADER INNER -->
    <div class="page-header-inner container">
        <!-- BEGIN LOGO -->
        <div class="page-logo">
            <a href="index.html">
                <img src="${ctx}/theme/assets/admin/layout2/img/qjlogo2.png" alt="logo" class="logo-default"/>
            </a>
            <div class="menu-toggler sidebar-toggler">
                <!-- DOC: Remove the above "hide" to enable the sidebar toggler button on header -->
            </div>
        </div>
        <!-- END LOGO -->
        <!-- BEGIN RESPONSIVE MENU TOGGLER -->
        <a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse">
        </a>
        <!-- END RESPONSIVE MENU TOGGLER -->
        <!-- BEGIN PAGE ACTIONS -->
        <!-- DOC: Remove "hide" class to enable the page header actions -->
        <div class="page-actions hide">
            <div class="btn-group">
                <button type="button" class="btn btn-circle red-pink dropdown-toggle" data-toggle="dropdown">
                    <i class="icon-bar-chart"></i>&nbsp;<span class="hidden-sm hidden-xs">New&nbsp;</span>&nbsp;<i class="fa fa-angle-down"></i>
                </button>
                <ul class="dropdown-menu" role="menu">
                    <li>
                        <a href="javascript:;">
                            <i class="icon-user"></i> New User </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <i class="icon-present"></i> New Event <span class="badge badge-success">4</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <i class="icon-basket"></i> New order </a>
                    </li>
                    <li class="divider">
                    </li>
                    <li>
                        <a href="javascript:;">
                            <i class="icon-flag"></i> Pending Orders <span class="badge badge-danger">4</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <i class="icon-users"></i> Pending Users <span class="badge badge-warning">12</span>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="btn-group">
                <button type="button" class="btn btn-circle green-haze dropdown-toggle" data-toggle="dropdown">
                    <i class="icon-bell"></i>&nbsp;<span class="hidden-sm hidden-xs">Post&nbsp;</span>&nbsp;<i class="fa fa-angle-down"></i>
                </button>
                <ul class="dropdown-menu" role="menu">
                    <li>
                        <a href="javascript:;">
                            <i class="icon-docs"></i> New Post </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <i class="icon-tag"></i> New Comment </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <i class="icon-share"></i> Share </a>
                    </li>
                    <li class="divider">
                    </li>
                    <li>
                        <a href="javascript:;">
                            <i class="icon-flag"></i> Comments <span class="badge badge-success">4</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;">
                            <i class="icon-users"></i> Feedbacks <span class="badge badge-danger">2</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
        <!-- END PAGE ACTIONS -->
        <!-- BEGIN PAGE TOP -->
        <div class="page-top">
            <!-- BEGIN HEADER SEARCH BOX -->
            <!-- DOC: Apply "search-form-expanded" right after the "search-form" class to have half expanded search box -->
            <form class="search-form search-form-expanded" action="extra_search.html" method="GET">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search..." name="query">
					<span class="input-group-btn">
					<a href="javascript:;" class="btn submit"><i class="icon-magnifier"></i></a>
					</span>
                </div>
            </form>
            <!-- END HEADER SEARCH BOX -->
            <!-- BEGIN TOP NAVIGATION MENU -->
            <div class="top-menu">
                <ul class="nav navbar-nav pull-right">
                    <!-- BEGIN NOTIFICATION DROPDOWN -->
                    <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                    <li class="dropdown dropdown-extended dropdown-notification" id="header_notification_bar">
                        <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                            <i class="icon-bell"></i>
						<span class="badge badge-default kaibos">
						0 </span>
                        </a>
                        <ul class="dropdown-menu">
                            <li class="external">
                                <h3><span class="bold kaibos">0 </span> 已开播</h3>
                                <%--<a href="extra_profile.html">view all</a>--%>
                            </li>
                            <li>
                                <ul id="kaibos" class="dropdown-menu-list scroller" style="height: 250px;" data-handle-color="#637283">
                                    <li>
                                        <a href="javascript:;">
                                            <span class="time">嘤嘤嘤</span>
										<span class="details">
										<span class="label label-sm label-icon label-success">
										<i class="fa fa-bullhorn"></i>
										</span>
										稍等，还在加载 </span>
                                        </a>
                                    </li>

                                </ul>
                            </li>
                        </ul>
                    </li>
                    <!-- END NOTIFICATION DROPDOWN -->
                    <!-- BEGIN INBOX DROPDOWN -->
                    <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                    <%--收件箱待做--%>
                    <%--<li class="dropdown dropdown-extended dropdown-inbox" id="header_inbox_bar">--%>
                        <%--<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">--%>
                            <%--<i class="icon-envelope-open"></i>--%>
						<%--<span class="badge badge-default">--%>
						<%--4 </span>--%>
                        <%--</a>--%>
                        <%--<ul class="dropdown-menu">--%>
                            <%--<li class="external">--%>
                                <%--<h3>You have <span class="bold">7 New</span> Messages</h3>--%>
                                <%--<a href="page_inbox.html">view all</a>--%>
                            <%--</li>--%>
                            <%--<li>--%>
                                <%--<ul class="dropdown-menu-list scroller" style="height: 275px;" data-handle-color="#637283">--%>
                                    <%--<li>--%>
                                        <%--<a href="inbox.html?a=view">--%>
										<%--<span class="photo">--%>
										<%--<img src="${ctx}/theme/assets/admin/layout3/img/avatar2.jpg" class="img-circle" alt="">--%>
										<%--</span>--%>
										<%--<span class="subject">--%>
										<%--<span class="from">--%>
										<%--Lisa Wong </span>--%>
										<%--<span class="time">Just Now </span>--%>
										<%--</span>--%>
										<%--<span class="message">--%>
										<%--Vivamus sed auctor nibh congue nibh. auctor nibh auctor nibh... </span>--%>
                                        <%--</a>--%>
                                    <%--</li>--%>
                                    <%--<li>--%>
                                        <%--<a href="inbox.html?a=view">--%>
										<%--<span class="photo">--%>
										<%--<img src="${ctx}/theme/assets/admin/layout3/img/avatar3.jpg" class="img-circle" alt="">--%>
										<%--</span>--%>
										<%--<span class="subject">--%>
										<%--<span class="from">--%>
										<%--Richard Doe </span>--%>
										<%--<span class="time">16 mins </span>--%>
										<%--</span>--%>
										<%--<span class="message">--%>
										<%--Vivamus sed congue nibh auctor nibh congue nibh. auctor nibh auctor nibh... </span>--%>
                                        <%--</a>--%>
                                    <%--</li>--%>

                                <%--</ul>--%>
                            <%--</li>--%>
                        <%--</ul>--%>
                    <%--</li>--%>
                    <!-- END INBOX DROPDOWN -->

                    <!-- BEGIN USER LOGIN DROPDOWN -->
                    <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                    <li class="dropdown dropdown-user">
                        <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                            <img alt="" class="img-circle" src="${ctx}/upload/logo/${infoinfo.headimg}"/>
						<span class="username username-hide-on-mobile">
                        ${infoinfo.nickname} </span>
                            <i class="fa fa-angle-down"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-default">
                            <li>
                                <a href="/user/userinfo">
                                    <i class="icon-user"></i> 我的资料 </a>
                            </li>

                            <%--<li>--%>
                                <%--<a href="inbox.html">--%>
                                    <%--<i class="icon-envelope-open"></i> My Inbox <span class="badge badge-danger">--%>
								<%--3 </span>--%>
                                <%--</a>--%>
                            <%--</li>--%>
                            <li>
                                <a href="/manage/getFollow">
                                    <i class="icon-rocket"></i> 我的关注 <span class="badge badge-success guanzhus">
								0 </span>
                                </a>
                            </li>
                            <li class="divider">
                            </li>
                            <li>
                                <a href="" class="logout">
                                    <i class="icon-key"></i> Log Out </a>
                            </li>
                        </ul>
                    </li>
                    <!-- END USER LOGIN DROPDOWN -->
                    <!-- BEGIN USER LOGIN DROPDOWN -->
                    <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                    <li class="dropdown dropdown-extended quick-sidebar-toggler logout">
                        <span class="sr-only">log out</span>
                        <i class="icon-logout"></i>
                    </li>
                    <!-- END USER LOGIN DROPDOWN -->
                </ul>
            </div>
            <!-- END TOP NAVIGATION MENU -->
        </div>
        <!-- END PAGE TOP -->
    </div>
    <!-- END HEADER INNER -->
</div>
<!-- END HEADER -->
<script>
    $(function() {
        $.ajax({
            type: "POST",
            url: "/index/myFollow",
            dataType: "json",
            success: function(data){
                temp = eval(data);
                if(temp.status == "success"){
                    $(".kaibos").html(temp.kaibos.length);
                    $(".guanzhus").html(temp.followList.length);
                    //拼接字符串
                    var result1 = "";
                    for (i = 0; i < temp.kaibos.length; i++) {
                        result1 += '<li><a href="/index/toRoom/' + temp.kaibos[i].roomnum + '" title="点击进入直播间">';
                        $.ajax({
                            type: "POST",
                            url: "/index/getnick",
                            data: {
                                uid: temp.kaibos[i].uid
                            },
                            async:false,
                            dataType: "json",
                            success: function(data){
                                temp2 = eval(data);
                                if(temp2.status == "success"){
                                    nickname = temp2.nickname;
                                }
                            },
                            error: function(data){
                                alert("系统错误");
                            }
                        });

                        result1 += '<span class="time">' + nickname + '</span>';
                        result1 += '<span class="details"><span class="label label-sm label-icon label-success"><i class="fa fa-bullhorn"></i></span>';
                        result1 += temp.kaibos[i].title + '</span>';
                        result1 += '</a></li>';
                    }
                    $("#kaibos").html(result1);

                }else if(temp.status == "nologin"){
                    alert("请先登录");
                }
            },
            error: function(data){
                alert("系统错误");
            }
        });

        $(".logout").click(function () {
            $.ajax({
                type: "POST",
                url: "/login/logout",
                dataType: "json",
                success: function (data) {
                    temp = eval(data);
                    if (temp.status == "success") {
                        alert("已登出");
                        history.go(0);
                    }
                },
                error: function (data) {
                    alert("系统错误");
                }
            })
        });
    });
</script>