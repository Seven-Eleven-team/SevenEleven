package com.bu.jichulmate.dto.admin;

import com.bu.jichulmate.domain.PartyPost;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
@Builder
public class AdminPartyResponse {
    private Long partyId;
    private String ottService;      // 넷플릭스, 티빙 등
    private String sellerName;      // 판매자 이름 (닉네임 대신 PartySeller의 실명 사용)
    private String accountId;       // OTT 로그인 아이디
    private String accountPassword; // OTT 로그인 비밀번호
    private int price;              // 파티 요금
    private String status;          // WAITING(대기), APPROVED(승인), REJECTED(거절) 등
    private String rejectReason;    // 거절 사유
    private LocalDateTime createdAt;

    // Entity -> DTO 변환
    public static AdminPartyResponse fromEntity(PartyPost party) {
        return AdminPartyResponse.builder()
                .partyId(party.getId())

                // SubscriptionMaster의 서비스 이름(serviceName) 가져오기
                .ottService(party.getService() != null ? party.getService().getServiceName() : "알 수 없음")

                // PartySeller에 저장된 판매자 실명(name) 가져오기 (해결 완료!)
                .sellerName(party.getSeller() != null ? party.getSeller().getName() : "알 수 없음")

                .accountId(party.getShareId())
                .accountPassword(party.getSharePassword())
                .price(party.getMonthlyPrice())
                .status(party.getStatus())
                .rejectReason(party.getRejectReason())
                .createdAt(party.getCreatedAt())
                .build();
    }
}