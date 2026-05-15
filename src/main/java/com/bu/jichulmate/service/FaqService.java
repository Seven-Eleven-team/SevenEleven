package com.bu.jichulmate.service;

import com.bu.jichulmate.dto.support.FaqRequest;
import com.bu.jichulmate.dto.support.FaqResponse;
import com.bu.jichulmate.domain.Faq; // ★ Faq 엔티티 위치를 알려주는 핵심 한 줄!
import com.bu.jichulmate.repository.FaqRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class FaqService {

    private final FaqRepository faqRepository;

    public FaqService(FaqRepository faqRepository) {
        this.faqRepository = faqRepository;
    }

    public List<FaqResponse> getFaqList() {
        return faqRepository.findByIsActiveOrderBySortOrderAsc("Y")
                .stream()
                .map(FaqResponse::new)
                .toList();
    }

    public List<FaqResponse> getFaqListByCategory(String category) {
        return faqRepository.findByIsActiveAndCategoryOrderBySortOrderAsc("Y", category)
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
    public FaqResponse createFaq(FaqRequest request) {
        Faq faq = new Faq();
        faq.update(request.getCategory(), request.getQuestion(), request.getAnswer(),
                request.getSortOrder(), request.getIsActive());
        return new FaqResponse(faqRepository.save(faq));
    }

    @Transactional
    public FaqResponse updateFaq(Long faqId, FaqRequest request) {
        Faq faq = faqRepository.findById(faqId)
                .orElseThrow(() -> new RuntimeException("FAQ를 찾을 수 없습니다."));
        faq.update(request.getCategory(), request.getQuestion(), request.getAnswer(),
                request.getSortOrder(), request.getIsActive());
        return new FaqResponse(faq);
    }

    @Transactional
    public void deleteFaq(Long faqId) {
        faqRepository.deleteById(faqId);
    }

    public FaqResponse getFaqByIndex(int index) {
        List<Faq> faqs = faqRepository.findByIsActiveOrderBySortOrderAsc("Y");

        if (index < 1 || index > faqs.size()) {
            return null;
        }

        return new FaqResponse(faqs.get(index - 1));
    }
}