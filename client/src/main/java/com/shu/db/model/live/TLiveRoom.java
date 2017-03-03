package com.shu.db.model.live;

import com.shu.db.model.Pojo;

import java.util.Date;

public class TLiveRoom extends Pojo {
    private String id;

    private String uid;

    private Integer islive;

    private String app;

    private String stream;

    private String img;

    private Integer people;

    private String title;

    private String gonggao;

    private String roomnum;

    private String rommnick;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public Integer getIslive() {
        return islive;
    }

    public void setIslive(Integer islive) {
        this.islive = islive;
    }

    public String getApp() {
        return app;
    }

    public void setApp(String app) {
        this.app = app;
    }

    public String getStream() {
        return stream;
    }

    public void setStream(String stream) {
        this.stream = stream;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public Integer getPeople() {
        return people;
    }

    public void setPeople(Integer people) {
        this.people = people;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getGonggao() {
        return gonggao;
    }

    public void setGonggao(String gonggao) {
        this.gonggao = gonggao;
    }

    public String getRoomnum() {
        return roomnum;
    }

    public void setRoomnum(String roomnum) {
        this.roomnum = roomnum;
    }

    public String getRommnick() {
        return rommnick;
    }

    public void setRommnick(String rommnick) {
        this.rommnick = rommnick;
    }
}