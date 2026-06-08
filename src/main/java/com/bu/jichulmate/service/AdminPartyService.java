package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.PartyPost;
import com.bu.jichulmate.domain.User; // ★ 추가
import com.bu.jichulmate.dto.admin.AdminPartyResponse;
import com.bu.jichulmate.repository.PartyRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class AdminPartyService {

    private final PartyRepository partyRepository;
    private final AdminAuditService adminAuditService; // ★ 로그 서비스 주입

    // 1. 전체 파티 목록 조회
    @Transactional(readOnly = true)
    public List<AdminPartyResponse> getAllParties() {
        return partyRepository.findAll().stream()
                .map(AdminPartyResponse::fromEntity)
                .collect(Collectors.toList());
    }

    // 2. 특정 파티 상세 정보 조회
    @Transactional(readOnly = true)
    public AdminPartyResponse getPartyDetails(Long partyId) {
        PartyPost party = partyRepository.findById(partyId)
                .orElseThrow(() -> new IllegalArgumentException("해당 파티를 찾을 수 없습니다."));
        return AdminPartyResponse.fromEntity(party);
    }

    // 3. 파티 승인 또는 거절 처리 (★ 관리자, IP 파라미터 추가)
    @Transactional
    public void approveOrRejectParty(Long partyId, boolean isApproved, String rejectReason, User admin, String ipAddress) {
        PartyPost party = partyRepository.findById(partyId)
                .orElseThrow(() -> new IllegalArgumentException("해당 파티를 찾을 수 없습니다."));

        String actionType;
        if (isApproved) {
            party.setStatus("APPROVED"); // 승인
            actionType = "PARTY_APPROVE";
            log.info("[AdminPartyService] 파티 승인 완료 - ID: {}", partyId);
        } else {
            party.setStatus("REJECTED"); // 거절
            party.setRejectReason(rejectReason);
            actionType = "PARTY_REJECT";
            log.info("[AdminPartyService] 파티 거절 완료 - ID: {}, 사유: {}", partyId, rejectReason);
        }

        //  로그 기록 (actionType을 동적으로 다르게 저장합니다)
        if (admin != null) {
            adminAuditService.recordLog(admin, actionType, "PARTY_POSTS", partyId, ipAddress);
        }
    }

    // 4. 불량 파티(사용 불가) 강제 취소/삭제 처리 (★ 관리자, IP 파라미터 추가)
    @Transactional
    public void cancelInvalidParty(Long partyId, User admin, String ipAddress) {
        PartyPost party = partyRepository.findById(partyId)
                .orElseThrow(() -> new IllegalArgumentException("해당 파티를 찾을 수 없습니다."));

        party.setStatus("CANCELED"); // 강제 취소 상태
        log.warn("[AdminPartyService] 불량 파티 강제 취소 완료 - ID: {}", partyId);

        // ★ 로그 기록
        if (admin != null) {
            adminAuditService.recordLog(admin, "PARTY_CANCEL", "PARTY_POSTS", partyId, ipAddress);
        }
    }
}