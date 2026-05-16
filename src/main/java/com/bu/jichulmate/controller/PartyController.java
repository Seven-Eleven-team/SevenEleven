package com.bu.jichulmate.controller;

import com.bu.jichulmate.dto.party.PartyPostRequest;
import com.bu.jichulmate.response.PartyDetailResponse;
import com.bu.jichulmate.service.PartyService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/party")
public class PartyController {

    private final PartyService partyService;

    public PartyController(PartyService partyService) {
        this.partyService = partyService;
    }

    @PostMapping("/posts")
    public ResponseEntity<PartyDetailResponse> createPost(@RequestBody PartyPostRequest request) {
        return ResponseEntity.ok(partyService.createPost(request));
    }

    @GetMapping("/posts")
    public ResponseEntity<List<PartyDetailResponse>> getAllPosts() {
        return ResponseEntity.ok(partyService.getAllPosts());
    }

    @GetMapping("/posts/seller/{sellerId}")
    public ResponseEntity<List<PartyDetailResponse>> getPostsBySeller(@PathVariable Long sellerId) {
        return ResponseEntity.ok(partyService.getPostsBySeller(sellerId));
    }
}