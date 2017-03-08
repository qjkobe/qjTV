package com.shu.action.index;

import com.alibaba.fastjson.JSONObject;
import com.shu.db.model.follow.TFollow;
import com.shu.db.model.live.TLiveRoom;
import com.shu.db.model.user.TUser;
import com.shu.db.model.user.TUserInfo;
import com.shu.services.follow.TFollowService;
import com.shu.services.live.TLiveRoomService;
import com.shu.services.user.TUserInfoService;
import com.shu.utils.Const;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 因为未注册用户，也是可以看直播的，所以这个controller用来显示所有内容，并且可以在没有用户session的情况下显示
 * Created by Administrator on 2017/2/28.
 */
@Controller
@RequestMapping(value = "index")
public class IndexAction {

    @Autowired
    TLiveRoomService tLiveRoomService;

    @Autowired
    TUserInfoService tUserInfoService;

    @Autowired
    TFollowService tFollowService;

    /**
     * 首页显示一个推荐直播。
     */
    @RequestMapping(value = "index/{jinyu}", produces = "text/html;charset=UTF-8")
    public String index(Model model, @PathVariable String jinyu){


        model.addAttribute("test", jinyu);
        //去找已经开启的直播
        TLiveRoom queryRoom = new TLiveRoom();
        queryRoom.setIslive(1);
        //TODO: 之后可以用Order类进行人气排序，后期进行智能推荐。现在先只是随便找一个开播的放在首页
        List<TLiveRoom> list1 = tLiveRoomService.getLRoomListByParam(queryRoom, null, null);
        if(list1.size() == 0){
            //不要让这种没有任何直播开启的情况出现。
            model.addAttribute("liveroom", "none");
            return "index/index";
        }
        model.addAttribute("liveroom", list1.get(0));
        return "index/index";
    }

    @RequestMapping(value = "index", produces = "text/html;charset=UTF-8")
    public String index(Model model){

        //去找已经开启的直播
        TLiveRoom queryRoom = new TLiveRoom();
        queryRoom.setIslive(1);
        //TODO: 之后可以用Order类进行人气排序，后期进行智能推荐。现在先只是随便找一个开播的放在首页
        List<TLiveRoom> list1 = tLiveRoomService.getLRoomListByParam(queryRoom, null, null);
        if(list1.size() == 0){
            //不要让这种没有任何直播开启的情况出现。
            model.addAttribute("liveroom", "none");
            return "index/index";
        }
        model.addAttribute("liveroom", list1.get(0));
        return "index/index";
    }


    /**
     * 直播页显示所有开播的直播。
     */
    @RequestMapping(value = "live", produces = "text/html;charset=UTF-8")
    public String live(Model model){

        //去找已经开启的直播
        TLiveRoom queryRoom = new TLiveRoom();
        queryRoom.setIslive(1);
        //TODO: 之后可以用Order类进行人气排序，后期进行智能推荐。现在先只是随便找一个开播的放在首页
        List<TLiveRoom> list1 = tLiveRoomService.getLRoomListByParam(queryRoom, null, null);
        if(list1.size() == 0){
            //不要让这种没有任何直播开启的情况出现。
            model.addAttribute("liverooms", "none");
            return "index/live";
        }
        model.addAttribute("liverooms", list1);
        return "index/live";
    }

    /**
     * 显示我的关注。
     */
    @RequestMapping(value = "myFollow", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String myFollow(Model model, HttpServletRequest request){

        TUser user = (TUser) request.getSession().getAttribute("user");
        JSONObject resObj = new JSONObject();
        if(user == null){
            resObj.put("status", Const.STATUS_NOT_LOGIN);
            return resObj.toString();
        }

        TFollow queryFollow = new TFollow();
        queryFollow.setFanid(user.getId());
        queryFollow.setIsdelete(0);
        List<TFollow> list2 = tFollowService.getFollowListByParam(queryFollow, null, null);
        if(list2.size() == 0){
            resObj.put("followList", 0);
        }else{
            resObj.put("followList", list2);
        }

        //遍历list查出所有人的直播间
        TLiveRoom queryRoom = new TLiveRoom();
        for(int i = 0; i < list2.size(); i++){
            queryRoom.setUid(list2.get(i).getFollowid());
            //未开播
            queryRoom.setIslive(1);
            List<TLiveRoom> list3 = tLiveRoomService.getLRoomListByParam(queryRoom, null, null);
            if(list3.size() != 0){
                resObj.put("kaibos", list3);
            }else{
                resObj.put("kaibos", 0);
            }
            //已开播
            queryRoom.setIslive(0);
            List<TLiveRoom> list4 = tLiveRoomService.getLRoomListByParam(queryRoom, null, null);
            if(list4.size() != 0){
                resObj.put("weikaibos", list4);
            }else{
                resObj.put("weikaibos", 0);
            }
        }

        resObj.put("status", Const.STATUS_SUCCESS);
        return resObj.toString();
    }

    /**
     * 进入别人的直播间。每个人都有自己的房间号
     */
    @RequestMapping(value = "toRoom/{roomNum}", produces = "text/html;charset=UTF-8")
    public String toRoom(Model model, String id, HttpServletRequest request, @PathVariable String roomNum){

        //根据房间号获得房间信息
        TLiveRoom queryRoom = new TLiveRoom();
        queryRoom.setRoomnum(roomNum);
        List<TLiveRoom> list1 = tLiveRoomService.getLRoomListByParam(queryRoom, null, null);
        //如果list为空说明房间号错误，去房间不存在页面
        if(list1.size() == 0){
            return "error/noRoom";
        }
        TLiveRoom room = list1.get(0);

        model.addAttribute("liveroom", room);

        //把主播的信息也加入model
        TUserInfo queryUser = new TUserInfo();
        queryUser.setUid(room.getUid());
        List<TUserInfo> list2 = tUserInfoService.getUserinfoListByParam(queryUser, null, null);
        if(list2.size() == 0){
            //这里主播不存在是不科学的
            return "error/error";
        }
        TUserInfo zhubo = list2.get(0);
        model.addAttribute("zhubo", zhubo);

        //判断用户有没有登录，作为判断用户权限的重要依据
        TUser user = (TUser) request.getSession().getAttribute("user");
        if(user != null){
            TUserInfo queryInfo = new TUserInfo();
            queryInfo.setUid(user.getId());
            TUserInfo userInfo = tUserInfoService.getUserinfoListByParam(queryInfo, null, null).get(0);

            //如果是直播主，直接去指定页面：
            if(user.getId().equals(room.getUid())){
                return "redirect:/user/myZhibo";
            }

            //判断是否关注
            TFollow tFollow = new TFollow();
            tFollow.setFanid(user.getId());
            tFollow.setFollowid(room.getUid());
            List<TFollow> list3 = tFollowService.getFollowListByParam(tFollow, null, null);
            if(list3.size() == 0 || list3.get(0).getIsdelete() == 1){
                //未关注
                model.addAttribute("isFollowed", "n");
            }else{
                model.addAttribute("isFollowed", "y");
                model.addAttribute("followId", list3.get(0).getId());
            }

            model.addAttribute("islogin", "y");
            model.addAttribute("userinfo", userInfo);
        }else{
            model.addAttribute("islogin", "n");
        }
        return "index/room";
    }
}
