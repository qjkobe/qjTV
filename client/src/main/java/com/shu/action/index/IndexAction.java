package com.shu.action.index;

import com.alibaba.fastjson.JSONObject;
import com.shu.db.model.follow.TFollow;
import com.shu.db.model.live.TLiveRoom;
import com.shu.db.model.live.TRoomBan;
import com.shu.db.model.live.TRoomType;
import com.shu.db.model.user.TUser;
import com.shu.db.model.user.TUserInfo;
import com.shu.services.follow.TFollowService;
import com.shu.services.live.TLiveRoomService;
import com.shu.services.live.TRoomBanService;
import com.shu.services.live.TRoomTypeService;
import com.shu.services.user.TUserInfoService;
import com.shu.utils.Const;
import com.shu.utils.JedisPoolUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import redis.clients.jedis.Jedis;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.LinkedList;
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

    @Autowired
    TRoomBanService tRoomBanService;

    @Autowired
    TRoomTypeService tRoomTypeService;

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
     * 根据id获取昵称
     * @return
     */
    @RequestMapping(value = "getnick", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getnick(String uid){
        JSONObject resObj = new JSONObject();
        TUserInfo tUserInfo = new TUserInfo();
        tUserInfo.setUid(uid);
        List<TUserInfo> queryInfo = tUserInfoService.getUserinfoListByParam(tUserInfo, null, null);

        resObj.put("status", Const.STATUS_SUCCESS);
        resObj.put("nickname", queryInfo.get(0).getNickname());
        return resObj.toString();
    }

    /**
     * 根据id获取头像
     * @return
     */
    @RequestMapping(value = "gethead", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String gethead(String uid){
        JSONObject resObj = new JSONObject();
        TUserInfo tUserInfo = new TUserInfo();
        tUserInfo.setUid(uid);
        List<TUserInfo> queryInfo = tUserInfoService.getUserinfoListByParam(tUserInfo, null, null);

        resObj.put("status", Const.STATUS_SUCCESS);
        resObj.put("headimg", queryInfo.get(0).getHeadimg());
        return resObj.toString();
    }

    /**
     * 根据id获取直播间号
     * @return
     */
    @RequestMapping(value = "getRoomNum", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getRoomNum(String uid){
        JSONObject resObj = new JSONObject();
        TLiveRoom tLiveRoom = new TLiveRoom();
        tLiveRoom.setUid(uid);
        List<TLiveRoom> queryRoom = tLiveRoomService.getLRoomListByParam(tLiveRoom, null, null);

        resObj.put("status", Const.STATUS_SUCCESS);
        resObj.put("roomNum", queryRoom.get(0).getRoomnum());
        return resObj.toString();
    }

    /**
     * 发弹幕查看有没有登录，登录了返回用户信息，并查看有没有禁言
     * @return
     */
    @RequestMapping(value = "pushTxt", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String pushTxt(String rid, HttpServletRequest request){
        TUser user = (TUser) request.getSession().getAttribute("user");
        JSONObject resObj = new JSONObject();

        if(user == null){
            resObj.put("userinfo", Const.STATUS_NOT_LOGIN);
            return resObj.toString();
        }else{
            //查看是否禁言
            TRoomBan tRoomBan = new TRoomBan();
            tRoomBan.setUid(user.getId());
            tRoomBan.setRid(rid);
            tRoomBan.setIsdelete(0);
            List<TRoomBan> list2 = tRoomBanService.getRoomBanListByParam(tRoomBan, null, null);
            if(list2.size() != 0){
                resObj.put("userinfo", Const.STATUS_BE_BANNED);
                return resObj.toString();
            }

            TUserInfo userInfo = new TUserInfo();
            userInfo.setUid(user.getId());
            List<TUserInfo> list1 = tUserInfoService.getUserinfoListByParam(userInfo, null, null);
            resObj.put("userinfo", list1.get(0));
            return resObj.toString();
        }
    }

    /**
     * 根据主播id查看有没有开播
     * @return
     */
    @RequestMapping(value = "isLive", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String isLive(String uid){
        JSONObject resObj = new JSONObject();
        TLiveRoom tLiveRoom = new TLiveRoom();
        tLiveRoom.setUid(uid);
        List<TLiveRoom> queryRoom = tLiveRoomService.getLRoomListByParam(tLiveRoom, null, null);

        resObj.put("status", Const.STATUS_SUCCESS);
        if(queryRoom.get(0).getIslive() == 1){
            resObj.put("kaibo", "Y");
        }else{
            resObj.put("kaibo", "N");
        }
        return resObj.toString();
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
     * 直播页根据分类显示所有开播的直播。
     */
    @RequestMapping(value = "fenlei", produces = "text/html;charset=UTF-8")
    public String fenlei(Model model, String typeid){

        TRoomType tRoomType = tRoomTypeService.getRTypeById(typeid);

        model.addAttribute("roomtype", tRoomType.getName());

        TLiveRoom queryRoom = new TLiveRoom();
        queryRoom.setIslive(1);
        queryRoom.setRoomtype(typeid);
        //TODO: 之后可以用Order类进行人气排序，后期进行智能推荐。现在先只是随便找一个开播的放在首页
        List<TLiveRoom> list1 = tLiveRoomService.getLRoomListByParam(queryRoom, null, null);
        if(list1.size() == 0){
            //不要让这种没有任何直播开启的情况出现。
            model.addAttribute("liverooms", "none");
            return "index/fenlei";
        }

        model.addAttribute("liverooms", list1);
        return "index/fenlei";
    }

    /**
     * 获取直播间人数
     */
    @RequestMapping(value = "getOnlineNum", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getOnlineNum(String roomnum, String onlinenum){
        JSONObject resObj = new JSONObject();
        Jedis jedis = JedisPoolUtils.getJedis();
        try {
            onlinenum = jedis.get(roomnum);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (jedis != null) {
                JedisPoolUtils.returnRes(jedis);
            }
        }

        resObj.put("status", Const.STATUS_SUCCESS);
        resObj.put("onlinenum", onlinenum);
        return resObj.toString();
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
        List<TLiveRoom> kaiboList = new ArrayList<>();
        List<TLiveRoom> weikaiboList = new ArrayList<>();
        for(int i = 0; i < list2.size(); i++){
            queryRoom.setUid(list2.get(i).getFollowid());
            //未开播
            queryRoom.setIslive(1);
            List<TLiveRoom> list3 = tLiveRoomService.getLRoomListByParam(queryRoom, null, null);
            if(list3.size() != 0){
                kaiboList.add(list3.get(0));
            }
            //已开播
            queryRoom.setIslive(0);
            List<TLiveRoom> list4 = tLiveRoomService.getLRoomListByParam(queryRoom, null, null);
            if(list4.size() != 0){
                weikaiboList.add(list4.get(0));
            }
        }

        if(kaiboList.size() != 0){
            resObj.put("kaibos", kaiboList);
        }else{
            resObj.put("kaibos", 0);
        }

        if(weikaiboList.size() != 0){
            resObj.put("weikaibos", weikaiboList);
        }else{
            resObj.put("weikaibos", 0);
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

        //搜索房间分类
        TRoomType tRoomType = tRoomTypeService.getRTypeById(room.getRoomtype());
        model.addAttribute("roomtype", tRoomType);

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

    /**
     * 搜索功能
     */
    @RequestMapping(value = "search", produces = "text/html;charset=UTF-8")
    public String search(Model model, String str, HttpServletRequest request){

        //根据房间号搜索
        TLiveRoom queryRoom = new TLiveRoom();
        queryRoom.setRoomnum(str);
        List<TLiveRoom> list1 = tLiveRoomService.getLRoomListByParam(queryRoom, null, null);
        //如果list为空说明房间号错误，搜索不到房间号
        if(list1.size() == 0){
            model.addAttribute("liveroom", Const.STATUS_NO_RESULT);
//            return "error/noRoom";
        }else {
            TLiveRoom room = list1.get(0);

            model.addAttribute("liveroom", room);
        }

        //根据主播昵称搜索
        TUserInfo userInfo = new TUserInfo();
        userInfo.setNickname("%" + str + "%");
        List<TUserInfo> list2 = tUserInfoService.searchLRoomListByNick(userInfo);
        //如果list为空说明搜索不到类似昵称
        if(list2.size() == 0){
            model.addAttribute("liveroom2", Const.STATUS_NO_RESULT);
//            return "error/noRoom";
        }else {
            //根据主播id返回直播间list，当然，这个用户开通了直播间才会被搜索到咯
            List<TLiveRoom> list4 = new LinkedList<>();
            for (TUserInfo ui : list2) {
                TLiveRoom searchRoom = new TLiveRoom();
                searchRoom.setUid(ui.getUid());
                list4.add(tLiveRoomService.getLRoomListByParam(searchRoom, null, null).get(0));
            }
            model.addAttribute("liveroom2", list4);
        }

        //根据直播标题搜索
        TLiveRoom tLiveRoom = new TLiveRoom();
        tLiveRoom.setTitle("%" + str + "%");
        List<TLiveRoom> list3 = tLiveRoomService.searchLRoomListByTitle(tLiveRoom);
        //如果list为空说明搜索不到类似标题
        if(list3.size() == 0){
            model.addAttribute("liveroom3", Const.STATUS_NO_RESULT);
//            return "error/noRoom";
        }else {
            model.addAttribute("liveroom3", list3);
        }

        return "index/search";
    }
}
