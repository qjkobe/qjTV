package com.shu.services.account.impl;

import com.shu.db.dao.account.TAccountMapper;
import com.shu.db.model.Order;
import com.shu.db.model.Pager;
import com.shu.db.model.account.TAccount;
import com.shu.services.account.TAccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Administrator on 2017/4/13.
 */
@Service("accountService")
@Transactional
public class TAccountServiceImpl implements TAccountService {

    @Autowired
    TAccountMapper tAccountMapper;

    @SuppressWarnings("unchecked")
    @Override
    @Transactional(readOnly = true)
    public List<TAccount> getaccountListByParam(TAccount account, Order order, Pager page) {
        if (page != null) {
            int count = tAccountMapper.selectCountByParam(account);
            page.setRecordCount(count);
        }
        return tAccountMapper.selectListByParam(account, order, page);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addaccount(TAccount account) {
        tAccountMapper.insertSelective(account);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void modifyaccount(TAccount account) {
        tAccountMapper.updateByPrimaryKeySelective(account);
    }

    @Override
    @Transactional(readOnly = true)
    public TAccount getaccountById(String id) {
        return tAccountMapper.selectByPrimaryKey(id);
    }
}
