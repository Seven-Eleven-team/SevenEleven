package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.PartyPost;
import com.bu.jichulmate.domain.User;
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
        User hostUser = userRepository.findById(request.getSellerId())
                .orElseThrow(() -> new IllegalArgumentException("사용자를 찾을 수 없습니다."));

        PartyPost post = PartyPost.builder()
                .hostUser(hostUser)
                .ottCategory(request.getOttCategory())
                .shareId(request.getShareId())
                .sharePassword(request.getSharePassword())
                .monthlyPrice(request.getMonthlyPrice())
                .saleMonths(request.getSaleMonths())
                .description(request.getDescription())
                .status("RECRUITING")
                .deleted(false)
                .build();

        PartyPost saved = partyRepository.save(post);
        return toResponse(saved);
    }

    public List<PartyDetailResponse> getAllPosts() {
        return partyRepository.findAll()
                .stream()
                .filter(post -> !post.isDeleted())
                .map(this::toResponse)
                .toList();
    }

    public List<PartyDetailResponse> getPostsBySeller(Long sellerId) {
        return partyRepository.findAll()
                .stream()
                .filter(post -> !post.isDeleted())
                .filter(post -> post.getHostUser() != null)
                .filter(post -> post.getHostUser().getUserId().equals(sellerId))
                .map(this::toResponse)
                .toList();
    }

    private PartyDetailResponse toResponse(PartyPost post) {
        PartyDetailResponse response = new PartyDetailResponse();
        response.setId(post.getId());
        response.setSellerId(post.getHostUser().getUserId());
        response.setOttCategory(post.getOttCategory());
        response.setShareId(post.getShareId());
        response.setSharePassword(post.getSharePassword());
        response.setMonthlyPrice(post.getMonthlyPrice());
        response.setSaleMonths(post.getSaleMonths());
        response.setDescription(post.getDescription());
        response.setStatus(post.getStatus());
        response.setCreatedAt(post.getCreatedAt());
        return response;
    }
}