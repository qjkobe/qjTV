package com.shu.services.live.impl;

import com.shu.db.dao.live.TRoomBanMapper;
import com.shu.db.model.Order;
import com.shu.db.model.Pager;
import com.shu.db.model.live.TRoomBan;
import com.shu.services.live.TRoomBanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Administrator on 2017/3/1.
 */
@Service("RBanService")
@Transactional
public class TRoomBanServiceImpl implements TRoomBanService {

    @Autowired
    TRoomBanMapper tRoomBanMapper;

    @SuppressWarnings("unchecked")
    @Override
    @Transactional(readOnly = true)
    public List<TRoomBan> getRoomBanListByParam(TRoomBan roomBan, Order order, Pager page) {
        if (page != null) {
            int count = tRoomBanMapper.selectCountByParam(roomBan);
            page.setRecordCount(count);
        }
        return tRoomBanMapper.selectListByParam(roomBan, order, page);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addRoomBan(TRoomBan roomBan) {
        tRoomBanMapper.insertSelective(roomBan);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void modifyRoomBan(TRoomBan roomBan) {
        tRoomBanMapper.updateByPrimaryKeySelective(roomBan);
    }

    @Override
    @Transactional(readOnly = true)
    public TRoomBan getRoomBanById(String id) {
        return tRoomBanMapper.selectByPrimaryKey(id);
    }
}
