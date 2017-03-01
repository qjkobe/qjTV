package com.shu.db.dao.follow;

import com.shu.db.dao.BaseMapper;
import com.shu.db.model.follow.TFollow;

/**
 * Created by admin on 2017/2/2.
 */
public interface TFollowMapper extends BaseMapper{
    int deleteByPrimaryKey(String id);

    int insert(TFollow record);

    int insertSelective(TFollow record);

    TFollow selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TFollow record);

    int updateByPrimaryKey(TFollow record);
}
