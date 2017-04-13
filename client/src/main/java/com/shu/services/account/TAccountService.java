package com.shu.services.account;

import com.shu.db.model.Order;
import com.shu.db.model.Pager;
import com.shu.db.model.account.TAccount;

import java.util.List;

/**
 * Created by Administrator on 2017/4/13.
 */
public interface TAccountService {
    public List<TAccount> getaccountListByParam(TAccount account, Order order, Pager page);

    public void addaccount(TAccount account);

    public void modifyaccount(TAccount account);

    public TAccount getaccountById(String id);
}
