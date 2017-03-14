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
    var TOPIC_BULLET = 'bullet';

    $(function(){
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

                // 连接云巴服务器
                yunba.connect_by_customid(cid,
                        function(success, msg, sessionid) {
                            if (success) {
                                console.log('sessionid：' + sessionid);

                                // 设置收到信息回调函数
                                yunba.set_message_cb(yunba_msg_cb);

                                // 订阅弹幕 TOPIC
                                yunba.subscribe({
                                            'topic': TOPIC_BULLET
                                        },
                                        function(success, msg) {
                                            if (success) {
                                                console.log('subscribed');
                                            } else {
                                                console.log(msg);
                                            }
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
            var bullet = {
                "mode": 2,
                "text": "test",
                "color": "ff0000",
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
    });


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
        } else if (data.topic === TOPIC_LIKE) {
            // 点赞
            var num = parseInt($('#like-number').text()) + 1;
            $('#like-number').text(num);
            show_like_animate();
        } else if (data.topic === TOPIC_STAT) {
            // 在线信息
            var msg = JSON.parse(data.msg);
            var num = msg.presence;
            $('#online-number').text(num);
        } else if (data.topic === alias) {
            // 初始在线和点赞信息
            var msg = JSON.parse(data.msg);
            var num = parseInt($('#online-number').text()) + msg.presence;
            $('#online-number').text(num);

            num = msg.like;
            $('#like-number').text(num);
        }
    }

</script>
<body>
<h1>主播：${zhubo.nickname}的直播间</h1>
<h2>直播标题：${liveroom.title}</h2>
<c:if test="${isFollowed == 'n'}">
    <button id="follow">关注</button>
</c:if>

<c:if test="${isFollowed == 'y'}">
    <button id="unfollow">取消关注</button>
</c:if>
<div>
    <button id="pushTxt">发送弹幕</button>
    <br>
</div>
<div class="container-fluid">

    <div class="row">
        <%--<div class="col-lg-2 col-md-1 col-xs-0 my-col"></div>--%>
        <div class="col-lg-6 col-md-6 col-xs-12 my-col">
            <div id='my-player' class='abp'>
                <div id='my-comment-stage' class='container'>
                    <video id="live-video" class="video-js vjs-default-skin vjs-big-play-centered" webkit-playsinline style="display: none">
                        <source src="rtmp://115.159.62.204:1935/${liveroom.app}/${liveroom.stream}" type="rtmp/flv">
                        <source src="http://live.lettuceroot.com/yunba/live-demo.m3u8" type="application/x-mpegURL">
                    </video>
                </div>
            </div>
        </div>
        <%--<div class="col-lg-2 col-md-1 col-xs-0 my-col"></div>--%>
    </div>
</div>


<p>
    <%--Sample RTMP URL (Live) is "rtmp://115.159.62.204:1935/qunima/123"--%>
</p>
</body>
</html>
