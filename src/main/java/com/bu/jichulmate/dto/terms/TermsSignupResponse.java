package com.bu.jichulmate.dto.terms;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class TermsSignupResponse {

    private List<TermsResponse> terms;
    private List<String> requiredTermTypes;
}
