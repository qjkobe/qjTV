package com.shu.db.dao.live;

import com.shu.db.dao.BaseMapper;
import com.shu.db.model.Pojo;
import com.shu.db.model.live.TLiveRoom;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TLiveRoomMapper extends BaseMapper {
    int deleteByPrimaryKey(String id);

    int insert(TLiveRoom record);

    int insertSelective(TLiveRoom record);

    TLiveRoom selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TLiveRoom record);

    int updateByPrimaryKey(TLiveRoom record);

    @SuppressWarnings("rawtypes")
    public List searchListByTitle(@Param("pojo") Pojo pojo);
}