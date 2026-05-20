package com.bu.jichulmate.controller;

import com.bu.jichulmate.dto.party.SellerRequest;
import com.bu.jichulmate.dto.party.SellerResponse;
import com.bu.jichulmate.service.MailService;
import com.bu.jichulmate.service.PartySellerService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/party")
public class PartySellerController {

    private final PartySellerService partySellerService;
    private final MailService mailService;

    public PartySellerController(PartySellerService partySellerService, MailService mailService) {
        this.partySellerService = partySellerService;
        this.mailService = mailService;
    }

    @PostMapping("/sellers/send-code")
    public ResponseEntity<String> sendCode(@RequestBody Map<String, String> body) {
        mailService.sendVerificationCode(body.get("email"));
        return ResponseEntity.ok("인증 메일이 발송되었습니다. 이메일을 확인해 주세요.");
    }

    @PostMapping("/sellers/verify-code")
    public ResponseEntity<String> verifyCode(@RequestBody Map<String, String> body) {
        boolean result = mailService.verifyCode(body.get("email"), body.get("code"));
        if (result) return ResponseEntity.ok("이메일 인증이 완료되었습니다.");
        return ResponseEntity.badRequest().body("인증코드가 올바르지 않습니다. 다시 확인해주세요.");
    }

    @PostMapping("/sellers")
    public ResponseEntity<SellerResponse> registerSeller(@RequestBody SellerRequest request) {
        return ResponseEntity.ok(partySellerService.registerSeller(request));
    }

    @GetMapping("/sellers/{userId}")
    public ResponseEntity<SellerResponse> getSeller(@PathVariable Long userId) {
        return ResponseEntity.ok(partySellerService.getSeller(userId));
    }

    @GetMapping("/sellers")
    public ResponseEntity<List<SellerResponse>> getAllSellers() {
        return ResponseEntity.ok(partySellerService.getAllSellers());
    }
}