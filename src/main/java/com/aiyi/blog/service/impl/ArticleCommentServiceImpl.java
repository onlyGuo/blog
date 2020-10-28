package com.aiyi.blog.service.impl;

import com.aiyi.blog.dao.ArticleCommentDao;
import com.aiyi.blog.dao.ArticleDao;
import com.aiyi.blog.entity.ArticleComment;
import com.aiyi.blog.service.ArticleCommentService;
import com.aiyi.core.beans.Method;
import com.aiyi.core.exception.ValidationException;
import com.aiyi.core.sql.where.C;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @Author: 郭胜凯
 * @Date: 2020/10/27 17:05
 * @Email 719348277@qq.com
 * @Description: 文章评论相关业务
 */
@Service
public class ArticleCommentServiceImpl implements ArticleCommentService {


    @Resource
    private ArticleCommentDao articleCommentDao;

    @Resource
    private ArticleDao articleDao;

    @Override
    public List<ArticleComment> list(int articleId) {
        List<ArticleComment> list = articleCommentDao.list(Method.where(ArticleComment::getArticleId, C.EQ, articleId));
        Map<Integer, ArticleComment> commentMap = list.stream().collect(Collectors.toMap(ArticleComment::getId, p -> p));

        List<ArticleComment> result = new LinkedList<>();
        for (ArticleComment comment: commentMap.values()){
            if (comment.getParentId() == 0){
                result.add(comment);
            }else{
                ArticleComment parentComment = commentMap.get(comment.getParentId());
                if (null != parentComment){
                    String repName = parentComment.getNicker();
                    while (parentComment.getParentId() != 0){
                        parentComment = commentMap.get(parentComment.getParentId());
                    }
                    comment.setReplyName(repName);
                    parentComment.getSubList().add(comment);
                }
            }
        }
        return result;
    }

    @Override
    public void publish(ArticleComment articleComment) {
        articleComment.check("nicker", "email", "content");
        if (articleComment.getContent().startsWith("Re:")){
            int i = articleComment.getContent().indexOf("] ");
            if (i != -1){
                articleComment.setContent(articleComment.getContent().substring(i + 2));
            }
        }

        // TODO 此处后期加入评论过滤规则

        if (articleDao.get(articleComment.getArticleId()) == null){
            throw new ValidationException("文章不存在");
        }
        if (articleComment.getParentId() != 0){
            if (articleCommentDao.get(articleComment.getParentId()) == null){
                throw new ValidationException("预回复的内容不存在");
            }
        }
        articleComment.setCreateTime(new Date());
        articleComment.setContent(articleComment.getContent().replace("<", "&lt;")
                .replace(">", "&gt;"));
        articleCommentDao.add(articleComment);
    }
}