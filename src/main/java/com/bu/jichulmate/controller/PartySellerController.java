package com.bu.jichulmate.controller;

import com.bu.jichulmate.dto.party.SellerRequest;
import com.bu.jichulmate.dto.party.SellerResponse;
import com.bu.jichulmate.service.PartySellerService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/party")
public class PartySellerController {

    private final PartySellerService partySellerService;

    public PartySellerController(PartySellerService partySellerService) {
        this.partySellerService = partySellerService;
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