package com.shu.services.live;

import com.shu.db.model.Order;
import com.shu.db.model.Pager;
import com.shu.db.model.live.TRoomType;

import java.util.List;

/**
 * Created by Administrator on 2017/5/9.
 */
public interface TRoomTypeService {
    public List<TRoomType> getRTypeListByParam(TRoomType type, Order order, Pager page);

    public void addRType(TRoomType type);

    public void modifyRType(TRoomType type);

    public TRoomType getRTypeById(String id);
}
