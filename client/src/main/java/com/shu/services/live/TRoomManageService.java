package com.shu.services.live;

import com.shu.db.model.Order;
import com.shu.db.model.Pager;
import com.shu.db.model.live.TRoomManage;

import java.util.List;

/**
 * Created by Administrator on 2017/3/1.
 */
public interface TRoomManageService {
    public List<TRoomManage> getRManageListByParam(TRoomManage manage, Order order, Pager page);

    public void addRManage(TRoomManage manage);

    public void modifyRManage(TRoomManage manage);

    public TRoomManage getRManageById(String id);
}
