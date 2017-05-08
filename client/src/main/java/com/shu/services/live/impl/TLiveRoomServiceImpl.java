package com.shu.services.live.impl;

import com.shu.db.dao.live.TLiveRoomMapper;
import com.shu.db.model.Order;
import com.shu.db.model.Pager;
import com.shu.db.model.live.TLiveRoom;
import com.shu.services.live.TLiveRoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Administrator on 2017/2/28.
 */
@Service("lRoomService")
@Transactional
public class TLiveRoomServiceImpl implements TLiveRoomService {

    @Autowired
    TLiveRoomMapper tLiveRoomMapper;

    @SuppressWarnings("unchecked")
    @Override
    @Transactional(readOnly = true)
    public List<TLiveRoom> getLRoomListByParam(TLiveRoom room, Order order, Pager page) {
        if (page != null) {
            int count = tLiveRoomMapper.selectCountByParam(room);
            page.setRecordCount(count);
        }
        return tLiveRoomMapper.selectListByParam(room, order, page);
    }

    @SuppressWarnings("unchecked")
    @Override
    @Transactional(readOnly = true)
    public List<TLiveRoom> searchLRoomListByTitle(TLiveRoom room) {
        return tLiveRoomMapper.searchListByTitle(room);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addLRoom(TLiveRoom room) {
        tLiveRoomMapper.insertSelective(room);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void modifyLRoom(TLiveRoom room) {
        tLiveRoomMapper.updateByPrimaryKeySelective(room);
    }

    @Override
    @Transactional(readOnly = true)
    public TLiveRoom getLRoomById(String id) {
        return tLiveRoomMapper.selectByPrimaryKey(id);
    }
}
