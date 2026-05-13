package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.PartyPost; // ★ 완벽한 엔티티 경로
import com.bu.jichulmate.domain.User;
import com.bu.jichulmate.dto.party.PartyPostRequest;
import com.bu.jichulmate.dto.party.PartyPostResponse;
import com.bu.jichulmate.repository.PartyPostRepository;
import com.bu.jichulmate.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class PartyPostService {

    private final PartyPostRepository partyPostRepository;
    private final UserRepository userRepository; // ★ User 조회를 위해 필수!

    @Transactional
    public PartyPostResponse createPost(PartyPostRequest request) {
        // 1. 프론트에서 온 sellerId로 진짜 User 객체를 찾습니다.
        User host = userRepository.findById(request.getSellerId())
                .orElseThrow(() -> new RuntimeException("유저를 찾을 수 없습니다."));

        // 2. 올려주신 완벽한 엔티티에 맞춰서 데이터를 조립합니다!
        PartyPost post = PartyPost.builder()
                .hostUser(host) // ★ User 객체 세팅
                .ottCategory(request.getOttCategory())
                .shareId(request.getShareId())
                .sharePassword(request.getSharePassword())
                .monthlyPrice(request.getMonthlyPrice())
                .description(request.getDescription())
                .status("RECRUITING")
                .deleted(false)
                .build();

        return new PartyPostResponse(partyPostRepository.save(post));
    }

    public List<PartyPostResponse> getAllPosts() {
        return partyPostRepository.findAll()
                .stream()
                .map(PartyPostResponse::new)
                .toList();
    }

    public List<PartyPostResponse> getPostsBySeller(Long sellerId) {
        // ★ 주의: PartyPostRepository에 List<PartyPost> findByHostUserUserId(Long userId); 가 있어야 합니다!
        return partyPostRepository.findByHostUserUserId(sellerId)
                .stream()
                .map(PartyPostResponse::new)
                .toList();
    }
}