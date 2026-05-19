package com.bu.jichulmate.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.*;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    /**
     * 정적 리소스 매핑
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler(
                        "/css/**",
                        "/js/**",
                        "/images/**",
                        "/img/**",
                        "/favicon.ico"
                )
                .addResourceLocations(
                        "classpath:/static/css/",
                        "classpath:/static/js/",
                        "classpath:/static/images/",
                        "classpath:/static/img/",
                        "classpath:/static/"
                );
    }

    /**
     * 로그인 필요한 페이지 인터셉터 등록
     */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new LoginCheckInterceptor())
                .addPathPatterns(
                        "/mypage/**",
                        "/expense/**",
                        "/expenses/**",
                        "/dashboard/**",
                        "/goal/**",
                        "/subscription/**",
                        "/subscriptions/**",
                        "/party/**",
                        "/support/qna/**",
                        "/ai/**",
                        "/mentor/**"
                )
                .excludePathPatterns(
                        "/",
                        "/index",
                        "/auth/**",
                        "/api/auth/**",
                        "/api/terms/**",
                        "/css/**",
                        "/js/**",
                        "/images/**",
                        "/img/**",
                        "/favicon.ico",
                        "/support",
                        "/support/type",
                        "/support/api/faqs/**"
                );
    }
}