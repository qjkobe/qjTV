package com.shu.action.index;

import com.shu.db.model.live.TLiveRoom;
import com.shu.db.model.user.TUser;
import com.shu.db.model.user.TUserInfo;
import com.shu.services.live.TLiveRoomService;
import com.shu.services.user.TUserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
            model.addAttribute("liveroom", "none");
            return "index/live";
        }
        model.addAttribute("liveroom", list1);
        return "index/live";
    }

    /**
     * 进入别人的直播间。每个人都有自己的房间号
     */
    @RequestMapping(value = "toRoom", produces = "text/html;charset=UTF-8")
    public String toRoom(Model model, String id, HttpServletRequest request){

        //根据房间id获得房间信息
        TLiveRoom room = tLiveRoomService.getLRoomById(id);
        model.addAttribute("liveroom", room);

        //判断用户有没有登录，作为判断用户权限的重要依据
        TUser user = (TUser) request.getSession().getAttribute("user");
        if(user != null){
            TUserInfo queryInfo = new TUserInfo();
            queryInfo.setUid(user.getId());
            TUserInfo userInfo = tUserInfoService.getUserinfoListByParam(queryInfo, null, null).get(0);
            model.addAttribute("islogin", "y");
            model.addAttribute("userinfo", userInfo);
        }else{
            model.addAttribute("islogin", "n");
        }
        int roomNum = 0;
        return "index/" + roomNum;
    }
}
