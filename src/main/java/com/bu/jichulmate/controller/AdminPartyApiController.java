package com.bu.jichulmate.controller;

import com.bu.jichulmate.domain.User; // ★ 추가
import com.bu.jichulmate.dto.admin.AdminPartyResponse;
import com.bu.jichulmate.dto.admin.PartyApprovalRequest;
import com.bu.jichulmate.service.AdminPartyService;
import com.bu.jichulmate.util.SessionUtils; // ★ 추가
import jakarta.servlet.http.HttpServletRequest; // ★ 추가
import jakarta.servlet.http.HttpSession; // ★ 추가
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
            @RequestBody PartyApprovalRequest request,
            HttpSession session,               // ★ 세션 추가
            HttpServletRequest httpRequest) {  // ★ IP 추출용 추가
        try {
            // ★ 세션에서 관리자 정보 꺼내기
            User admin = (User) session.getAttribute(SessionUtils.SESSION_USER);
            // ★ IP 주소 꺼내기
            String ipAddress = httpRequest.getRemoteAddr();

            adminPartyService.approveOrRejectParty(partyId, request.isApproved(), request.getRejectReason(), admin, ipAddress);

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
    public ResponseEntity<Map<String, Object>> cancelInvalidParty(
            @PathVariable("partyId") Long partyId,
            HttpSession session,               // ★ 세션 추가
            HttpServletRequest httpRequest) {  // ★ IP 추출용 추가
        try {
            // ★ 세션에서 관리자 정보 꺼내기
            User admin = (User) session.getAttribute(SessionUtils.SESSION_USER);
            // ★ IP 주소 꺼내기
            String ipAddress = httpRequest.getRemoteAddr();

            adminPartyService.cancelInvalidParty(partyId, admin, ipAddress);

            Map<String, Object> body = new LinkedHashMap<>();
            body.put("ok", true);
            body.put("message", "해당 파티가 강제 취소 처리되었습니다.");
            return ResponseEntity.ok(body);
        } catch (IllegalArgumentException e) {
            return fail(HttpStatus.BAD_REQUEST, e.getMessage());
        }
    }

    // 공통 실패 응답 템플릿
    private ResponseEntity<Map<String, Object>> fail(HttpStatus status, String message) {
        Map<String, Object> body = new LinkedHashMap<>();
        body.put("ok", false);
        body.put("message", message);
        return ResponseEntity.status(status).body(body);
    }
}