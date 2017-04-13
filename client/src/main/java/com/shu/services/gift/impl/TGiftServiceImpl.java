package com.shu.services.gift.impl;

import com.shu.db.dao.gift.TGiftMapper;
import com.shu.db.model.Order;
import com.shu.db.model.Pager;
import com.shu.db.model.gift.TGift;
import com.shu.services.gift.TGiftService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Administrator on 2017/4/13.
 */
@Service("giftService")
@Transactional
public class TGiftServiceImpl implements TGiftService {

    @Autowired
    TGiftMapper tGiftMapper;

    @SuppressWarnings("unchecked")
    @Override
    @Transactional(readOnly = true)
    public List<TGift> getgiftListByParam(TGift gift, Order order, Pager page) {
        if (page != null) {
            int count = tGiftMapper.selectCountByParam(gift);
            page.setRecordCount(count);
        }
        return tGiftMapper.selectListByParam(gift, order, page);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addgift(TGift gift) {
        tGiftMapper.insertSelective(gift);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void modifygift(TGift gift) {
        tGiftMapper.updateByPrimaryKeySelective(gift);
    }

    @Override
    @Transactional(readOnly = true)
    public TGift getgiftById(String id) {
        return tGiftMapper.selectByPrimaryKey(id);
    }
}
