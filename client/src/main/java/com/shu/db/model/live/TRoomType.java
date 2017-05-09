package com.shu.db.model.live;

import com.shu.db.model.Pojo;

import java.util.Date;

public class TRoomType extends Pojo {
    private String id;

    private String name;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}