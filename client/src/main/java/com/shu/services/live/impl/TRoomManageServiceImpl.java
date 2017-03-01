package com.shu.services.live.impl;

import com.shu.db.dao.live.TRoomManageMapper;
import com.shu.db.model.Order;
import com.shu.db.model.Pager;
import com.shu.db.model.live.TRoomManage;
import com.shu.services.live.TRoomManageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Administrator on 2017/3/1.
 */
@Service("RManageService")
@Transactional
public class TRoomManageServiceImpl implements TRoomManageService {

    @Autowired
    TRoomManageMapper tRoomManageMapper;

    @SuppressWarnings("unchecked")
    @Override
    @Transactional(readOnly = true)
    public List<TRoomManage> getRManageListByParam(TRoomManage manage, Order order, Pager page) {
        if (page != null) {
            int count = tRoomManageMapper.selectCountByParam(manage);
            page.setRecordCount(count);
        }
        return tRoomManageMapper.selectListByParam(manage, order, page);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addRManage(TRoomManage manage) {
        tRoomManageMapper.insertSelective(manage);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void modifyRManage(TRoomManage manage) {
        tRoomManageMapper.updateByPrimaryKeySelective(manage);
    }

    @Override
    @Transactional(readOnly = true)
    public TRoomManage getRManageById(String id) {
        return tRoomManageMapper.selectByPrimaryKey(id);
    }
}
