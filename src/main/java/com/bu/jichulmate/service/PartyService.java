package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.PartyPost;
import com.bu.jichulmate.domain.PartySeller;
import com.bu.jichulmate.domain.SubscriptionMaster;
import com.bu.jichulmate.dto.party.PartyPostRequest;
import com.bu.jichulmate.repository.PartyRepository;
import com.bu.jichulmate.repository.UserRepository;
import com.bu.jichulmate.response.PartyDetailResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class PartyService {

    private final PartyRepository partyRepository;
    private final UserRepository userRepository;

    public PartyDetailResponse createPost(PartyPostRequest request) {
        PartySeller seller = new PartySeller();  // seller 객체 사용
        seller.setUserId(request.getSellerId());

        PartyPost post = PartyPost.builder()
                .seller(seller)                              // hostUser → seller
                .shareId(request.getShareId())
                .sharePassword(request.getSharePassword())
                .monthlyPrice(request.getMonthlyPrice())
                .description(request.getDescription())
                .status("WAITING")                           // RECRUITING → WAITING
                .build();

        PartyPost saved = partyRepository.save(post);
        return toResponse(saved);
    }

    public List<PartyDetailResponse> getAllPosts() {
        return partyRepository.findAll()
                .stream()
                .filter(post -> !"REJECTED".equals(post.getStatus()))  // isDeleted() 없음
                .map(this::toResponse)
                .toList();
    }

    public List<PartyDetailResponse> getPostsBySeller(Long sellerId) {
        return partyRepository.findAll()
                .stream()
                .filter(post -> !"REJECTED".equals(post.getStatus()))  // isDeleted() 없음
                .filter(post -> post.getSeller() != null)              // getHostUser() → getSeller()
                .filter(post -> post.getSeller().getUserId().equals(sellerId))
                .map(this::toResponse)
                .toList();
    }

    private PartyDetailResponse toResponse(PartyPost post) {
        PartyDetailResponse response = new PartyDetailResponse();
        response.setId(post.getId());
        response.setSellerId(post.getSeller().getUserId());            // getHostUser() → getSeller()
        response.setOttCategory(post.getService() != null ?
                post.getService().getServiceCategory() : null);        // getOttCategory() → getService().getServiceCategory()
        response.setShareId(post.getShareId());
        response.setSharePassword(post.getSharePassword());
        response.setMonthlyPrice(post.getMonthlyPrice());
        response.setDescription(post.getDescription());
        response.setStatus(post.getStatus());
        response.setCreatedAt(post.getCreatedAt());
        return response;
    }
}