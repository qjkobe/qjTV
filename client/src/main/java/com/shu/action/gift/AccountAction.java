package com.shu.action.gift;

import com.alibaba.fastjson.JSONObject;
import com.shu.db.model.account.TAccount;
import com.shu.db.model.user.TUser;
import com.shu.services.account.TAccountService;
import com.shu.utils.Const;
import com.shu.utils.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.TagUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2017/4/13.
 */
@Controller
@RequestMapping(value = "account")
public class AccountAction {

    @Autowired
    TAccountService tAccountService;

    /**
     * 充值
     */
    @RequestMapping(value = "chongzhi", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String chongzhi(TAccount tAccount, int jine, HttpServletRequest request){
        TUser user = (TUser) request.getSession().getAttribute("user");
        JSONObject resObj = new JSONObject();

        TAccount queryAccount = new TAccount();
        queryAccount.setUid(tAccount.getUid());
        List<TAccount> list1 = tAccountService.getaccountListByParam(queryAccount, null, null);
        if(list1.size() == 0){
            //没有就为他创建
            TAccount addAccont = new TAccount();
            addAccont.setId(UUID.getID());
            addAccont.setUid(user.getId());
            addAccont.setMoney(jine);
            addAccont.setTotalmoney(jine);
            tAccountService.addaccount(addAccont);
            resObj.put("status", Const.STATUS_SUCCESS);
        }else{
            TAccount modifyAccount = list1.get(0);
            modifyAccount.setMoney(modifyAccount.getMoney() + jine);
            modifyAccount.setTotalmoney(modifyAccount.getTotalmoney() + jine);
            tAccountService.modifyaccount(modifyAccount);
            resObj.put("status", Const.STATUS_SUCCESS);
        }

        return resObj.toString();
    }

    /**
     * 获取account
     */
    @RequestMapping(value = "getAccount", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getAccount(TAccount tAccount, HttpServletRequest request){
        TUser user = (TUser) request.getSession().getAttribute("user");
        JSONObject resObj = new JSONObject();

        TAccount queryAccount = new TAccount();
        queryAccount.setUid(user.getId());
        List<TAccount> list1 = tAccountService.getaccountListByParam(queryAccount, null, null);
        if(list1.size() == 0){
            //没有就提示，还没有充值过
            resObj.put("status", Const.STATUS_NO_ACCOUNT);
            return resObj.toString();
        }else{
            resObj.put("account", list1.get(0));
            resObj.put("status", Const.STATUS_SUCCESS);
        }

        return resObj.toString();
    }
}
