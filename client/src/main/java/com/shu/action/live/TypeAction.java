package com.shu.action.live;

import com.alibaba.fastjson.JSONObject;
import com.shu.db.model.live.TLiveRoom;
import com.shu.db.model.live.TRoomType;
import com.shu.db.model.user.TUser;
import com.shu.services.live.TLiveRoomService;
import com.shu.services.live.TRoomTypeService;
import com.shu.utils.Const;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2017/5/9.
 */
@Controller
@RequestMapping(value = "type")
public class TypeAction {

    @Autowired
    TLiveRoomService tLiveRoomService;

    @Autowired
    TRoomTypeService tRoomTypeService;

    /**
     * 获取所有直播分类
     * @return
     */
    @RequestMapping(value = "getMenu", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getMenu(HttpServletRequest request){
        TUser user = (TUser) request.getSession().getAttribute("user");
        JSONObject resObj = new JSONObject();

        //把启用的直播分类都选出来。因为还没做，isdelete就先不判断
        TRoomType tRoomType = new TRoomType();
        List<TRoomType> list1 = tRoomTypeService.getRTypeListByParam(tRoomType, null, null);
        resObj.put("status", Const.STATUS_SUCCESS);
        resObj.put("menu", list1);
        return resObj.toString();
    }

    /**
     * 保存新的直播分类
     * @return
     */
    @RequestMapping(value = "saveType", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String saveType(HttpServletRequest request, String roomid, String typeid){
        TUser user = (TUser) request.getSession().getAttribute("user");
        JSONObject resObj = new JSONObject();

        //把启用的直播分类都选出来。因为还没做，isdelete就先不判断
        TLiveRoom tLiveRoom = new TLiveRoom();
        tLiveRoom.setId(roomid);
        tLiveRoom.setRoomtype(typeid);
        tLiveRoomService.modifyLRoom(tLiveRoom);
        resObj.put("status", Const.STATUS_SUCCESS);
        return resObj.toString();
    }
}
