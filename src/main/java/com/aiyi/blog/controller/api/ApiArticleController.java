package com.aiyi.blog.controller.api;

import com.aiyi.blog.entity.Article;
import com.aiyi.blog.entity.dto.LayerTable;
import com.aiyi.blog.service.ArticleService;
import com.aiyi.core.beans.ResultBean;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * @Author: 郭胜凯
 * @Date: 2020/10/16 15:29
 * @Email 719348277@qq.com
 * @Description: 文章相关接口
 */
@RestController
@RequestMapping("api/v1/article")
public class ApiArticleController {

    @Resource
    private ArticleService articleService;

    /**
     * 列出文章列表
     * @param title
     *      标题过滤
     * @param classifyId
     *      关联栏目ID
     * @param page
     *      页码
     * @param limit
     *      每页条数
     * @return
     */
    @GetMapping
    public LayerTable<Article> list(String title, Integer classifyId, int page, int limit){
        if (classifyId != null && 0 == classifyId){
            classifyId = null;
        }
        return LayerTable.createByPageResult(articleService.list(title, classifyId, page, limit));
    }

    /**
     * 编辑文章
     * @param article
     *      文章信息
     * @return
     */
    @PutMapping
    public ResultBean putArticle(@RequestBody Article article){
        if (article.getId() == 0){
            article = articleService.create(article);
        }else{
            articleService.update(article);
        }
        return ResultBean.success().setResponseBody(article);
    }

}