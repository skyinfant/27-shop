/**
 *
 */
package com.xdclass.shop.service;


import com.tomorrowcat.couponserviceapi.dto.CouponNoticeDto;
import com.xdclass.shop.common.Page;
import com.xdclass.shop.model.News;
import com.xdclass.shop.repository.NewsRepository;
import org.apache.dubbo.config.annotation.Reference;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 新闻模块Service
 *
 * @author Daniel
 */
@Service
@Transactional
public class NewsService extends BaseService {

    @Autowired
    NewsRepository newsDao;


//    @Reference
//    private ICouponService iCouponService;

    @Reference
    private com.tomorrowcat.couponserviceapi.service.CouponService couponService;

    public void addNews(News news) {
        newsDao.save(news);
    }

    public void delNews(Integer newsId) {
        newsDao.delete(newsId);
    }

    /**
     * @description:  获取公告栏数据
     * @param: page
     * @return: List<News>
     */
    public List<News> findNews(Page<News> page) {
        List<News> newsList = queryNotice();
        page.setResult(newsList);
        page.setTotalCount(newsList.size());
        return page.getResult();
    }

    public News findById(Integer id) {
        return newsDao.findOne(id);
    }


    /**
     * @description:  调用dubbo接口，从redis获取公告栏数据进行组装
     * @param: 
     * @return: List<News>
     */
    public List<News> queryNotice() {
        List<News> newsList = new ArrayList<>();
        List<CouponNoticeDto> dtos = couponService.queryCouponNotice();

        if (dtos != null){
            newsList = dtos.stream().map(dto -> {
                News news = new News();
                int reduce = dto.getReduceAmount();
                String userName = dto.getUserName();
                String title = dto.getTitle();
                Date saveTime = dto.getSaveTime();

                String title1 = "恭喜" + userName + "使用" + title + "优惠券,获得减免金额" + reduce+"元！";
                news.setTitle(title1);
                news.setCreateTime(saveTime);
                return news;
            }).collect(Collectors.toList());

        }

        return newsList;

    }

}
