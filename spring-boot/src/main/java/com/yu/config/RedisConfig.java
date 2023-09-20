package com.yu.config;

import org.springframework.cache.CacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.cache.RedisCacheConfiguration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.data.redis.serializer.RedisSerializationContext;
import org.springframework.data.redis.serializer.RedisSerializer;

import java.time.Duration;

/**
 * Redis 配置
 *
 * @author yu
 * @since 2023/9/16
 */
@Configuration
public class RedisConfig {

    /**
     * 自定义 RedisTemplate
     * <p>
     * 修改 Redis 序列化方式，默认 JdkSerializationRedisSerializer
     *
     * @param redisConnectionFactory {@link RedisConnectionFactory}
     * @return {@link RedisTemplate}
     */
    @Bean
    public RedisTemplate<String, Object> redisTemplate(RedisConnectionFactory redisConnectionFactory) {

        RedisTemplate<String, Object> redisTemplate = new RedisTemplate<>();
        redisTemplate.setConnectionFactory(redisConnectionFactory);

        redisTemplate.setKeySerializer(RedisSerializer.string());
        redisTemplate.setValueSerializer(RedisSerializer.json());

        redisTemplate.setHashKeySerializer(RedisSerializer.string());
        redisTemplate.setHashValueSerializer(RedisSerializer.json());

        redisTemplate.afterPropertiesSet();
        return redisTemplate;
    }

    @Bean
    public ValueOperations<String,Object> valueOperations(RedisTemplate<String,Object> redisTemplate){
        return redisTemplate.opsForValue();
    }

    /**
     * 对缓存进行序列化和反序列化的配置
     * @param factory redis连接工厂
     * @return
     */
    @Bean
    public CacheManager cacheManager(RedisConnectionFactory factory){
        RedisCacheConfiguration config = RedisCacheConfiguration.defaultCacheConfig()
                .entryTtl(Duration.ofDays(1)) // 配置缓存时长
                .prefixCacheNameWith("EM:") // 前缀
                .serializeKeysWith(RedisSerializationContext.SerializationPair.fromSerializer(RedisSerializer.string())) // key序列化方式
                .serializeValuesWith(RedisSerializationContext.SerializationPair.fromSerializer(RedisSerializer.json())); // value序列化方式
        return RedisCacheManager.builder(factory)
                .cacheDefaults(config)
                .build();
    }
}
