package com.shu.action.index;

import com.shu.db.model.live.TLiveRoom;
import com.shu.services.live.TLiveRoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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

    /**
     * 首页显示一个推荐直播。
     */
    @RequestMapping(value = "index", produces = "text/html;charset=UTF-8")
    public String index(Model model){

        //去找已经开启的直播
        TLiveRoom queryRoom = new TLiveRoom();
        queryRoom.setIslive(1);
        //TODO: 之后可以用Order类进行人气排序，后期进行智能推荐。现在先只是随便找一个开播的放在首页
        List<TLiveRoom> list1 = tLiveRoomService.getLRoomListByParam(queryRoom, null, null);
        model.addAttribute("room", list1.get(0));
        return "login/login";
    }
}
