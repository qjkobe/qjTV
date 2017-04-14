package com.shu.action.gift;

import com.alibaba.fastjson.JSONObject;
import com.shu.db.model.Order;
import com.shu.db.model.OrderSort;
import com.shu.db.model.account.TAccount;
import com.shu.db.model.gift.TGift;
import com.shu.db.model.user.TUser;
import com.shu.services.account.TAccountService;
import com.shu.services.gift.TGiftService;
import com.shu.services.live.TLiveRoomService;
import com.shu.utils.Const;
import com.shu.utils.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2017/4/13.
 */
@Controller
@RequestMapping(value = "gift")
public class GiftAction {

    @Autowired
    TLiveRoomService tLiveRoomService;

    @Autowired
    TGiftService tGiftService;

    @Autowired
    TAccountService tAccountService;

    /**
     * 送礼，先去找，没有记录就新建，有就加
     */
    @RequestMapping(value = "sendGift", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String sendGift(TGift tGift, int giftNum, int giftValue, HttpServletRequest request){
        TUser user = (TUser) request.getSession().getAttribute("user");
        JSONObject resObj = new JSONObject();

        //先看用户有没有登录
        if (user == null) {
            resObj.put("status", Const.STATUS_NOT_LOGIN);
            return resObj.toString();
        }
        //不能给自己送礼
        if(user.getId().equals(tGift.getZhuboid())){
            resObj.put("status", Const.STATUS_FAIL);
            return resObj.toString();
        }
        //查看用户钱够不够
        TAccount queryAccount = new TAccount();
        queryAccount.setUid(user.getId());
        List<TAccount> lista = tAccountService.getaccountListByParam(queryAccount, null, null);
        if(lista.size() == 0){
            //如果没有account就提示他先充值。用户只有充值了第一笔金额才会创建account
            resObj.put("status", Const.STATUS_NO_ACCOUNT);
            return resObj.toString();
        }else{
            TAccount account = lista.get(0);
            if(giftValue > account.getMoney()){
                //余额不足
                resObj.put("status", Const.STATUS_NO_MONEY);
                return resObj.toString();
            }else{
                //减去金额
                account.setMoney(account.getMoney() - giftValue);
                tAccountService.modifyaccount(account);
            }
        }
        //查看这个用户有没有送礼记录
        TGift queryGift1 = new TGift();
        queryGift1.setSendid(user.getId());
        queryGift1.setZhuboid(tGift.getZhuboid());
        List<TGift> list1 = tGiftService.getgiftListByParam(queryGift1, null, null);
        if(list1.size() == 0){
            //新建记录
            TGift newGift = new TGift();
            newGift.setId(UUID.getID());
            newGift.setSendid(user.getId());
            newGift.setZhuboid(tGift.getZhuboid());
            newGift.setTotal(giftNum);
            tGiftService.addgift(newGift);
            resObj.put("status", Const.STATUS_SUCCESS);
            resObj.put("giftInfo", newGift);
        }else{
            //旧记录加total
            TGift modifyGift = list1.get(0);
            modifyGift.setTotal(modifyGift.getTotal() + giftNum);
            tGiftService.modifygift(modifyGift);
            resObj.put("status", Const.STATUS_SUCCESS);
            resObj.put("giftInfo", modifyGift);
        }

        return resObj.toString();
    }

    /**
     * 查看礼物榜，如果是直播间，前端把liveroom的uid当作zhuboid传过来。（如果是主播后台，就把主播的uid传过来）（先已分离此功能）
     */
    @RequestMapping(value = "getGift", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getGift(TGift tGift, HttpServletRequest request){
        TUser user = (TUser) request.getSession().getAttribute("user");
        JSONObject resObj = new JSONObject();

        //查看自己被多少人送礼
        TGift queryGift1 = new TGift();
        queryGift1.setZhuboid(tGift.getZhuboid());

        //按照贡献值排序
        Order order = new Order();
        order.addOrder("total", OrderSort.DESC);

        List<TGift> list1 = tGiftService.getgiftListByParam(queryGift1, order, null);
        if(list1.size() == 0){
            //暂时无人送礼。
            resObj.put("status", Const.STATUS_SUCCESS);
            resObj.put("giftList", Const.STATUS_NO_GIFT);
        }else{
            //把礼物list传回去
            resObj.put("status", Const.STATUS_SUCCESS);
            resObj.put("giftList", list1);
        }

        return resObj.toString();
    }

}
