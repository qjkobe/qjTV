package com.shu.services.user.impl;

import com.shu.db.dao.user.TUserInfoMapper;
import com.shu.db.model.Order;
import com.shu.db.model.Pager;
import com.shu.db.model.user.TUserInfo;
import com.shu.services.user.TUserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by admin on 2017/2/2.
 */
@Service("userinfoService")
@Transactional
public class TUserInfoServiceImpl implements TUserInfoService {

    @Autowired
    TUserInfoMapper tUserInfoMapper;

    @SuppressWarnings("unchecked")
    @Override
    @Transactional(readOnly = true)
    public List<TUserInfo> getUserinfoListByParam(TUserInfo userinfo, Order order, Pager page) {
        if (page != null) {
            int count = tUserInfoMapper.selectCountByParam(userinfo);
            page.setRecordCount(count);
        }
        return tUserInfoMapper.selectListByParam(userinfo, order, page);
    }

    @SuppressWarnings("unchecked")
    @Override
    @Transactional(readOnly = true)
    public List<TUserInfo> searchLRoomListByNick(TUserInfo userinfo) {
        return tUserInfoMapper.searchListByNick(userinfo);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addUserinfo(TUserInfo userinfo) {
        tUserInfoMapper.insertSelective(userinfo);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void modifyUserinfo(TUserInfo userinfo) {
        tUserInfoMapper.updateByPrimaryKeySelective(userinfo);
    }

    @Override
    @Transactional(readOnly = true)
    public TUserInfo getUserinfoById(String id) {
        return tUserInfoMapper.selectByPrimaryKey(id);
    }
}
