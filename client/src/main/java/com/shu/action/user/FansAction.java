package com.shu.action.user;

import com.alibaba.fastjson.JSONObject;
import com.shu.db.model.follow.TFollow;
import com.shu.services.follow.TFollowService;
import com.shu.utils.Const;
import com.shu.utils.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 关注
 * Created by Administrator on 2017/3/7.
 */
@Controller
@RequestMapping(value = "fan")
public class FansAction {

    @Autowired
    TFollowService tFollowService;

    @RequestMapping(value = "follow", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String follow(TFollow tFollow){
        JSONObject resObj = new JSONObject();
        tFollow.setId(UUID.getID());
        //下次取关，不删除此数据，直接设置为1
        tFollow.setIsdelete(0);
        tFollowService.addFollow(tFollow);
        resObj.put("status", Const.STATUS_SUCCESS);
        return resObj.toString();
    }

    @RequestMapping(value = "unfollow", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String unfollow(TFollow tFollow){
        JSONObject resObj = new JSONObject();

        tFollow.setIsdelete(1);
        if(tFollow.getId() == null){
            //没有关注过就取关，不应该出现，但基于逻辑还是作为条件写上
            tFollow.setId(UUID.getID());
            tFollow.setIsdelete(1);
            tFollowService.addFollow(tFollow);
            resObj.put("status", Const.STATUS_SUCCESS);
            return resObj.toString();
        }
        if(tFollowService.getFollowById(tFollow.getId()) != null) {
            tFollow.setIsdelete(1);
            tFollowService.modifyFollow(tFollow);
            resObj.put("status", Const.STATUS_SUCCESS);
            return resObj.toString();
        }else{
            //id错误了，不应该出现，但基于逻辑还是作为条件写上
            tFollow.setIsdelete(1);
            tFollowService.addFollow(tFollow);
            resObj.put("status", Const.STATUS_SUCCESS);
            return resObj.toString();
        }
    }
}
