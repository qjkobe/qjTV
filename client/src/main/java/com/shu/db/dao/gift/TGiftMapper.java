package com.shu.db.dao.gift;

import com.shu.db.dao.BaseMapper;
import com.shu.db.model.gift.TGift;

public interface TGiftMapper extends BaseMapper {
    int deleteByPrimaryKey(String id);

    int insert(TGift record);

    int insertSelective(TGift record);

    TGift selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TGift record);

    int updateByPrimaryKey(TGift record);
}