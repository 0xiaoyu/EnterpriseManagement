package com.yu.service;

import jakarta.annotation.Resource;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDate;

@SpringBootTest
class IClockLogServiceTest {
    @Resource
    private IClockLogService service;

    @Test
    public void test() {
        System.out.println(service.countLateDay(LocalDate.now().minusDays(1), LocalDate.now()));
    }

}