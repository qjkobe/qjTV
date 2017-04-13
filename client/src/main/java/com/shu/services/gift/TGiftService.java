package com.shu.services.gift;

import com.shu.db.model.Order;
import com.shu.db.model.Pager;
import com.shu.db.model.gift.TGift;

import java.util.List;

/**
 * Created by Administrator on 2017/4/13.
 */
public interface TGiftService {
    public List<TGift> getgiftListByParam(TGift gift, Order order, Pager page);

    public void addgift(TGift gift);

    public void modifygift(TGift gift);

    public TGift getgiftById(String id);
}
