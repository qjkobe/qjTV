package com.shu.db.dao.live;

import com.shu.db.dao.BaseMapper;
import com.shu.db.model.live.TRoomBan;

public interface TRoomBanMapper extends BaseMapper {
    int deleteByPrimaryKey(String id);

    int insert(TRoomBan record);

    int insertSelective(TRoomBan record);

    TRoomBan selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TRoomBan record);

    int updateByPrimaryKey(TRoomBan record);
}