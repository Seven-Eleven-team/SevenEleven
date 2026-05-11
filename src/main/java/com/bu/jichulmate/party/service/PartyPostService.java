package com.bu.jichulmate.party.service;

import com.bu.jichulmate.party.dto.PartyPostRequest;
import com.bu.jichulmate.party.dto.PartyPostResponse;
import com.bu.jichulmate.party.entity.PartyPost;
import com.bu.jichulmate.party.repository.PartyPostRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PartyPostService {

    private final PartyPostRepository partyPostRepository;

    public PartyPostService(PartyPostRepository partyPostRepository) {
        this.partyPostRepository = partyPostRepository;
    }

    @Transactional
    public PartyPostResponse createPost(PartyPostRequest request) {
        PartyPost post = new PartyPost();
        post.create(request.getSellerId(), request.getOttCategory(),
                request.getShareId(), request.getSharePassword(),
                request.getMonthlyPrice(), request.getDescription());
        return new PartyPostResponse(partyPostRepository.save(post));
    }

    public List<PartyPostResponse> getAllPosts() {
        return partyPostRepository.findAll()
                .stream()
                .map(PartyPostResponse::new)
                .toList();
    }

    public List<PartyPostResponse> getPostsBySeller(Long sellerId) {
        return partyPostRepository.findBySellerId(sellerId)
                .stream()
                .map(PartyPostResponse::new)
                .toList();
    }
}