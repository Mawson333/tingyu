package com.mawson.pojo;

import java.util.List;

/**
 *  @author mawosn
 *  datagrid 需要制定的的json格式的数据:
 *    total  总数
 *    rows   集合
 *  json的字符串的数据格式:
 *  把数据格式封装成一个对象, 对象中封装total, rows 属性转成json字符串给datagrid填充数据
 */
public class PageResult<T> {
    //总数
    private long total;

    // rows 集合
    private List<T> rows;

    public PageResult() {
    }

    public PageResult(long total, List<T> rows) {
        this.total = total;
        this.rows = rows;
    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    public List<T> getRows() {
        return rows;
    }

    public void setRows(List<T> rows) {
        this.rows = rows;
    }

    @Override
    public String toString() {
        return "PageResult{" +
                "total=" + total +
                ", rows=" + rows +
                '}';
    }
}
