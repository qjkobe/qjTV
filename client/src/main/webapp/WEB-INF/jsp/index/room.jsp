<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/3/6
  Time: 16:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../commons/jsptag.jsp"%>
<html>
<head>
    <title>Title</title>
    <%@include file="../commons/headjs.jsp"%>
    <link rel="stylesheet" href="${ctx}/theme/css/style.min.css" />
    <link rel="stylesheet" href="${ctx}/theme/js/video-js/video-js.min.css">

    <style type="text/css">
        .container-fluid {
            padding: 0px;
        }

        .container {
            padding: 0px;
        }

        .my-col {
            padding: 0px;
        }

        .row {
            margin: 0px;
        }

    </style>

    <script src="${ctx}/theme/js/video-js/ie8/videojs-ie8.min.js"></script>
    <script src="${ctx}/theme/js/video-js/video.min.js"></script>
    <script src="${ctx}/theme/js/video-js/videojs-contrib-hls.min.js"></script>
    <script type="text/javascript" src="${ctx}/theme/js/socket.io.js"></script>
    <script src="https://rawgit.com/yunba/yunba-javascript-sdk/master/yunba-js-sdk.js"></script>
    <script src="${ctx}/theme/js/CommentCoreLibrary.min.js"></script>
</head>
<script>
    var APPKEY = '58c605609bdcd1b36dfb9ff1';
    var TOPIC_BULLET = '${liveroom.roomnum}bullet';
    var TOPIC_LIKE = 'like';
    var TOPIC_STAT = '${liveroom.roomnum}stat';
    var TEXTS = ['♪', '♩', '♭', '♬'];

    $(function(){
        //获得礼物榜
        $.ajax({
            type: "POST",
            url: "/gift/getGift",
            data: {
                zhuboid: "${liveroom.uid}"
            },
            dataType: "json",
            success: function(data){
                temp = eval(data);
                if(temp.status == "fail"){
                    alert("不存在的");
                }else if(temp.status == "success"){
                    giftList = temp.giftList;
                    for(i = 0; i < 3; i++){
                        var sendid = giftList[i].sendid;
                        $.ajax({
                            type: "POST",
                            url: "/index/getnick",
                            data: {
                                uid: sendid
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
                        giftlistStr = "<div><b>" + nickname + "贡献值：" + giftList[i].total + "</b></div>";
                        $("#gift-list").append(giftlistStr);
                    }
                }
            },
            error: function(data){
                alert("系统错误");
            }
        });

        //获得关注数
        $.ajax({
            type: "POST",
            url: "/fan/getFollowNum",
            data: {
                zhuboid: "${liveroom.uid}"
            },
            async: false,
            dataType: "json",
            success: function(data){
                temp2 = eval(data);
                if(temp2.status == "success"){
                    $("#followNum").html(temp2.followNum);
                }
            },
            error: function(data){
                alert("系统错误");
            }
        });

        //弹幕
        init();
        videojs("live-video", {
            "techOrder": ["flash", "html5"],
            "controls": "false",
            "autoplay": "true",
            "preload": "auto"
        }, function() {
            var player = this;
            player.play();
        });

        window.yunba = new Yunba({
            server: 'sock.yunba.io',
            port: 3000,
            appkey: APPKEY // 这里是您在 “第二步” 中获取到的 AppKey。
        });

        yunba.init(function(success) {
            if (success) {
                var cid = Math.random().toString().substr(2);
                window.alias = cid;

                // 连接云巴服务器
                yunba.connect_by_customid(cid,
                        function(success, msg, sessionid) {
                            if (success) {
                                console.log('sessionid：' + sessionid);

                                // 设置收到信息回调函数
                                yunba.set_message_cb(yunba_msg_cb);

                                // 设置别名
                                yunba.set_alias({
                                    'alias': alias
                                }, function(data) {

                                    // 订阅弹幕 TOPIC
                                    yunba.subscribe({
                                                'topic': TOPIC_BULLET
                                            },
                                            function(success, msg) {
                                                if (success) {
                                                    console.log('subscribed');

                                                    // 订阅点赞 TOPIC
                                                    yunba.subscribe({
                                                                'topic': TOPIC_LIKE
                                                            },
                                                            function(success, msg) {
                                                                if (success) {
                                                                    console.log('subscribed');

                                                                    // 订阅统计信息 TOPIC
                                                                    yunba.subscribe({
                                                                                'topic': TOPIC_STAT
                                                                            },
                                                                            function(success, msg) {
                                                                                if (success) {
                                                                                    console.log('subscribed');
                                                                                    yunba_sub_ok();
                                                                                    // msg_notify('success', '连接服务器成功~');

                                                                                    yunba.subscribe_presence({'topic': TOPIC_STAT}, function (success, msg) {
                                                                                        if (!success) {
                                                                                            console.log('subscribed');
                                                                                        }
                                                                                    });
                                                                                } else {
                                                                                    console.log(msg);
                                                                                    // msg_notify('error', msg);
                                                                                }
                                                                            }
                                                                    );
                                                                } else {
                                                                    console.log(msg);
                                                                    // msg_notify('error', msg);
                                                                }
                                                            }
                                                    );
                                                } else {
                                                    console.log(msg);
                                                    // msg_notify('error', msg);
                                                }
                                            }
                                    );
                                });
                            } else {
                                console.log(msg);
                            }
                        });
            } else {
                console.log('yunba init failed');
            }
        });


        $("#pushTxt").click(function(){
            var mode = 1;
            switch ($('#bullet-type').prop('selectedIndex')) {
                case 0:
                    mode = 2;
                    break;

                case 1:
                    mode = 1;
                    break;

                case 2:
                    mode = 4;
                    break;

                case 3:
                    mode = 5;
                    break;

                case 4:
                    mode = 6;
                    break;
            }
            var text = $("#danmuTxt").val();
            if(text == ""){
                alert("请输入弹幕");
                return;
            }

            $.ajax({
                type: "POST",
                url: "/index/pushTxt",
                data: {
                    rid: "${liveroom.id}"
                },
                async: false,
                dataType: "json",
                success: function(data){
                    temp = eval(data);
                    if(temp.userinfo == "nologin"){
                        alert("发弹幕前请先登录");
                    }else if(temp.userinfo == "banned"){
                        alert("你被禁言了");
                    }else{
                        var bullet = {
                            "userinfo": temp.userinfo,
                            "mode": mode,
                            "text": text,
                            "color": "ffffff",
                            "dur": 4000
                        };

                        yunba.publish({
                                    topic: TOPIC_BULLET,
                                    msg: JSON.stringify(bullet)
                                },
                                function(success, msg) {
                                    if (!success) {
                                        console.log(msg);
                                    }
                                }
                        );
                    }
                },
                error: function(data){
                    alert("系统错误");
                }
            });

        });

        $("#follow").click(function(){
            if("${islogin}" == "n"){
                alert("请先登录！");
            }else{
                $.ajax({
                    type: "POST",
                    url: "/fan/follow",
                    data: {
                        followid: "${liveroom.uid}",
                        fanid: "${userinfo.uid}"
                    },
                    dataType: "json",
                    success: function(data){
                        temp = eval(data);
                        if(temp.status == "success"){
                            alert("关注成功");
                            history.go(0);
                        }else if(temp.status == "error"){
                            alert("自己不能关注自己");
                        }
                    },
                    error: function(data){
                        alert("系统错误");
                    }
                });
            }
        });
        $("#unfollow").click(function(){
            if("${islogin}" == "n"){
                alert("请先登录！");
            }else{
                $.ajax({
                    type: "POST",
                    url: "/fan/unfollow",
                    data: {
                        id: "${followId}",
                        followid: "${liveroom.uid}",
                        fanid: "${userinfo.uid}"
                    },
                    dataType: "json",
                    success: function(data){
                        temp = eval(data);
                        if(temp.status == "success"){
                            alert("取关成功");
                            history.go(0);
                        }
                    },
                    error: function(data){
                        alert("系统错误");
                    }
                });
            }
        });

        //禁言与房管.管理员能禁言，本人能任命房管
        $(".jinyan").click(function(){
            if("${islogin}" == "n"){
                alert("请先登录！");
            }else{
                $.ajax({
                    type: "POST",
                    url: "/room/banUser",
                    data: {
                        uid: $(this).data("uid"),
                        rid: "${liveroom.id}"
                    },
                    dataType: "json",
                    success: function(data){
                        temp = eval(data);
                        if(temp.status == "success"){
                            alert("禁言成功");
                        }else if(temp.status == "noaccess"){
                            alert("你没有权限这么做");
                        }
                    },
                    error: function(data){
                        alert("系统错误");
                    }
                });
            }
        });
        $(".fangguan").click(function(){
            if("${islogin}" == "n"){
                alert("请先登录！");
            }else{
                $.ajax({
                    type: "POST",
                    url: "/room/fangguan",
                    data: {
                        uid: $(this).data("uid"),
                        rid: "${liveroom.id}"
                    },
                    dataType: "json",
                    success: function(data){
                        temp = eval(data);
                        if(temp.status == "success"){
                            alert("任命管理员成功");
                        }else if(temp.status == "noaccess"){
                            alert("你没有权限这么做");
                        }
                    },
                    error: function(data){
                        alert("系统错误");
                    }
                });
            }
        });

        $(".gift").click(function(){
            giftvalue = $(this).data("value");
            giftcount = $(this).data("count");
            giftname = $(this).html();
            $.ajax({
                type: "POST",
                url: "/gift/sendGift",
                data: {
                    zhuboid: "${liveroom.uid}",
                    giftNum: giftcount,
                    giftValue: giftvalue
                },
                async:false,
                dataType: "json",
                success: function(data){
                    temp = eval(data);
                    if(temp.status == "nologin"){
                        alert("请先登录");
                    }else if(temp.status == "success"){
                        alert("送礼成功");
                        giftinfo = temp.giftInfo;

                        var gift = {
                            "giftinfo": giftinfo,
                            "giftname": giftname,
                        };

                        yunba.publish({
                                    topic: TOPIC_LIKE,
                                    msg: JSON.stringify(gift)
                                },
                                function(success, msg) {
                                    if (!success) {
                                        console.log(msg);
                                    }
                                }
                        );
                    }else if(temp.status == "fail"){
                        alert("不能给自己送礼");
                    }else if(temp.status == "noaccount"){
                        alert("您还未充值过");
                    }else if(temp.status == "nomoney"){
                        alert("余额不足");
                    }
                },
                error: function(data){
                    alert("系统错误");
                }
            });
        })
    });

    function jinyan(obj){
        if("${islogin}" == "n"){
            alert("请先登录！");
        }else{
            $.ajax({
                type: "POST",
                url: "/room/banUser",
                data: {
                    uid: $(obj).data("uid"),
                    rid: "${liveroom.id}"
                },
                dataType: "json",
                success: function(data){
                    temp = eval(data);
                    if(temp.status == "success"){
                        alert("禁言成功");
                    }else if(temp.status == "noaccess"){
                        alert("你没有权限这么做");
                    }
                },
                error: function(data){
                    alert("系统错误");
                }
            });
        }
    }
    function fangguan(obj){
        if("${islogin}" == "n"){
            alert("请先登录！");
        }else{
            $.ajax({
                type: "POST",
                url: "/room/fangguan",
                data: {
                    uid: $(obj).data("uid"),
                    rid: "${liveroom.id}"
                },
                dataType: "json",
                success: function(data){
                    temp = eval(data);
                    if(temp.status == "success"){
                        alert("任命管理员成功");
                    }else if(temp.status == "noaccess"){
                        alert("你没有权限这么做");
                    }
                },
                error: function(data){
                    alert("系统错误");
                }
            });
        }
    }

    function init() {
        var player = $('#my-player');
        var bullet = $('#my-comment-stage');
        player.css("width", "100%");
        player.height(player.width() * 9 / 16.0);

        bullet.css("width", "100%");

        var video = $('#live-video');
        video.width(player.width());
        video.height(player.height());
        video.css("display", "block");

        // videojs 生成的 video 标签，若不调整横竖屏切换时视频会不满或溢出
        video = $('#live-video_html5_api');
        video.width(player.width());
        video.height(player.height());
        video.css("display", "block");

        var cm = new CommentManager(document.getElementById('my-comment-stage'));
        cm.init();
        cm.start();

        window.cm = cm;
        window.cm_width = bullet.width();
        window.cm_height = bullet.height();
    }

    function yunba_msg_cb(data) {
        // console.log(data);
        if (data.topic === TOPIC_BULLET) {
            // 弹幕
            cm.send(JSON.parse(data.msg));
            var msg = JSON.parse(data.msg);
            chatinfo = '<div><div class="btn-group btn-group-circle"><button type="button" class="btn btn-circle-right btn-primary dropdown-toggle" data-uid="' + msg.userinfo.uid + '" data-toggle="dropdown">' + msg.userinfo.nickname + '<i class="fa fa-angle-down"></i></button>'
            chatinfo = chatinfo + '<ul class="dropdown-menu" role="menu"><li><a class="jinyan" href="javascript:;" onclick="jinyan(this)" data-uid="' + msg.userinfo.uid + '">禁言 </a></li>';
            chatinfo = chatinfo + '<li><a class="fangguan" href="javascript:;" onclick="fangguan(this)" data-uid="' + msg.userinfo.uid + '">任命房管 </a></li></ul></div>'
            chatinfo = chatinfo + "<b> : " + msg.text + "</b></div>";

            $("#chat-list").append(chatinfo);
            $("#chat-list").scrollTop(200);
        } else if (data.topic === TOPIC_LIKE) {
            // 点赞
//            var num = parseInt($('#like-number').text()) + 1;
//            $('#like-number').text(num);
//            show_like_animate();
            var msg = JSON.parse(data.msg);
            chatinfo = "<div><b>" + msg.giftinfo.sendid + "送给主播" + msg.giftname + "</b></div>";
            $("#chat-list").append(chatinfo);
            $("#chat-list").scrollTop(100);
        } else if (data.topic === TOPIC_STAT) {
            // 在线信息
            var msg = JSON.parse(data.msg);
            var num = msg.presence;
            $('#online-number').text(num);
        } else if (data.topic === alias) {
            alert("alias");
            // 初始在线和点赞信息
            var msg = JSON.parse(data.msg);
            var num = parseInt($('#online-number').text()) + msg.presence;
            $('#online-number').text(num);

            num = msg.like;
            $('#like-number').text(num);
        } else if (data.topic === TOPIC_STAT + '/p') {
            var msg = JSON.parse(data.msg);
            if(msg.action == 'offline'){
                var stat = {
                    "presence": parseInt($('#online-number').text()) - 1
                }
                //存入redis
                $.ajax({
                    type: "POST",
                    url: "/live/modifyOnlineNum",
                    data: {
                        roomnum: "${liveroom.roomnum}",
                        onlinenum: parseInt($('#online-number').text()) - 1
                    },
                    dataType: "json",
                    success: function(data){
                        temp = eval(data);
                        if(temp.status == "success"){
                            //alert("");
                        }
                    },
                    error: function(data){
                        alert("系统错误");
                    }
                });

            }else if(msg.action == 'join'){
                var stat = {
                    "presence": parseInt($('#online-number').text()) + 1
                }
                //存入redis
                $.ajax({
                    type: "POST",
                    url: "/live/modifyOnlineNum",
                    data: {
                        roomnum: "${liveroom.roomnum}",
                        onlinenum: parseInt($('#online-number').text()) + 1
                    },
                    dataType: "json",
                    success: function(data){
                        temp = eval(data);
                        if(temp.status == "success"){
                            //alert("");
                        }
                    },
                    error: function(data){
                        alert("系统错误");
                    }
                });
            }
            yunba.publish({
                        topic: TOPIC_STAT,
                        msg: JSON.stringify(stat)
                    },
                    function(success, msg) {
                        if (!success) {
                            console.log(msg);
                        }
                    }
            );
        }
    }
    function yunba_sub_ok() {
//        $('#span-status').text('连接云巴服务器成功～');
//        setTimeout(function() {
//            $('#form-status').css("display", "none");
//            $('#form-info').css("display", "block");
//            $('#btn-send').attr("disabled", false);
//        }, 1000);
    }

    function show_like_animate() {
        var x = cm_width * 9 / 10;
        var y = cm_height * 7 / 8;

        var text = TEXTS[Math.floor(Math.random() * TEXTS.length)];
        var color = 0xf0f0f0 + Math.floor(Math.random() * 0x0f0f0f);

        var bullet = {
            "stime": 0,
            "size": 32,
            "color": color,
            "mode": 7,
            "pool": 1,
            "position": "absolute",
            "dbid": 104079685,
            "hash": "9bd49c01",
            "border": false,
            "shadow": false,
            "x": x,
            "y": y,
            "text": text,
            "rZ": 0,
            "rY": 0,
            "motion": [{
                "x": {
                    "from": x,
                    "to": x,
                    "dur": 1500,
                    "delay": 0
                },
                "y": {
                    "from": y,
                    "to": y - cm_height / 2,
                    "dur": 1500,
                    "delay": 0
                }
            }],
            "movable": true,
            "font": "宋体",
            "dur": 1500,
            "opacity": 1,
            "alpha": {
                "from": 1,
                "to": 0
            }
        };

        cm.send(bullet);
    }

</script>
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
                        <a href="#">所有分类</a>
                        <i class="fa fa-angle-right"></i>
                    </li>
                    <li>
                        <a href="#">守望先锋</a>
                    </li>
                </ul>
            </div>
            <!-- END PAGE HEADER-->
            <div class="row">
                <div class="col-md-7">
                    <h1 style="display : inline">主播：${zhubo.nickname}的直播间</h1>
                </div>
                <div class="">
                    关注数：<strong id="followNum">0</strong>
                    <c:if test="${isFollowed == 'n'}">
                        <button class="btn btn-primary" id="follow">关注</button>
                    </c:if>

                    <c:if test="${isFollowed == 'y'}">
                        <button class="btn btn-primary" id="unfollow">取消关注</button>
                    </c:if>
                </div>
            </div>
            <div class="row">
                <div class="">
                    <h2 >直播标题：${liveroom.title}</h2>
                </div>
                <div>
                    <button type="button" class="btn btn-success disabled my-btn-block">
                        <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>
                        在线
                        <span id="online-number" class="badge">1</span>
                    </button>
                </div>
            </div>
            <div class="container-fluid">

                <div class="row">
                    <%--<div class="col-lg-2 col-md-1 col-xs-0 my-col"></div>--%>
                    <div class="col-lg-8 col-md-8 col-xs-12 my-col">
                        <div id='my-player' class='abp'>
                            <div id='my-comment-stage' class='container'>
                                <video id="live-video" class="video-js vjs-default-skin vjs-big-play-centered" webkit-playsinline style="display: none">
                                    <source src="rtmp://115.159.62.204:1935/${liveroom.app}/${liveroom.stream}" type="rtmp/flv">
                                    <source src="http://live.lettuceroot.com/yunba/live-demo.m3u8" type="application/x-mpegURL">
                                </video>
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="col-lg-2 col-md-2 col-xs-12 my-col" id='gift-list' style="height:200px;line-height:60px;text-align:center">
                            <span>贡献榜</span>
                        </div>
                        <div class="col-lg-4 col-md-4 col-xs-12 my-col" id="chat-list" style="height:350px;line-height:50px;overflow:auto;overflow-x:hidden;">

                        </div>
                    </div>
                        <div class="col-lg-4 col-md-4 col-xs-12 my-col">
                            <form class="form-inline">
                                <label style="display: none;" for="bullet-type">类型</label>
                                <select style="display: none;" id="bullet-type" class="form-control">
                                    <option>下端滚动</option>
                                    <option selected>上端滚动</option>
                                    <option>底部固定</option>
                                    <option>顶部固定</option>
                                    <option>逆向弹幕</option>
                                </select>
                                <input type="text" id="danmuTxt">
                                <button class="btn btn-primary" type="button" id="pushTxt">发送弹幕</button>
                            </form>
                            <br>
                        </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-1 col-md-offset-4">
                    <button class="btn btn-info gift" data-value="500" data-count="5000">火箭</button>
                </div>
                <div class="col-md-1">
                    <button class="btn btn-info gift" data-value="100" data-count="1000">飞机</button>
                </div>
                <div class="col-md-1">
                    <button class="btn btn-info gift" data-value="10" data-count="100">自行车</button>
                </div>
                <div class="col-md-1">
                    <button class="btn btn-info gift" data-value="1" data-count="10">遥控车</button>
                </div>
            </div>
<%--<button id="test">test</button>--%>

            <p>
                <%--Sample RTMP URL (Live) is "rtmp://115.159.62.204:1935/qunima/123"--%>
            </p>
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
        2017 &copy; QjTV by QJKOBE.
    </div>
    <div class="scroll-to-top">
        <i class="icon-arrow-up"></i>
    </div>
</div>
<!-- END FOOTER -->
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<%@include file="../commons/footjs.jsp"%>

<!-- END PAGE LEVEL SCRIPTS -->
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
</html>
