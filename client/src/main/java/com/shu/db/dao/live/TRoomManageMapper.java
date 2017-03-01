package com.shu.db.dao.live;

import com.shu.db.dao.BaseMapper;
import com.shu.db.model.live.TRoomManage;

public interface TRoomManageMapper extends BaseMapper {
    int deleteByPrimaryKey(String id);

    int insert(TRoomManage record);

    int insertSelective(TRoomManage record);

    TRoomManage selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TRoomManage record);

    int updateByPrimaryKey(TRoomManage record);
}