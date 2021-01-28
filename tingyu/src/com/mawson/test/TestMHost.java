package com.mawson.test;

import com.mawson.pojo.Host;
import com.mawson.pojo.HostCondition;
import com.mawson.pojo.PageResult;
import com.mawson.service.IHostService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:application.xml")
public class TestMHost {

    @Autowired
    private IHostService hostService;

    @Test
    public void test01() {
//        PageResult<Host> pageResult = hostService.selectHostInfo(1, 3);
//        System.out.println("pageResult = " + pageResult);
    }

    @Test
    public void test02(){

        HostCondition hostCondition = new HostCondition();
        hostCondition.setHname("张三");
        hostCondition.setHpdiscount("9");

        //状态
        hostCondition.setStatus("1");
        //推荐
        hostCondition.setHpstar("1");
        //升序
        hostCondition.setStrong("desc");
        PageResult<Host> pageResult = hostService.selectHostInfo(1, 2, hostCondition);

        System.out.println("pageResult.getRows() = " + pageResult.getRows());

    }
    
}
