package com.yu.filter;

import cn.hutool.core.convert.Convert;
import cn.hutool.core.util.StrUtil;
import cn.hutool.extra.spring.SpringUtil;
import com.yu.common.constant.SecurityConstants;
import com.yu.common.result.ResultCode;
import com.yu.common.util.ResponseUtils;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;


/**
 * 验证码校验过滤器
 *
 * @author yu
 * @since 2023/9/16
 */
public class VerifyCodeFilter extends OncePerRequestFilter {

    private static final AntPathRequestMatcher LOGIN_PATH_REQUEST_MATCHER = new AntPathRequestMatcher(SecurityConstants.LOGIN_PATH, "POST");

    public static final String VERIFY_CODE_PARAM_KEY = "verifyCode";
    public static final String VERIFY_CODE_KEY_PARAM_KEY = "verifyCodeKey";

    @Override
    public void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws ServletException, IOException {
        // 检验登录接口的验证码
        if (LOGIN_PATH_REQUEST_MATCHER.matches(request)) {
            // 请求中的验证码
            String requestVerifyCode = request.getParameter(VERIFY_CODE_PARAM_KEY);

            // 缓存中的验证码
            StringRedisTemplate redisTemplate = SpringUtil.getBean("stringRedisTemplate", StringRedisTemplate.class);
            String verifyCodeKey = request.getParameter(VERIFY_CODE_KEY_PARAM_KEY);
            String cacheVerifyCode = redisTemplate.opsForValue().get(SecurityConstants.VERIFY_CODE_CACHE_PREFIX + verifyCodeKey);
            if (cacheVerifyCode == null) {
                ResponseUtils.writeErrMsg(response, ResultCode.VERIFY_CODE_TIMEOUT);
            } else {
                // 验证码比对
                if (StrUtil.equals(requestVerifyCode, Convert.toStr(cacheVerifyCode))) {
                    chain.doFilter(request, response);
                } else {
                    ResponseUtils.writeErrMsg(response, ResultCode.VERIFY_CODE_ERROR);
                }
            }
        } else {
            // 非登录接口放行
            chain.doFilter(request, response);
        }
    }

}