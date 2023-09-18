package com.yu;

import com.yu.model.entity.SysUser;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;

/**
 * Redis 单元测试
 *
 * @author yu
 * @since 2023/9/16
 */
@SpringBootTest
@Slf4j
public class RedisTests {

    @Autowired
    private  RedisTemplate redisTemplate;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private ValueOperations<String,Object> b;

    /**
     * Redis 序列化测试
     */
    @Test
    public void testRedisSerializer() {
        SysUser user = new SysUser();
        user.setId(1l);
        user.setNickname("张三");
        // 写
        ValueOperations valueOperations = redisTemplate.opsForValue();
        valueOperations.set("user", user);
        ValueOperations<String, String> stringStringValueOperations = stringRedisTemplate.opsForValue();
        String s = stringStringValueOperations.get("user");
        System.out.println(s);
        System.out.println(stringStringValueOperations);
        System.out.println(b);

        // 读
        SysUser userCache = (SysUser)redisTemplate.opsForValue().get("user");
        log.info("userCache:{}", userCache);
        stringRedisTemplate.delete("user");
        System.out.println(stringStringValueOperations.get("user"));

    }

}
