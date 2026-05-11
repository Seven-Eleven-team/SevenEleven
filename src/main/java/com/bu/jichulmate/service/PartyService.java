package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.PartyPost;
import com.bu.jichulmate.dto.party.PartyPostRequest;
import com.bu.jichulmate.dto.party.PartyDetailResponse;
import com.bu.jichulmate.repository.PartyRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PartyService {

    private final PartyRepository partyRepository;

    public PartyService(PartyRepository partyRepository) {
        this.partyRepository = partyRepository;
    }

    // 파티 게시글 등록
    @Transactional
    public PartyDetailResponse createPost(PartyPostRequest request) {
        PartyPost post = new PartyPost();
        post.create(request.getSellerId(), request.getOttCategory(),
                request.getShareId(), request.getSharePassword(),
                request.getMonthlyPrice(), request.getDescription());
        return new PartyDetailResponse(partyRepository.save(post));
    }

    // 전체 게시글 조회
    public List<PartyDetailResponse> getAllPosts() {
        return partyRepository.findAll()
                .stream()
                .map(PartyDetailResponse::new)
                .toList();
    }

    // 판매자별 게시글 조회
    public List<PartyDetailResponse> getPostsBySeller(Long sellerId) {
        return partyRepository.findBySellerId(sellerId)
                .stream()
                .map(PartyDetailResponse::new)
                .toList();
    }
}