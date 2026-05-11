package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.Faq;
import com.bu.jichulmate.dto.support.FaqResponse;
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
    public void deleteFaq(Long faqId) {
        faqRepository.deleteById(faqId);
    }
}