package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.Terms;
import com.bu.jichulmate.domain.TermsType;
import com.bu.jichulmate.dto.admin.TermsRequest;
import com.bu.jichulmate.dto.terms.TermsResponse;
import com.bu.jichulmate.repository.TermsRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class AdminTermsService {

    private final TermsRepository termsRepository;

    public List<TermsResponse> getAllTerms() {
        return termsRepository.findAll().stream()
                .map(TermsResponse::from)
                .sorted(
                        Comparator.comparingInt(TermsResponse::getDisplayOrder)
                                .thenComparing(TermsResponse::getApplyDate, Comparator.nullsLast(Comparator.reverseOrder()))
                )
                .toList();
    }

    @Transactional
    public TermsResponse createNewVersion(TermsRequest request) {
        TermsType termsType = TermsType.from(request.getTermType());

        validateRequest(request);

        Terms terms = new Terms();
        terms.setTermType(termsType);
        terms.setVersion(request.getVersion().trim());
        terms.setContent(request.getContent().trim());
        terms.setIsRequired(resolveRequiredFlag(request.getIsRequired(), termsType));
        terms.setApplyDate(request.getApplyDate() == null ? LocalDateTime.now() : request.getApplyDate());

        Terms savedTerms = termsRepository.save(terms);
        return TermsResponse.from(savedTerms);
    }

    private void validateRequest(TermsRequest request) {
        if (request == null) {
            throw new IllegalArgumentException("약관 등록 요청값이 비어 있습니다.");
        }

        if (request.getTermType() == null || request.getTermType().isBlank()) {
            throw new IllegalArgumentException("약관 종류를 선택해야 합니다.");
        }

        if (request.getVersion() == null || request.getVersion().isBlank()) {
            throw new IllegalArgumentException("약관 버전을 입력해야 합니다.");
        }

        if (request.getContent() == null || request.getContent().isBlank()) {
            throw new IllegalArgumentException("약관 본문을 입력해야 합니다.");
        }
    }

    private String resolveRequiredFlag(String isRequired, TermsType termsType) {
        if (isRequired == null || isRequired.isBlank()) {
            return termsType.isRequiredByDefault() ? "Y" : "N";
        }

        String normalized = isRequired.trim().toUpperCase();

        if (!"Y".equals(normalized) && !"N".equals(normalized)) {
            throw new IllegalArgumentException("필수 여부는 Y 또는 N만 사용할 수 있습니다.");
        }

        return normalized;
    }
}
