package com.shu.action.live;

import com.alibaba.fastjson.JSONObject;
import com.shu.config.SystemConfig;
import com.shu.db.model.live.TLiveRoom;
import com.shu.db.model.user.TUser;
import com.shu.services.live.TLiveRoomService;
import com.shu.utils.Const;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;

/**
 * Created by Administrator on 2017/2/28.
 */
@Controller
@RequestMapping(value = "live")
public class LiveAction {

    @Autowired
    TLiveRoomService tLiveRoomService;

    /**
     * 请在传值前，把TLiveRoom的islive设置成开启或者关闭
     * @param room
     * @return
     */
    @RequestMapping(value = "openRoom", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String openRoom(TLiveRoom room){
        JSONObject resObj = new JSONObject();
        tLiveRoomService.modifyLRoom(room);
        resObj.put("status", Const.STATUS_SUCCESS);

        return resObj.toString();
    }

    /**
     * 修改直播间信息，如标题等
     */
    @RequestMapping(value = "editRoomInfo", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String editRoomInfo(TLiveRoom tLiveRoom){
        JSONObject resObj = new JSONObject();
        tLiveRoomService.modifyLRoom(tLiveRoom);
        resObj.put("status", Const.STATUS_SUCCESS);
        return resObj.toString();
    }

    @RequestMapping(value = "setCover", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String setCover(MultipartFile uploadfile, TLiveRoom room, HttpServletRequest request){
        TUser user = (TUser) request.getSession().getAttribute("user");

        JSONObject resObj = new JSONObject();

        try {
            if (uploadfile != null) {
                String fPath = this.getClass().getResource("/").getPath();
                fPath = fPath.substring(0, fPath.indexOf("WEB-INF"));
                String prefixPath = SystemConfig.p.getProperty("upload.cover.filepath");

                String fileName = uploadfile.getOriginalFilename();
                fileName = fileName.substring(fileName.lastIndexOf("."));
                fileName = System.currentTimeMillis() + fileName;

                String savePath = prefixPath + fileName;

                File saveDirectory = new File(fPath + savePath);

                if (!saveDirectory.getParentFile().exists()) {
                    saveDirectory.getParentFile().mkdirs();
                }

                uploadfile.transferTo(saveDirectory);

                // 更新数据
                TLiveRoom modifyRoom = tLiveRoomService.getLRoomById(room.getId());
                modifyRoom.setImg(fileName);
                modifyRoom.setUpdateUser(user.getId());
                tLiveRoomService.modifyLRoom(modifyRoom);

                resObj.put("status", Const.STATUS_SUCCESS);
            }else{
                System.out.println("为空");
                resObj.put("status", Const.STATUS_ERROR);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return resObj.toString();
    }
}
