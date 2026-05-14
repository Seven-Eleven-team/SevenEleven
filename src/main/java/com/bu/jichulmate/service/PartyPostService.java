package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.PartyPost;
import com.bu.jichulmate.domain.PartySeller;
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
    private final UserRepository userRepository;

    @Transactional
    public PartyPostResponse createPost(PartyPostRequest request) {
        PartySeller seller = new PartySeller();
        seller.setUserId(request.getSellerId());

        PartyPost post = PartyPost.builder()
                .seller(seller)                  // hostUser → seller
                .shareId(request.getShareId())
                .sharePassword(request.getSharePassword())
                .monthlyPrice(request.getMonthlyPrice())
                .description(request.getDescription())
                .status("WAITING")               // RECRUITING → WAITING
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
        return partyPostRepository.findBySellerUserId(sellerId)  // findByHostUserUserId → findBySellerUserId
                .stream()
                .map(PartyPostResponse::new)
                .toList();
    }
}