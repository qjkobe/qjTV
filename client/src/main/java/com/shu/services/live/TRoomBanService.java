package com.shu.services.live;

import com.shu.db.model.Order;
import com.shu.db.model.Pager;
import com.shu.db.model.live.TRoomBan;

import java.util.List;

/**
 * Created by Administrator on 2017/3/1.
 */
public interface TRoomBanService {
    public List<TRoomBan> getRoomBanListByParam(TRoomBan roomBan, Order order, Pager page);

    public void addRoomBan(TRoomBan roomBan);

    public void modifyRoomBan(TRoomBan roomBan);

    public TRoomBan getRoomBanById(String id);
}
