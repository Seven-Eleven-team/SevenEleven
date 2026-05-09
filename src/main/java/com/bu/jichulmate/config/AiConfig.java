package com.bu.jichulmate.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Configuration
public class AiConfig {

    // 스프링에게 "앞으로 외부 서버랑 통신할 때는 이 무전기(RestTemplate)를 써!" 라고 등록해주는 과정입니다.
    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
}