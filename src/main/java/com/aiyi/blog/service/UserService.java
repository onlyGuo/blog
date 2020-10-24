package com.aiyi.blog.service;

import com.aiyi.blog.entity.User;

/**
 * @Author: 郭胜凯
 * @Date: 2020/10/9 16:52
 * @Email 719348277@qq.com
 * @Description: 用户相关业务处理
 */
public interface UserService {

    /**
     * 用户登录
     * @param user
     *      登录用户信息
     * @return
     */
    String login(User user);

    /**
     * 指定用户退出登录
     * @param userId
     *      用户ID
     */
    void logout(int userId);

}
