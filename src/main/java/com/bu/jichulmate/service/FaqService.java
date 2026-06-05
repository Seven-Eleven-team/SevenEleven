package com.bu.jichulmate.service;

import com.bu.jichulmate.dto.support.FaqRequest;
import com.bu.jichulmate.dto.support.FaqResponse;
import com.bu.jichulmate.domain.Faq;
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
        return faqRepository.findAllByOrderBySortOrderAsc()
                .stream()
                .map(FaqResponse::new)
                .toList();
    }

    // 카테고리가 삭제되었으므로, 구조 유지를 위해 일단 전체 리스트를 반환
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
    public FaqResponse createFaq(FaqRequest request) {
        Faq faq = new Faq();
        // ★ 호영님이 작성하신 update 메서드 규격(파라미터 3개)에 완벽하게 맞춤!
        faq.update(request.getQuestion(), request.getAnswer(), request.getSortOrder());
        return new FaqResponse(faqRepository.save(faq));
    }

    @Transactional
    public FaqResponse updateFaq(Long faqId, FaqRequest request) {
        Faq faq = faqRepository.findById(faqId)
                .orElseThrow(() -> new RuntimeException("FAQ를 찾을 수 없습니다."));
        faq.update(request.getQuestion(), request.getAnswer(), request.getSortOrder());
        return new FaqResponse(faq);
    }

    @Transactional
    public void deleteFaq(Long faqId) {
        faqRepository.deleteById(faqId);
    }

    public FaqResponse getFaqByIndex(int index) {
        List<Faq> faqs = faqRepository.findAllByOrderBySortOrderAsc();
        if (index >= 0 && index < faqs.size()) {
            return new FaqResponse(faqs.get(index));
        }
        return null;
    }
}