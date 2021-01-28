package com.mawson.pojo;

/**
 * @author mawson
 * 条件查询的host对象
 */
public class HostCondition {

    // 姓名 (模糊查询 )
    private String hname;
    // 状态 正常 禁用
    private String status;
    // 通过权重进行排序
    private String strong;

    // 星推荐 / 折扣  是权限表中的数据
    // 星推荐
    private String hpstar;
    // 折扣
    private String hpdiscount;

    public String getHname() {
        return hname;
    }

    public void setHname(String hname) {
        this.hname = hname;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStrong() {
        return strong;
    }

    public void setStrong(String strong) {
        this.strong = strong;
    }

    public String getHpstar() {
        return hpstar;
    }

    public void setHpstar(String hpstar) {
        this.hpstar = hpstar;
    }

    public String getHpdiscount() {
        return hpdiscount;
    }

    public void setHpdiscount(String hpdiscount) {
        this.hpdiscount = hpdiscount;
    }

    @Override
    public String toString() {
        return "HostCondition{" +
                "hname='" + hname + '\'' +
                ", status='" + status + '\'' +
                ", strong='" + strong + '\'' +
                ", hpstar='" + hpstar + '\'' +
                ", hpdiscount='" + hpdiscount + '\'' +
                '}';
    }
}
