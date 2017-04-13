package com.shu.db.model.gift;

import com.shu.db.model.Pojo;

import java.util.Date;

public class TGift extends Pojo {
    private String id;

    private String sendid;

    private String zhuboid;

    private Integer total;

    private Integer weektotal;

    private Integer monthtotal;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSendid() {
        return sendid;
    }

    public void setSendid(String sendid) {
        this.sendid = sendid;
    }

    public String getZhuboid() {
        return zhuboid;
    }

    public void setZhuboid(String zhuboid) {
        this.zhuboid = zhuboid;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public Integer getWeektotal() {
        return weektotal;
    }

    public void setWeektotal(Integer weektotal) {
        this.weektotal = weektotal;
    }

    public Integer getMonthtotal() {
        return monthtotal;
    }

    public void setMonthtotal(Integer monthtotal) {
        this.monthtotal = monthtotal;
    }
}