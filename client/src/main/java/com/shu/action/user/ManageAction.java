package com.shu.action.user;

import com.alibaba.fastjson.JSONObject;
import com.shu.db.model.Order;
import com.shu.db.model.OrderSort;
import com.shu.db.model.account.TAccount;
import com.shu.db.model.follow.TFollow;
import com.shu.db.model.gift.TGift;
import com.shu.db.model.live.TLiveRoom;
import com.shu.db.model.user.TUser;
import com.shu.services.account.TAccountService;
import com.shu.services.follow.TFollowService;
import com.shu.services.gift.TGiftService;
import com.shu.services.live.TLiveRoomService;
import com.shu.utils.Const;
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
}
