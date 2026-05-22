package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.PartyPost;
import com.bu.jichulmate.domain.PartySeller;
import com.bu.jichulmate.domain.SubscriptionMaster;
import com.bu.jichulmate.dto.party.PartyPostRequest;
import com.bu.jichulmate.repository.PartyPostRepository;
import com.bu.jichulmate.repository.PartySellerRepository;
import com.bu.jichulmate.repository.SubscriptionMasterRepository;
import com.bu.jichulmate.response.PartyDetailResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class PartyService {

    private final PartyPostRepository partyPostRepository;
    private final PartySellerRepository partySellerRepository;
    private final SubscriptionMasterRepository subscriptionMasterRepository;

    @Transactional
    public PartyDetailResponse createPost(PartyPostRequest request) {
        PartySeller seller = partySellerRepository.findByUserId(request.getSellerId())
                .orElseThrow(() -> new RuntimeException("판매자 정보를 찾을 수 없습니다."));

        SubscriptionMaster service = subscriptionMasterRepository.findById(request.getServiceId())
                .orElseThrow(() -> new RuntimeException("서비스 정보를 찾을 수 없습니다."));

        PartyPost post = PartyPost.builder()
                .seller(seller)
                .service(service)
                .shareId(request.getShareId())
                .sharePassword(request.getSharePassword())
                .monthlyPrice(request.getMonthlyPrice())
                .description(request.getDescription())
                .status("WAITING")
                .build();

        PartyPost saved = partyPostRepository.save(post);
        return toResponse(saved);
    }

    public List<PartyDetailResponse> getAllPosts() {
        return partyPostRepository.findAll()
                .stream()
                .filter(post -> !"REJECTED".equals(post.getStatus()))
                .map(this::toResponse)
                .toList();
    }

    public List<PartyDetailResponse> getPostsBySeller(Long sellerId) {
        return partyPostRepository.findBySellerUserId(sellerId)
                .stream()
                .filter(post -> !"REJECTED".equals(post.getStatus()))
                .map(this::toResponse)
                .toList();
    }

    public List<SubscriptionMaster> getAllServices() {
        return subscriptionMasterRepository.findAll();
    }

    private PartyDetailResponse toResponse(PartyPost post) {
        PartyDetailResponse response = new PartyDetailResponse();
        response.setId(post.getId());
        response.setSellerId(post.getSeller().getUserId());
        response.setOttCategory(post.getService() != null ?
                post.getService().getServiceCategory() : null);
        response.setShareId(post.getShareId());
        response.setSharePassword(post.getSharePassword());
        response.setMonthlyPrice(post.getMonthlyPrice());
        response.setDescription(post.getDescription());
        response.setStatus(post.getStatus());
        response.setCreatedAt(post.getCreatedAt());
        return response;
    }
}