package com.aiyi.blog.controller;

import com.aiyi.blog.assets.NoLogin;
import com.aiyi.blog.entity.Article;
import com.aiyi.blog.entity.dto.ELResultPage;
import com.aiyi.blog.service.ArticleService;
import com.aiyi.core.beans.ResultPage;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
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
        model.addAttribute("page", ELResultPage.createByResultPage(list));
        return "index";
    }

    /**
     * 主页分页
     * @param page
     *      页码
     * @param size
     *      每页条数
     * @param model
     * @return
     */
    @RequestMapping("{page}-{size}")
    @NoLogin
    public String indexPage(@PathVariable int page, @PathVariable int size, Model model){
        ResultPage<Article> list = articleService.list(null, null, page, size);
        model.addAttribute("articleList", list);
        model.addAttribute("page", ELResultPage.createByResultPage(list));
        return "index";
    }

}