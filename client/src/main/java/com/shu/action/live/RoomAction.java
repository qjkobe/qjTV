package com.shu.action.live;

import com.alibaba.fastjson.JSONObject;
import com.shu.db.model.live.TLiveRoom;
import com.shu.db.model.live.TRoomBan;
import com.shu.db.model.live.TRoomManage;
import com.shu.db.model.user.TUser;
import com.shu.services.live.TLiveRoomService;
import com.shu.services.live.TRoomBanService;
import com.shu.services.live.TRoomManageService;
import com.shu.utils.Const;
import com.shu.utils.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2017/4/17.
 */
@Controller
@RequestMapping(value = "room")
public class RoomAction {

    @Autowired
    TRoomBanService tRoomBanService;

    @Autowired
    TRoomManageService tRoomManageService;

    @Autowired
    TLiveRoomService tLiveRoomService;

    /**
     * 禁言，发弹幕前需要判断是否已经禁言
     * @return
     */
    @RequestMapping(value = "banUser", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String banUser(TRoomBan tRoomBan, HttpServletRequest request){
        TUser user = (TUser) request.getSession().getAttribute("user");
        JSONObject resObj = new JSONObject();

        //查看是否有禁言权限
        TRoomManage queryManage = new TRoomManage();
        queryManage.setUid(user.getId());
        queryManage.setRid(tRoomBan.getRid());
        queryManage.setIsdelete(0);
        List<TRoomManage> list1 = tRoomManageService.getRManageListByParam(queryManage, null, null);
        if(list1.size() == 0){
            resObj.put("status", Const.STATUS_NO_ACCESS);
            return resObj.toString();
        }

        tRoomBan.setId(UUID.getID());
        tRoomBan.setIsdelete(0);
        tRoomBanService.addRoomBan(tRoomBan);

        resObj.put("status", Const.STATUS_SUCCESS);
        return resObj.toString();
    }

    /**
     * 房管
     * @return
     */
    @RequestMapping(value = "fangguan", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String fangguan(TRoomManage tRoomManage, HttpServletRequest request){
        TUser user = (TUser) request.getSession().getAttribute("user");
        JSONObject resObj = new JSONObject();
        //查看是否有任命权限
        TLiveRoom room = tLiveRoomService.getLRoomById(tRoomManage.getRid());
        if(!room.getUid().equals(user.getId())){
            resObj.put("status", Const.STATUS_NO_ACCESS);
            return resObj.toString();
        }

        //先看以前有没有任命过
        List<TRoomManage> list1 = tRoomManageService.getRManageListByParam(tRoomManage, null ,null);
        if(list1.size() > 0){
            TRoomManage modifyManage = list1.get(0);
            modifyManage.setIsdelete(0);
            tRoomManageService.modifyRManage(modifyManage);
            resObj.put("status", Const.STATUS_SUCCESS);
        }else{
            tRoomManage.setIsdelete(0);
            tRoomManage.setId(UUID.getID());
            tRoomManageService.addRManage(tRoomManage);
            resObj.put("status", Const.STATUS_SUCCESS);
        }
        return resObj.toString();
    }
}
