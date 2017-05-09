package com.shu.services.live.impl;

import com.shu.db.dao.live.TRoomTypeMapper;
import com.shu.db.model.Order;
import com.shu.db.model.Pager;
import com.shu.db.model.live.TRoomType;
import com.shu.services.live.TRoomTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Administrator on 2017/5/9.
 */
@Service("RTypeService")
@Transactional
public class TRoomTypeServiceImpl implements TRoomTypeService {

    @Autowired
    TRoomTypeMapper tRoomTypeMapper;

    @SuppressWarnings("unchecked")
    @Override
    @Transactional(readOnly = true)
    public List<TRoomType> getRTypeListByParam(TRoomType type, Order order, Pager page) {
        if (page != null) {
            int count = tRoomTypeMapper.selectCountByParam(type);
            page.setRecordCount(count);
        }
        return tRoomTypeMapper.selectListByParam(type, order, page);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addRType(TRoomType type) {
        tRoomTypeMapper.insertSelective(type);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void modifyRType(TRoomType type) {
        tRoomTypeMapper.updateByPrimaryKeySelective(type);
    }

    @Override
    @Transactional(readOnly = true)
    public TRoomType getRTypeById(String id) {
        return tRoomTypeMapper.selectByPrimaryKey(id);
    }
}
