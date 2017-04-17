<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- BEGIN SIDEBAR -->
<div class="page-sidebar-wrapper">
    <!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
    <!-- DOC: Change data-auto-speed="200" to adjust the sub menu slide up/down speed -->
    <div class="page-sidebar navbar-collapse collapse">
        <!-- BEGIN SIDEBAR MENU -->
        <!-- DOC: Apply "page-sidebar-menu-light" class right after "page-sidebar-menu" to enable light sidebar menu style(without borders) -->
        <!-- DOC: Apply "page-sidebar-menu-hover-submenu" class right after "page-sidebar-menu" to enable hoverable(hover vs accordion) sub menu mode -->
        <!-- DOC: Apply "page-sidebar-menu-closed" class right after "page-sidebar-menu" to collapse("page-sidebar-closed" class must be applied to the body element) the sidebar sub menu mode -->
        <!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
        <!-- DOC: Set data-keep-expand="true" to keep the submenues expanded -->
        <!-- DOC: Set data-auto-speed="200" to adjust the sub menu slide up/down speed -->
        <ul class="page-sidebar-menu page-sidebar-menu-hover-submenu " data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">
            <li class='start <%="userinfo".equals(menuActive) ? "active" : ""%>'>
                <a href="javascript:;">
                    <i class="icon-home"></i>
                    <span class="title">信息管理</span>
                    <span class="arrow "></span>
                </a>
                <ul class="sub-menu">
                    <li class='<%="baseinfo".equals(subMenuActive) ? "active" : ""%>'>
                        <a href="/user/userinfo">
                            <i class="icon-home"></i>
                            基本信息</a>
                    </li>
                    <li class='<%="headinfo".equals(subMenuActive) ? "active" : ""%>'>
                        <a href="/user/userhead">
                            <i class="icon-basket"></i>
                            头像</a>
                    </li>

                </ul>
            </li>
            <li class='<%="chengjiu".equals(menuActive) ? "active" : ""%>'>
                <a href="/manage/getChengjiu">
                    <i class="icon-basket"></i>
                    <span class="title">成就管理</span>
                    <span class="selected"></span>
                </a>
            </li>
            <li class='<%="guanzhu".equals(menuActive) ? "active" : ""%>'>
                <a href="/manage/getFollow">
                    <i class="icon-basket"></i>
                    <span class="title">关注管理</span>
                    <span class="selected"></span>
                </a>
            </li>
            <li class='<%="account".equals(menuActive) ? "active" : ""%>'>
                <a href="/manage/getAccount">
                    <i class="icon-basket"></i>
                    <span class="title">充值管理</span>
                    <span class="selected"></span>
                </a>
            </li>
            <li class='<%="gift".equals(menuActive) ? "active" : ""%>'>
                <a href="/manage/getGift">
                    <i class="icon-basket"></i>
                    <span class="title">收礼管理</span>
                    <span class="selected"></span>
                </a>
            </li>
            <li class='<%="fangjian".equals(menuActive) ? "active" : ""%>'>
                <a href="/manage/fangjian">
                    <i class="icon-basket"></i>
                    <span class="title">房间管理</span>
                    <span class="selected"></span>
                </a>
            </li>

        </ul>
        <!-- END SIDEBAR MENU -->
    </div>
</div>
<!-- END SIDEBAR -->