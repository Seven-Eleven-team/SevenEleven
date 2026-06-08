package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.Inquiry;
import com.bu.jichulmate.domain.User; // ★ 추가
import com.bu.jichulmate.dto.admin.AdminInquiryResponse;
import com.bu.jichulmate.repository.InquiryRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class AdminSupportService {

    private final InquiryRepository inquiryRepository;
    private final AdminAuditService adminAuditService; // ★ 로그 서비스 주입

    // 1. 전체 1:1 문의 목록 조회
    @Transactional(readOnly = true)
    public List<AdminInquiryResponse> getAllInquiries() {
        return inquiryRepository.findAll().stream()
                .map(AdminInquiryResponse::fromEntity)
                .collect(Collectors.toList());
    }

    // 2. 1:1 문의 답변 등록 및 상태 변경 (★ 관리자, IP 파라미터 추가)
    @Transactional
    public void answerInquiry(Long inquiryId, String answer, User admin, String ipAddress) {
        Inquiry inquiry = inquiryRepository.findById(inquiryId)
                .orElseThrow(() -> new IllegalArgumentException("해당 문의를 찾을 수 없습니다. ID: " + inquiryId));

        // 답변 내용 저장
        inquiry.setAnswerContent(answer);
        inquiry.setStatus("ANSWERED"); // 상태를 '답변 완료'로 변경

        log.info("[AdminSupportService] 1:1 문의 답변 등록 완료 - 문의 ID: {}", inquiryId);

        // ★ 로그 기록 (액션 타입: "ANSWER_INQUIRY", 대상 테이블: "INQUIRIES")
        if (admin != null) {
            adminAuditService.recordLog(admin, "ANSWER_INQUIRY", "INQUIRIES", inquiryId, ipAddress);
        }
    }
}