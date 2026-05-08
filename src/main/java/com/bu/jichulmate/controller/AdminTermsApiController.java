package com.bu.jichulmate.controller;

import com.bu.jichulmate.dto.admin.TermsRequest;
import com.bu.jichulmate.dto.terms.TermsResponse;
import com.bu.jichulmate.service.AdminTermsService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/admin/terms")
public class AdminTermsApiController {

    private final AdminTermsService adminTermsService;

    @GetMapping
    public List<TermsResponse> getAllTerms() {
        return adminTermsService.getAllTerms();
    }

    @PostMapping
    public TermsResponse createNewVersion(@RequestBody TermsRequest request) {
        return adminTermsService.createNewVersion(request);
    }
}
