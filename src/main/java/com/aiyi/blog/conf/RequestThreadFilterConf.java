package com.aiyi.blog.conf;

import com.aiyi.blog.assets.NoLogin;
import com.aiyi.blog.entity.User;
import com.aiyi.blog.util.cache.CacheUtil;
import com.aiyi.blog.util.cache.Key;
import com.aiyi.core.SpringBootApplicationUtil;
import com.aiyi.core.exception.AccessOAuthException;
import com.aiyi.core.util.thread.ThreadUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.client.ResourceAccessException;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.UUID;

/**
 * @Author: 郭胜凯
 * @Date: 2019-05-30 15:23
 * @Email 719348277@qq.com
 * @Description: 请求线程统一过滤配置
 */
@Component
public class RequestThreadFilterConf implements HandlerInterceptor {


    protected Logger logger = LoggerFactory.getLogger(RequestThreadFilterConf.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {

        String reqHeader = request.getHeader("Access-Control-Request-Headers");
        response.setStatus(HttpStatus.OK.value());
        response.setHeader("Access-Control-Allow-Headers", reqHeader);
        if ("OPTIONS".equalsIgnoreCase(request.getMethod())){
            response.setStatus(204);
            return false;
        }

        User loginUser = null;
        if (handler instanceof HandlerMethod){
            HandlerMethod method = (HandlerMethod) handler;
            NoLogin methodAnnotation = method.getMethodAnnotation(NoLogin.class);
            // 这里是认证入口
            String token = getRequestToken(request);
            if (StringUtils.isEmpty(token)){
                if (null == methodAnnotation){
                    throw new AccessOAuthException("请先登录");
                }

            }else{
                // 解析token
                loginUser = CacheUtil.get(Key.as("TOKEN", token), User.class);
                if (null == loginUser){
                    if (null == methodAnnotation){
                        throw new AccessOAuthException("登录已过期");
                    }
                }
            }
        }

        String requestId = request.getHeader("requestId");
        if (StringUtils.isEmpty(requestId)){
            requestId = UUID.randomUUID().toString().toUpperCase();
        }
        ThreadUtil.setRequestId(requestId);


        // 初始化上下文
        initContext(request, loginUser, response);
        return true;
    }

    /**
     * 初始化本次请求上下文
     * @param request
     *          请求方法
     * @param user
     *          当前用户
     */
    private void initContext(HttpServletRequest request, User user, HttpServletResponse response){
        HttpSession session = request.getSession();
        session.setAttribute("ctx", request.getContextPath());

        if (null != user){
            ThreadUtil.setUserEntity(user);
            ThreadUtil.setUserName(user.getNicker());
            ThreadUtil.setUserId((long) user.getId());
        }


        logger.info("requestURI:[{}], requestID:[{}], requestUser:[{}], custAddr:[{}]",
                request.getRequestURI(), ThreadUtil.getRequestId(), null == user ? "annom": user.getEmail(), request.getRemoteAddr());

    }

    /**
     * 获取请求信息中的Token
     * @param request
     *      请求信息
     * @return
     */
    private String getRequestToken(HttpServletRequest request){
        String token = request.getHeader("token");

        if (StringUtils.isEmpty(token)){
            token = request.getHeader("access-token");
        }
        if (StringUtils.isEmpty(token)){
            token = request.getParameter("token");
        }
        if (StringUtils.isEmpty(token)){
            token = request.getParameter("access-token");
        }
        if (StringUtils.isEmpty(token)){
            token = request.getHeader("authorization");
        }
        if (!StringUtils.isEmpty(token)){
            if (token.startsWith("Bearer")){
                token = token.substring(7);
            }
        }
        return token;
    }
}