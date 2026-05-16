package com.bu.jichulmate.service;

import java.time.LocalDateTime;
import com.bu.jichulmate.domain.Inquiry;
import com.bu.jichulmate.domain.User; // ★ 추가
import com.bu.jichulmate.dto.support.InquiryCreateRequest;
import com.bu.jichulmate.dto.support.InquiryResponse;
import com.bu.jichulmate.repository.InquiryRepository;
import com.bu.jichulmate.repository.UserRepository; // ★ 추가
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class SupportService {

    private final InquiryRepository inquiryRepository;
    private final UserRepository userRepository; // ★ User 정보를 가져오기 위해 필수!

    public void createInquiry(Long userId, InquiryCreateRequest request) {
        // 1. DB에서 진짜 User 객체를 찾아옵니다.
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("유저를 찾을 수 없습니다."));

        Inquiry inquiry = new Inquiry();

        // ★ 에러 원인 해결: setUserId 가 아니라 setUser(객체) 로 복구!
        inquiry.setUserId(userId);
        inquiry.setTitle(request.getTitle());
        inquiry.setContent(request.getContent());
        inquiry.setStatus("WAITING");
        inquiry.setCreatedAt(LocalDateTime.now());

        inquiryRepository.save(inquiry);
    }

    public List<InquiryResponse> getMyInquiries(Long userId) {
        // (참고: Repository에 List<Inquiry> findByUserUserId(Long userId) 가 있어야 작동합니다!)
        // 기존에 쓰시던 findByUserId 가 에러가 난다면 findByUserUserId 로 수정해 주세요.
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

    public String getAnswerByType(int type) {
        switch (type) {
            case 1: return "로그인 문제 해결 방법입니다.";
            case 2: return "결제 오류 해결 방법입니다.";
            case 3: return "회원정보 수정 방법입니다.";
            case 4: return "기타 문의는 1:1 문의 작성해주세요.";
            default: return "잘못된 입력입니다.";
        }
    }
}