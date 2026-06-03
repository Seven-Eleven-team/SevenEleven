package com.bu.jichulmate.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.net.URI;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(MaxUploadSizeExceededException.class)
    public String handleMaxUploadSizeExceededException(
            MaxUploadSizeExceededException e,
            HttpServletRequest request,
            RedirectAttributes ra
    ) {
        ra.addFlashAttribute(
                "msg",
                "이미지 용량이 너무 큽니다. 1장당 10MB, 전체 50MB 이하로 등록해 주세요."
        );

        return "redirect:" + getSafeRedirectPath(request);
    }

    private String getSafeRedirectPath(HttpServletRequest request) {
        String referer = request.getHeader("Referer");

        if (referer == null || referer.isBlank()) {
            return "/community/write";
        }

        try {
            URI uri = URI.create(referer);

            String currentHost = request.getServerName();
            String refererHost = uri.getHost();

            if (refererHost != null && refererHost.equalsIgnoreCase(currentHost)) {
                String path = uri.getRawPath();
                String query = uri.getRawQuery();

                if (path == null || path.isBlank()) {
                    return "/community/write";
                }

                return query == null ? path : path + "?" + query;
            }
        } catch (Exception ignored) {
        }

        return "/community/write";
    }
}