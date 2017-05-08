package com.shu.services.live;

import com.shu.db.model.Order;
import com.shu.db.model.Pager;
import com.shu.db.model.live.TLiveRoom;

import java.util.List;

/**
 * Created by Administrator on 2017/2/28.
 */
public interface TLiveRoomService {
    public List<TLiveRoom> getLRoomListByParam(TLiveRoom room, Order order, Pager page);

    public List<TLiveRoom> searchLRoomListByTitle(TLiveRoom room);

    public void addLRoom(TLiveRoom room);

    public void modifyLRoom(TLiveRoom room);

    public TLiveRoom getLRoomById(String id);
}
