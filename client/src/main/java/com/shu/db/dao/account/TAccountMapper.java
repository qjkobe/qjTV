package com.shu.db.dao.account;

import com.shu.db.dao.BaseMapper;
import com.shu.db.model.account.TAccount;

public interface TAccountMapper extends BaseMapper {
    int deleteByPrimaryKey(String id);

    int insert(TAccount record);

    int insertSelective(TAccount record);

    TAccount selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TAccount record);

    int updateByPrimaryKey(TAccount record);
}