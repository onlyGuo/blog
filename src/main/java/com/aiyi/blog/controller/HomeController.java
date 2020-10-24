package com.aiyi.blog.controller;

import com.aiyi.blog.assets.NoLogin;
import com.aiyi.blog.entity.Article;
import com.aiyi.blog.service.ArticleService;
import com.aiyi.core.beans.ResultPage;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

/**
 * @Author: 郭胜凯
 * @Date: 2020/10/20 15:39
 * @Email 719348277@qq.com
 * @Description: 主页
 */
@Controller
@RequestMapping
public class HomeController {

    @Resource
    private ArticleService articleService;

    /**
     * 主页
     * @return
     */
    @RequestMapping
    @NoLogin
    public String index(Model model){
        ResultPage<Article> list = articleService.list(null, null, 1, 10);
        model.addAttribute("articleList", list);
        return "index";
    }

}