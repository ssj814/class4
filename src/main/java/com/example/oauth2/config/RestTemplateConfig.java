package com.example.oauth2.config;

import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Configuration // 이 클래스는 Spring의 설정 클래스
public class RestTemplateConfig {

    @Bean // 이 메서드는 Spring의 IoC 컨테이너에 빈으로 등록
    public RestTemplate restTemplate(RestTemplateBuilder restTemplateBuilder) {
        // RestTemplateBuilder를 사용하여 RestTemplate 인스턴스를 생성
        return restTemplateBuilder.build();
    }
}