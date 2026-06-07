package com.bu.jichulmate.config;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.*;

@Configuration
@RequiredArgsConstructor
public class WebConfig implements WebMvcConfigurer {

    @Value("${file.upload.dir}")
    private String uploadDir;

    private final AdminCheckInterceptor adminCheckInterceptor;

    /**
     * 정적 리소스 매핑
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {

        /*
         * CSS 정적 리소스
         * /css/home.css -> classpath:/static/css/home.css
         */
        registry.addResourceHandler("/css/**")
                .addResourceLocations("classpath:/static/css/");

        /*
         * JS 정적 리소스
         * /js/pages/community-form.js -> classpath:/static/js/pages/community-form.js
         */
        registry.addResourceHandler("/js/**")
                .addResourceLocations("classpath:/static/js/");

        /*
         * 이미지 정적 리소스 + 업로드 이미지 리소스
         *
         * 1순위: C:/upload/ 같은 로컬 업로드 폴더
         * 2순위: src/main/resources/static/images/
         *
         * FileService에서 ATTACHMENTS.FILE_PATH를
         * /images/저장파일명 형태로 저장하니까
         * 이 매핑이 꼭 필요함.
         */
        registry.addResourceHandler("/images/**")
                .addResourceLocations(
                        "file:///" + uploadDir,
                        "classpath:/static/images/"
                );

        /*
         * img 폴더 정적 리소스
         */
        registry.addResourceHandler("/img/**")
                .addResourceLocations("classpath:/static/img/");

        /*
         * favicon
         */
        registry.addResourceHandler("/favicon.ico")
                .addResourceLocations("classpath:/static/");
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

                        /*
                         * 커뮤니티는 목록/상세는 공개로 둘 수 있고,
                         * 글쓰기/수정/삭제/내 글만 로그인 필요로 잡는 게 자연스러움.
                         */
                        "/community/write",
                        "/community/edit/**",
                        "/community/delete/**",
                        "/community/my",

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
                        "/support/api/faqs/**",
                        "/subscription/ott"
                );
        //  관리자 페이지 권한 체크 인터셉터
        registry.addInterceptor(adminCheckInterceptor)
                .addPathPatterns("/admin/**", "/api/admin/**");
    }
}