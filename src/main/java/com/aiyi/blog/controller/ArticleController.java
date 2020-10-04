package com.aiyi.blog.controller;

import com.aiyi.blog.assets.NoLogin;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 文章
 */
@Controller
@RequestMapping("article")
public class ArticleController {

    /**
     * 文章详情页面
     * @param articleId
     *      文章ID
     * @return
     */
    @NoLogin
    @RequestMapping("{articleId}")
    public String article(@PathVariable int articleId){
        return "article";
    }

}
