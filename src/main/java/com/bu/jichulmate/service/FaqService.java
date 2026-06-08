package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.User; // ★ 추가
import com.bu.jichulmate.dto.support.FaqRequest;
import com.bu.jichulmate.dto.support.FaqResponse;
import com.bu.jichulmate.domain.Faq;
import com.bu.jichulmate.repository.FaqRepository;
import lombok.RequiredArgsConstructor; // ★ 추가
import lombok.extern.slf4j.Slf4j; // ★ 추가
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor // ★ 생성자 주입을 롬복으로 깔끔하게 변경
public class FaqService {

    private final FaqRepository faqRepository;
    private final AdminAuditService adminAuditService; // ★ 로그 서비스 주입

    public List<FaqResponse> getFaqList() {
        return faqRepository.findAllByOrderBySortOrderAsc()
                .stream()
                .map(FaqResponse::new)
                .toList();
    }

    public List<FaqResponse> getFaqListByCategory(String category) {
        return faqRepository.findAllByOrderBySortOrderAsc()
                .stream()
                .map(FaqResponse::new)
                .toList();
    }

    public List<FaqResponse> getAllFaqList() {
        return faqRepository.findAllByOrderBySortOrderAsc()
                .stream()
                .map(FaqResponse::new)
                .toList();
    }

    @Transactional
    public FaqResponse createFaq(FaqRequest request, User admin, String ipAddress) { // ★ 파라미터 추가
        Faq faq = new Faq();
        faq.update(request.getQuestion(), request.getAnswer(), request.getSortOrder());
        Faq savedFaq = faqRepository.save(faq);

        // ★ 로그 기록 (만약 Faq 엔티티의 PK 필드명이 다르다면 savedFaq.getFaqId() 등으로 수정해 주세요)
        if (admin != null) {
            adminAuditService.recordLog(admin, "CREATE_FAQ", "FAQS", savedFaq.getFaqId(), ipAddress);
        }

        return new FaqResponse(savedFaq);
    }

    @Transactional
    public FaqResponse updateFaq(Long faqId, FaqRequest request, User admin, String ipAddress) { // ★ 파라미터 추가
        Faq faq = faqRepository.findById(faqId)
                .orElseThrow(() -> new RuntimeException("FAQ를 찾을 수 없습니다."));
        faq.update(request.getQuestion(), request.getAnswer(), request.getSortOrder());

        // ★ 로그 기록
        if (admin != null) {
            adminAuditService.recordLog(admin, "UPDATE_FAQ", "FAQS", faqId, ipAddress);
        }

        return new FaqResponse(faq);
    }

    @Transactional
    public void deleteFaq(Long faqId, User admin, String ipAddress) { // ★ 파라미터 추가
        faqRepository.deleteById(faqId);

        // ★ 로그 기록
        if (admin != null) {
            adminAuditService.recordLog(admin, "DELETE_FAQ", "FAQS", faqId, ipAddress);
        }
    }

    public FaqResponse getFaqByIndex(int index) {
        List<Faq> faqs = faqRepository.findAllByOrderBySortOrderAsc();
        if (index >= 0 && index < faqs.size()) {
            return new FaqResponse(faqs.get(index));
        }
        return null;
    }
}