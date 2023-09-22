package com.yu.common;


import org.junit.jupiter.api.Test;

import java.time.Duration;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;

public class TimeTest {
    @Test
    public void test(){
        Duration between = Duration.between(LocalTime.of(18, 8), LocalTime.now());
        System.out.println(between.get(ChronoUnit.SECONDS)/60);
    }
}
