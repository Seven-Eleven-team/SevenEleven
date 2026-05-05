package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.Inquiry;
import com.bu.jichulmate.dto.support.InquiryCreateRequest;
import com.bu.jichulmate.dto.support.InquiryResponse;
import com.bu.jichulmate.repository.InquiryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class SupportService {

    private final InquiryRepository inquiryRepository;

    // 문의 작성
    public void createInquiry(Long userId, InquiryCreateRequest request) {

        Inquiry inquiry = new Inquiry();

        inquiry.setUserId(userId);
        inquiry.setTitle(request.getTitle());
        inquiry.setContent(request.getContent());
        inquiry.setStatus("WAITING");

        inquiryRepository.save(inquiry);
    }

    // 내 문의 목록
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