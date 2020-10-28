package com.aiyi.blog.service;

import com.aiyi.blog.entity.ArticleComment;

import java.util.List;

/**
 * @Author: 郭胜凯
 * @Date: 2020/10/27 17:03
 * @Email 719348277@qq.com
 * @Description: 文章评论相关业务
 */
public interface ArticleCommentService {

    /**
     * 列出某个文章的评论列表
     * @param articleId
     *      文章ID
     * @return
     */
    List<ArticleComment> list(int articleId);

    /**
     * 发布评论
     * @param articleComment
     *      评论内容
     */
    void publish(ArticleComment articleComment);

}
