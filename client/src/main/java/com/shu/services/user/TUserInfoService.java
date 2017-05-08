package com.shu.services.user;

import com.shu.db.model.Order;
import com.shu.db.model.Pager;
import com.shu.db.model.user.TUserInfo;

import java.util.List;

/**
 * Created by admin on 2017/2/2.
 */
public interface TUserInfoService {
    public List<TUserInfo> getUserinfoListByParam(TUserInfo userinfo, Order order, Pager page);

    public void addUserinfo(TUserInfo userinfo);

    public void modifyUserinfo(TUserInfo userinfo);

    public TUserInfo getUserinfoById(String id);

    public List<TUserInfo> searchLRoomListByNick(TUserInfo userinfo);
}
