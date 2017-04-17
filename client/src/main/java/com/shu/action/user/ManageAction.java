package com.shu.action.user;

import com.alibaba.fastjson.JSONObject;
import com.shu.db.model.Order;
import com.shu.db.model.OrderSort;
import com.shu.db.model.account.TAccount;
import com.shu.db.model.follow.TFollow;
import com.shu.db.model.gift.TGift;
import com.shu.db.model.live.TLiveRoom;
import com.shu.db.model.live.TRoomBan;
import com.shu.db.model.live.TRoomManage;
import com.shu.db.model.user.TUser;
import com.shu.services.account.TAccountService;
import com.shu.services.follow.TFollowService;
import com.shu.services.gift.TGiftService;
import com.shu.services.live.TLiveRoomService;
import com.shu.services.live.TRoomBanService;
import com.shu.services.live.TRoomManageService;
import com.shu.utils.Const;
import com.shu.utils.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2017/4/14.
 */
@Controller
@RequestMapping(value = "manage")
public class ManageAction {

    @Autowired
    TGiftService tGiftService;

    @Autowired
    TFollowService tFollowService;

    @Autowired
    TLiveRoomService tLiveRoomService;

    @Autowired
    TAccountService tAccountService;

    @Autowired
    TRoomManageService tRoomManageService;

    @Autowired
    TRoomBanService tRoomBanService;

    /**
     * 查看自己的成就，送哪些主播多
     */
    @RequestMapping(value = "getChengjiu", produces = "text/html;charset=UTF-8")
    public String getChengjiu(Model model, HttpServletRequest request){
        TUser user = (TUser) request.getSession().getAttribute("user");

        //查看自己送礼给了哪些主播
        TGift queryGift1 = new TGift();
        queryGift1.setSendid(user.getId());

        //按照贡献值排序
        Order order = new Order();
        order.addOrder("total", OrderSort.DESC);

        List<TGift> list1 = tGiftService.getgiftListByParam(queryGift1, order, null);
        if(list1.size() == 0){
            //暂时没有送礼过
            model.addAttribute("chengjiuList", Const.STATUS_NO_GIFT);
        }else{
            //把礼物list传回去
            model.addAttribute("chengjiuList", list1);
        }

        return "manage/chengjiu";
    }

    /**
     * 显示我的关注。
     */
    @RequestMapping(value = "getFollow", produces = "text/html;charset=UTF-8")
    public String getFollow(Model model, HttpServletRequest request){

        TUser user = (TUser) request.getSession().getAttribute("user");

        TFollow queryFollow = new TFollow();
        queryFollow.setFanid(user.getId());
        queryFollow.setIsdelete(0);
        List<TFollow> list2 = tFollowService.getFollowListByParam(queryFollow, null, null);
        if(list2.size() == 0){
            model.addAttribute("followList", 0);
        }else{
            model.addAttribute("followList", list2);
        }
        return "manage/guanzhu";
    }

    /**
     * 充值管理
     */
    @RequestMapping(value = "getAccount", produces = "text/html;charset=UTF-8")
    public String getAccount(Model model, HttpServletRequest request){

        TUser user = (TUser) request.getSession().getAttribute("user");

        TAccount queryAccount = new TAccount();
        queryAccount.setUid(user.getId());

        List<TAccount> list2 = tAccountService.getaccountListByParam(queryAccount, null, null);
        if(list2.size() == 0){
            model.addAttribute("account", "N");
        }else{
            model.addAttribute("account", list2.get(0));
        }
        return "manage/account";
    }

    /**
     * 收礼管理
     */
    @RequestMapping(value = "getGift", produces = "text/html;charset=UTF-8")
    public String getGift(Model model, HttpServletRequest request){
        TUser user = (TUser) request.getSession().getAttribute("user");

        //查看自己被多少人送礼
        TGift queryGift1 = new TGift();
        queryGift1.setZhuboid(user.getId());

        //按照贡献值排序
        Order order = new Order();
        order.addOrder("total", OrderSort.DESC);

        List<TGift> list1 = tGiftService.getgiftListByParam(queryGift1, order, null);
        if(list1.size() == 0){
            //暂时无人送礼。
            model.addAttribute("giftList", Const.STATUS_NO_GIFT);
        }else{
            //把礼物list传回去
            model.addAttribute("giftList", list1);
            int sum = 0;
            for(TGift x : list1){
                sum += x.getTotal();
            }
            model.addAttribute("giftTotal", sum);
        }
        return "manage/gift";
    }

