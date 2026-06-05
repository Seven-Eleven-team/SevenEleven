package com.bu.jichulmate.controller;

import com.bu.jichulmate.dto.admin.AdminPartyResponse;
import com.bu.jichulmate.dto.admin.PartyApprovalRequest;
import com.bu.jichulmate.service.AdminPartyService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/admin/parties")
@RequiredArgsConstructor
public class AdminPartyApiController {

    private final AdminPartyService adminPartyService;

    // 1. 파티 목록 전체 조회
    @GetMapping
    public ResponseEntity<Map<String, Object>> getPartyList() {
        List<AdminPartyResponse> parties = adminPartyService.getAllParties();

        Map<String, Object> body = new LinkedHashMap<>();
        body.put("ok", true);
        body.put("parties", parties);
        return ResponseEntity.ok(body);
    }

    // 2. 파티 상세 계정 정보 조회 (아이디/비번 확인)
    @GetMapping("/{partyId}")
    public ResponseEntity<Map<String, Object>> getPartyDetails(@PathVariable("partyId") Long partyId) {
        try {
            AdminPartyResponse party = adminPartyService.getPartyDetails(partyId);

            Map<String, Object> body = new LinkedHashMap<>();
            body.put("ok", true);
            body.put("party", party);
            return ResponseEntity.ok(body);
        } catch (IllegalArgumentException e) {
            return fail(HttpStatus.BAD_REQUEST, e.getMessage());
        }
    }

    // 3. 파티 승인/거절 처리
    @PostMapping("/{partyId}/approve")
    public ResponseEntity<Map<String, Object>> processPartyApproval(
            @PathVariable("partyId") Long partyId,
            @RequestBody PartyApprovalRequest request) {
        try {
            adminPartyService.approveOrRejectParty(partyId, request.isApproved(), request.getRejectReason());

            Map<String, Object> body = new LinkedHashMap<>();
            body.put("ok", true);
            body.put("message", request.isApproved() ? "파티가 승인되었습니다." : "파티가 거절되었습니다.");
            return ResponseEntity.ok(body);
        } catch (IllegalArgumentException e) {
            return fail(HttpStatus.BAD_REQUEST, e.getMessage());
        }
    }

    // 4. 불량 파티 강제 취소 처리
    @PostMapping("/{partyId}/cancel")
    public ResponseEntity<Map<String, Object>> cancelInvalidParty(@PathVariable("partyId") Long partyId) {
        try {
            adminPartyService.cancelInvalidParty(partyId);

            Map<String, Object> body = new LinkedHashMap<>();
            body.put("ok", true);
            body.put("message", "해당 파티가 강제 취소 처리되었습니다.");
            return ResponseEntity.ok(body);
        } catch (IllegalArgumentException e) {
            return fail(HttpStatus.BAD_REQUEST, e.getMessage());
        }
    }

    // 공통 실패 응답 템플릿 (각 컨트롤러마다 필요합니다)
    private ResponseEntity<Map<String, Object>> fail(HttpStatus status, String message) {
        Map<String, Object> body = new LinkedHashMap<>();
        body.put("ok", false);
        body.put("message", message);
        return ResponseEntity.status(status).body(body);
    }
}