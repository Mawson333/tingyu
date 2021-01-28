package com.mawson.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.mawson.pojo.MarriedPerson;
import com.mawson.mapper.MarriedPersonMapper;
import com.mawson.pojo.PageResult;
import com.mawson.service.IMarriedPersonService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2021-01-08
 */
@Service
public class MarriedPersonServiceImpl extends ServiceImpl<MarriedPersonMapper, MarriedPerson> implements IMarriedPersonService {

    @Autowired
    private MarriedPersonMapper marriedPersonMapper;

    @Override
    public PageResult<MarriedPerson> setMarriedPersoninfoService(Integer page, Integer rows, String pname, String phone) {
        //分页对象
        Page<MarriedPerson> p = new Page<>(page,rows);

        //条件构造器
        QueryWrapper<MarriedPerson> qr = new QueryWrapper<>();
        if (StringUtils.hasText(pname)){
            qr.like("pname",pname);
        }
        if (StringUtils.hasText(phone)) {
            qr.like("phone",phone);
        }

        //条件查询
        Page<MarriedPerson> marriedPersonPage = marriedPersonMapper.selectPage(p, qr);

        //封装PageResult
        return new PageResult<>(marriedPersonPage.getTotal(),marriedPersonPage.getRecords());
    }
}
