package com.aiyi.blog.controller;

import com.aiyi.blog.assets.NoLogin;
import com.aiyi.blog.entity.Article;
import com.aiyi.blog.service.ArticleCommentService;
import com.aiyi.blog.service.ArticleService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.UUID;

/**
 * 文章
 */
@Controller
@RequestMapping("article")
public class ArticleController {

    @Resource
    private ArticleService articleService;

    @Resource
    private ArticleCommentService articleCommentService;


    /**
     * 文章详情页面
     * @param articleId
     *      文章ID
     * @return
     */
    @NoLogin
    @RequestMapping("{articleId}")
    public String article(@PathVariable int articleId, Model model){
        Article article = articleService.get(articleId);
        if (null == article){
            return "404";
        }
        model.addAttribute("article", article);
        model.addAttribute("validationIndex", UUID.randomUUID().toString().replace("-", ""));
        model.addAttribute("comments", articleCommentService.list(articleId));
        return "article";
    }

}
