package com.shu.db.dao.user;

import com.shu.db.dao.BaseMapper;
import com.shu.db.model.Pojo;
import com.shu.db.model.user.TUserInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by admin on 2017/2/2.
 */
public interface TUserInfoMapper extends BaseMapper {
    int deleteByPrimaryKey(String id);

    int insert(TUserInfo record);

    int insertSelective(TUserInfo record);

    TUserInfo selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(TUserInfo record);

    int updateByPrimaryKey(TUserInfo record);

    @SuppressWarnings("rawtypes")
    public List searchListByNick(@Param("pojo") Pojo pojo);
}