    /**
     * 查看房管和禁言名单
     */
    @RequestMapping(value = "fangjian", produces = "text/html;charset=UTF-8")
    public String fangjian(Model model, HttpServletRequest request){
        TUser user = (TUser) request.getSession().getAttribute("user");

        TLiveRoom queryRoom = new TLiveRoom();
        queryRoom.setUid(user.getId());
        String rid = tLiveRoomService.getLRoomListByParam(queryRoom, null, null).get(0).getId();

        TRoomManage quertManage = new TRoomManage();
        TRoomBan queryBan = new TRoomBan();
        quertManage.setRid(rid);
        queryBan.setRid(rid);
        quertManage.setIsdelete(0);
        queryBan.setIsdelete(0);

        //按照时间倒叙
        Order order = new Order();
        order.addOrder("updateTime", OrderSort.DESC);

        List<TRoomManage> list1 = tRoomManageService.getRManageListByParam(quertManage, order, null);
        List<TRoomBan> list2 = tRoomBanService.getRoomBanListByParam(queryBan, order, null);

        if(list1.size() == 0){
            model.addAttribute("fangguan", Const.STATUS_EMPTY);
        }else{
            model.addAttribute("fangguan", list1);
        }
        if(list2.size() == 0){
            model.addAttribute("jinyan", Const.STATUS_EMPTY);
        }else{
            model.addAttribute("jinyan", list2);
        }

        return "manage/fangjian";
    }

    /**
     * 任命房管
     * @return
     */
    @RequestMapping(value = "fangguan", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String fangguan(TRoomManage tRoomManage, HttpServletRequest request){
        TUser user = (TUser) request.getSession().getAttribute("user");
        JSONObject resObj = new JSONObject();

        TLiveRoom queryRoom = new TLiveRoom();
        queryRoom.setUid(user.getId());
        String rid = tLiveRoomService.getLRoomListByParam(queryRoom, null, null).get(0).getId();
        tRoomManage.setRid(rid);
        //先看以前有没有任命过
        List<TRoomManage> list1 = tRoomManageService.getRManageListByParam(tRoomManage, null ,null);
        if(list1.size() > 0){
            TRoomManage modifyManage = list1.get(0);
            modifyManage.setIsdelete(0);
            tRoomManageService.modifyRManage(modifyManage);
            resObj.put("status", Const.STATUS_SUCCESS);
            return resObj.toString();
        }else{
            tRoomManage.setIsdelete(0);
            tRoomManage.setId(UUID.getID());
            tRoomManageService.addRManage(tRoomManage);
            resObj.put("status", Const.STATUS_SUCCESS);
        }
        return resObj.toString();
    }

    /**
     * 取消房管
     * @return
     */
    @RequestMapping(value = "cancelFG", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String cancelFG(TRoomManage tRoomManage, HttpServletRequest request){
        TUser user = (TUser) request.getSession().getAttribute("user");
        JSONObject resObj = new JSONObject();

        TRoomManage modifyManage = tRoomManageService.getRManageById(tRoomManage.getId());
        modifyManage.setIsdelete(1);
        tRoomManageService.modifyRManage(modifyManage);

        resObj.put("status", Const.STATUS_SUCCESS);
        return resObj.toString();
    }

    /**
     * 取消禁言
     * @return
     */
    @RequestMapping(value = "cancelBan", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String cancelBan(TRoomBan tRoomBan, HttpServletRequest request){
        TUser user = (TUser) request.getSession().getAttribute("user");
        JSONObject resObj = new JSONObject();

        TRoomBan modifyBan = tRoomBanService.getRoomBanById(tRoomBan.getId());
        modifyBan.setIsdelete(1);
        tRoomBanService.modifyRoomBan(modifyBan);

        resObj.put("status", Const.STATUS_SUCCESS);
        return resObj.toString();
    }
}
