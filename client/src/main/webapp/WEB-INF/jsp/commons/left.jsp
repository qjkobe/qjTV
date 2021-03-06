<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- BEGIN SIDEBAR -->
<%
%>
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
        <ul class="page-sidebar-menu page-sidebar-menu-light" data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">
            <!-- DOC: To remove the sidebar toggler from the sidebar you just need to completely remove the below "sidebar-toggler-wrapper" LI element -->
            <li class="sidebar-toggler-wrapper">
                <!-- BEGIN SIDEBAR TOGGLER BUTTON -->
                <div class="sidebar-toggler">
                </div>
                <!-- END SIDEBAR TOGGLER BUTTON -->
            </li>
            <!-- DOC: To remove the search box from the sidebar you just need to completely remove the below "sidebar-search-wrapper" LI element -->
            <li class="sidebar-search-wrapper">
                <!-- BEGIN RESPONSIVE QUICK SEARCH FORM -->
                <!-- DOC: Apply "sidebar-search-bordered" class the below search form to have bordered search box -->
                <!-- DOC: Apply "sidebar-search-bordered sidebar-search-solid" class the below search form to have bordered & solid search box -->
                <form class="sidebar-search " action="#" method="POST">
                    <a href="javascript:;" class="remove">
                        <i class="icon-close"></i>
                    </a>
                    <div class="input-group">
                        <input type="text" class="form-control" id="str" placeholder="搜索...">
							<span id="sousuo" class="input-group-btn">
							<a href="javascript:;" class="btn"><i class="icon-magnifier"></i></a>
							</span>
                    </div>
                </form>
                <!-- END RESPONSIVE QUICK SEARCH FORM -->
            </li>
            <li id="mainmenu" class="start active">
                <a href="/index/live">
                    <i class="icon-home"></i>
                    <span class="title">所有直播</span>
                    <span class="selected"></span>
                    <%--<span class="arrow open"></span>--%>
                </a>
                <%--<ul class="sub-menu">--%>
                    <%--<li  class="active">--%>
                        <%--<a href="">--%>
                            <%--<i class="icon-bar-chart"></i>--%>
                            <%--Default Dashboard</a>--%>
                    <%--</li>--%>
                <%--</ul>--%>
            </li>
            <li id="feileimenu">
                <a href="javascript:;">
                    <i class="icon-basket"></i>
                    <span class="title">直播分类</span>
                    <span class="arrow "></span>
                </a>
                <ul class="sub-menu" id="type">
                    <li>
                        <a href="/index/live">
                            <i class="icon-home"></i>
                            游戏</a>
                    </li>
                    <li>
                        <a href="/index/live">
                            <i class="icon-home"></i>
                            卖萌</a>
                    </li>
                    <li>
                        <a href="/index/live">
                            <i class="icon-home"></i>
                            裸聊</a>
                    </li>

                </ul>
            </li>
        </ul>
        <!-- END SIDEBAR MENU -->
    </div>
</div>
<!-- END SIDEBAR -->

<script>
    $(function(){
        $.ajax({
            type: "POST",
            url: "/type/getMenu",
            data: {
            },
            dataType: "json",
            success: function(data){
                temp = eval(data);
                if(temp.status == "success"){
                    typelist = temp.menu;
                    var result = "";
                    for(i = 0; i < typelist.length; i++){
                        if(typelist[i].name == "${roomtype}"){
                            result += '<li class="active">';
                            $("#mainmenu").removeClass("active");
                            $("#feileimenu").addClass("active");
                        }else{
                            result += '<li>';
                        }
                        result += '<a href="/index/fenlei?typeid=' + typelist[i].id + '">';
                        result += '<i class="icon-home"></i>';
                        result += typelist[i].name + '</a>';
                        result += '</li>';
                    }
                    $("#type").html(result);
                }
            },
            error: function(data){
                alert("系统错误");
            }
        });
        $("#sousuo").click(function(){
            if($("#str").val() == ""){
                alert("搜索信息不能为空");
            }else{
                window.location.href = "/index/search?str=" + $("#str").val();
            }
        })
    })
</script>