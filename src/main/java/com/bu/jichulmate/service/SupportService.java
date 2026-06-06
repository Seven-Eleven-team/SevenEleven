package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.Faq;
import com.bu.jichulmate.domain.Inquiry;
import com.bu.jichulmate.domain.User;
import com.bu.jichulmate.dto.support.FaqResponse;
import com.bu.jichulmate.dto.support.InquiryCreateRequest;
import com.bu.jichulmate.dto.support.InquiryResponse;
import com.bu.jichulmate.repository.FaqRepository;
import com.bu.jichulmate.repository.InquiryRepository;
import com.bu.jichulmate.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class SupportService {

    private final InquiryRepository inquiryRepository;
    private final UserRepository userRepository;
    private final FaqRepository faqRepository;

    /**
     * 문의 등록
     */
    public void createInquiry(Long userId, InquiryCreateRequest request) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("유저를 찾을 수 없습니다."));

        Inquiry inquiry = new Inquiry();

        inquiry.setUserId(user.getUserId());
        inquiry.setTitle(request.getTitle());
        inquiry.setContent(request.getContent());
        inquiry.setStatus("WAITING");
        inquiry.setCreatedAt(LocalDateTime.now());

        inquiryRepository.save(inquiry);
    }

    /**
     * 내 문의 목록 조회
     */
    public List<InquiryResponse> getMyInquiries(Long userId) {
        return inquiryRepository.findByUserId(userId)
                .stream()
                .map(inquiry -> {
                    InquiryResponse res = new InquiryResponse();
                    res.setId(inquiry.getId());
                    res.setTitle(inquiry.getTitle());
                    res.setContent(inquiry.getContent());
                    res.setStatus(inquiry.getStatus());
                    res.setCreatedAt(inquiry.getCreatedAt());
                    return res;
                })
                .toList();
    }

    /**
     * FAQ 전체 조회 (수정: isActive 조건 제거)
     */
    public List<FaqResponse> getActiveFaqs() {
        return faqRepository.findAllByOrderBySortOrderAsc()
                .stream()
                .map(FaqResponse::new)
                .toList();
    }

    /**
     * 카테고리별 FAQ 조회 (수정: 카테고리 필드 삭제로 전체 리스트 반환)
     */
    public List<FaqResponse> getActiveFaqsByCategory(String category) {
        return getActiveFaqs();
    }

    /**
     * 메인 우측 FAQ 모달용 질문 목록 (수정: isActive 조건 제거)
     */
    public List<String> getFaqQuestions() {
        return faqRepository.findAllByOrderBySortOrderAsc()
                .stream()
                .map(Faq::getQuestion)
                .toList();
    }

    /**
     * FAQ 채팅형 간단 응답 (수정: isActive 조건 및 category 검색 조건 제거)
     */
    public String getFaqChatAnswer(String input) {
        String keyword = input == null ? "" : input.trim();

        if (keyword.isBlank()) {
            return "질문 내용을 입력해 주세요.";
        }

        List<Faq> faqs = faqRepository.findAllByOrderBySortOrderAsc();

        return faqs.stream()
                .filter(faq ->
                        faq.getQuestion().contains(keyword)
                                || keyword.contains(faq.getQuestion())
                                || faq.getAnswer().contains(keyword)
                )
                .findFirst()
                .map(Faq::getAnswer)
                .orElse("정확한 답변을 찾지 못했습니다. 고객센터의 1:1 문의를 이용해 주세요.");
    }

    /**
     * 기존 타입 기반 응답 유지
     */
    public String getAnswerByType(int type) {
        switch (type) {
            case 1:
                return "로그인 문제 해결 방법입니다.";
            case 2:
                return "결제 오류 해결 방법입니다.";
            case 3:
                return "회원정보 수정 방법입니다.";
            case 4:
                return "기타 문의는 1:1 문의 작성해주세요.";
            default:
                return "잘못된 입력입니다.";
        }
    }
}