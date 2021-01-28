package com.mawson.pojo;

import java.util.List;
import java.util.Map;

/**
 *  @author mawson
 *
 *  id 节点的 id,可以通过他查询id的子节点
 *  text：要显示的节点文本。
 *  state：节点状态，'open' 或 'closed'，默认是 'open'。当设置为 'closed' 时，该节点有子节点，并且将从远程站点加载它们。
 *  服务器查询的结果如果是menu对象 需要把menu 对象转成  TreeResult 给tree展示数据
 */
public class TreeResult {

    private Integer id;
    private String text;
    private String state;

    //attributes：给一个节点添加的自定义属性。
    private Map<String,String> attributes;

    // 节点中添加子节点
    private List<TreeResult> children;

    public TreeResult() {
    }

    public TreeResult(Integer id, String text, String state, Map<String, String> attributes, List<TreeResult> children) {
        this.id = id;
        this.text = text;
        this.state = state;
        this.attributes = attributes;
        this.children = children;
    }

    public List<TreeResult> getChildren() {
        return children;
    }

    public void setChildren(List<TreeResult> children) {
        this.children = children;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public Map<String, String> getAttributes() {
        return attributes;
    }

    public void setAttributes(Map<String, String> attributes) {
        this.attributes = attributes;
    }

    @Override
    public String toString() {
        return "TreeResult{" +
                "id=" + id +
                ", text='" + text + '\'' +
                ", state='" + state + '\'' +
                ", attributes=" + attributes +
                ", children=" + children +
                '}';
    }
}
