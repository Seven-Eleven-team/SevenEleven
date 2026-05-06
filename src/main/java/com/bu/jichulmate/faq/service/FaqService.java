package com.bu.jichulmate.faq.service;

import com.bu.jichulmate.faq.dto.FaqRequest;
import com.bu.jichulmate.faq.dto.FaqResponse;
import com.bu.jichulmate.faq.entity.Faq;
import com.bu.jichulmate.faq.repository.FaqRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class FaqService {

    private final FaqRepository faqRepository;

    public FaqService(FaqRepository faqRepository) {
        this.faqRepository = faqRepository;
    }

    // 사용자 - 전체 목록 조회
    public List<FaqResponse> getFaqList() {
        return faqRepository.findByIsActiveOrderBySortOrderAsc("Y")
                .stream()
                .map(FaqResponse::new)
                .toList();
    }

    // 사용자 - 카테고리별 조회
    public List<FaqResponse> getFaqListByCategory(String category) {
        return faqRepository.findByIsActiveAndCategoryOrderBySortOrderAsc("Y", category)
                .stream()
                .map(FaqResponse::new)
                .toList();
    }

    // 관리자 - 전체 목록 조회 (비활성 포함)
    public List<FaqResponse> getAllFaqList() {
        return faqRepository.findAllByOrderBySortOrderAsc()
                .stream()
                .map(FaqResponse::new)
                .toList();
    }

    // 관리자 - FAQ 등록
    @Transactional
    public FaqResponse createFaq(FaqRequest request) {
        Faq faq = new Faq();
        faq.update(request.getCategory(), request.getQuestion(), request.getAnswer(),
                request.getSortOrder(), request.getIsActive());
        return new FaqResponse(faqRepository.save(faq));
    }

    // 관리자 - FAQ 수정
    @Transactional
    public FaqResponse updateFaq(Long faqId, FaqRequest request) {
        Faq faq = faqRepository.findById(faqId)
                .orElseThrow(() -> new RuntimeException("FAQ를 찾을 수 없습니다."));
        faq.update(request.getCategory(), request.getQuestion(), request.getAnswer(),
                request.getSortOrder(), request.getIsActive());
        return new FaqResponse(faq);
    }

    // 관리자 - FAQ 삭제
    @Transactional
    public void deleteFaq(Long faqId) {
        faqRepository.deleteById(faqId);
    }
}