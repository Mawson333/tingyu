package com.mawson.test;

import com.mawson.mapper.MenuMapper;
import com.mawson.pojo.Menu;
import com.mawson.pojo.TreeResult;
import com.mawson.service.IMenuService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:application.xml")
public class TestMenu {

    @Autowired
    private MenuMapper menuMapper;

    @Autowired
    private IMenuService menuService;

    @Test
    public void testMenu() {

        List<Menu> menus = menuMapper.selectMenu(0, 3);
        System.out.println("menus = " + menus);

    }

    @Test
    public void test03(){
        List<TreeResult> treeResultList = menuService.selectMenuAllInfo(0);
        System.out.println("treeResultList = " + treeResultList);

    }

}
