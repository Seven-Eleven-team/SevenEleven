package com.bu.jichulmate.party.controller;

import com.bu.jichulmate.party.dto.PartyPostRequest;
import com.bu.jichulmate.party.dto.PartyPostResponse;
import com.bu.jichulmate.party.service.PartyPostService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/party")
public class PartyPostController {

    private final PartyPostService partyPostService;

    public PartyPostController(PartyPostService partyPostService) {
        this.partyPostService = partyPostService;
    }

    @PostMapping("/posts")
    public ResponseEntity<PartyPostResponse> createPost(@RequestBody PartyPostRequest request) {
        return ResponseEntity.ok(partyPostService.createPost(request));
    }

    @GetMapping("/posts")
    public ResponseEntity<List<PartyPostResponse>> getAllPosts() {
        return ResponseEntity.ok(partyPostService.getAllPosts());
    }

    @GetMapping("/posts/seller/{sellerId}")
    public ResponseEntity<List<PartyPostResponse>> getPostsBySeller(@PathVariable Long sellerId) {
        return ResponseEntity.ok(partyPostService.getPostsBySeller(sellerId));
    }
}