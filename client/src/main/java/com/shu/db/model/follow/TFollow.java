package com.shu.db.model.follow;

import com.shu.db.model.Pojo;

/**
 * Created by admin on 2017/2/2.
 */
public class TFollow extends Pojo {

    private String id;

    private String followid;

    private String fanid;

    private Integer hufen;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }


    public String getFollowid() {
        return followid;
    }

    public void setFollowid(String followid) {
        this.followid = followid == null ? null : followid.trim();
    }

    public String getFanid() {
        return fanid;
    }

    public void setFanid(String fanid) {
        this.fanid = fanid == null ? null : fanid.trim();
    }

    public Integer getHufen() {
        return hufen;
    }

    public void setHufen(Integer hufen) {
        this.hufen = hufen;
    }

}
