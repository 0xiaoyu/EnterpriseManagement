package com.yu.service.impl;

import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.GifCaptcha;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import com.yu.common.constant.SecurityConstants;
import com.yu.model.dto.CaptchaResult;
import com.yu.model.dto.LoginResult;
import com.yu.security.jwt.JwtTokenProvider;
import com.yu.service.AuthService;
import io.jsonwebtoken.Claims;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.util.Date;
import java.util.concurrent.TimeUnit;

/**
 * @author yu
 * @since 2.4.0
 */
@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements AuthService {

    private final AuthenticationManager authenticationManager;
    private final StringRedisTemplate redisTemplate;
    private final JwtTokenProvider jwtTokenProvider;

    @Value("${captcha.ttl}")
    private Long ttl;

    @Value("${captcha.length}")
    private Integer length;

    @Value("${captcha.width}")
    private Integer width;

    @Value("${captcha.height}")
    private Integer height;

    /**
     * 登录
     *
     * @param username 用户名
     * @param password 密码
     * @return 登录结果
     */
    @Override
    public LoginResult login(String username, String password) {
        UsernamePasswordAuthenticationToken authenticationToken =
                new UsernamePasswordAuthenticationToken(username.toLowerCase().trim(), password);
        Authentication authentication = authenticationManager.authenticate(authenticationToken);
        String accessToken = jwtTokenProvider.createToken(authentication);
        return LoginResult.builder()
                .tokenType("Bearer")
                .accessToken(accessToken)
                .build();
    }

    /**
     * 登出
     */
    @Override
    public void logout() {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        String token = jwtTokenProvider.resolveToken(request);
        if (StrUtil.isNotBlank(token)) {
            Claims claims = jwtTokenProvider.getTokenClaims(token);
            String jti = claims.get("jti", String.class);
            Date expiration = claims.getExpiration();
            if (expiration != null) {
                long ttl = expiration.getTime() - System.currentTimeMillis();
                redisTemplate.opsForValue().set(SecurityConstants.BLACK_TOKEN_CACHE_PREFIX + jti, null, ttl, TimeUnit.MILLISECONDS);
            } else {
                redisTemplate.opsForValue().set(SecurityConstants.BLACK_TOKEN_CACHE_PREFIX + jti, null);
            }
        }
        SecurityContextHolder.clearContext();
    }

    /**
     * 获取验证码
     *
     * @return 验证码
     */
    @Override
    public CaptchaResult getCaptcha() {
        // 获取验证码
        GifCaptcha captcha = CaptchaUtil.createGifCaptcha(width, height, length); // 宽、高、位数
        String captchaCode = captcha.getCode(); // 验证码
        String captchaBase64 = captcha.getImageBase64Data(); // 验证码图片Base64

        // 验证码文本缓存至Redis，用于登录校验
        String verifyCodeKey = IdUtil.fastSimpleUUID();
        redisTemplate.opsForValue().set(SecurityConstants.VERIFY_CODE_CACHE_PREFIX + verifyCodeKey, captchaCode,
                ttl, TimeUnit.SECONDS);
        System.out.println(captchaCode);
        return CaptchaResult.builder()
                .verifyCodeKey(verifyCodeKey)
                .verifyCodeBase64(captchaBase64)
                .build();
    }

}
