package com.shu.db.dao.live;

import com.shu.db.dao.BaseMapper;
import com.shu.db.model.live.TRoomType;

public interface TRoomTypeMapper extends BaseMapper {
    int deleteByPrimaryKey(String id);

    int insert(TRoomType record);

    int insertSelective(TRoomType record);

    TRoomType selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TRoomType record);

    int updateByPrimaryKey(TRoomType record);
}