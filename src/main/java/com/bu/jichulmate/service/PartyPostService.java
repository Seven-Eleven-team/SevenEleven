package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.PartyPost;
import com.bu.jichulmate.domain.PartySeller;
import com.bu.jichulmate.domain.SubscriptionMaster;
import com.bu.jichulmate.dto.party.PartyPostRequest;
import com.bu.jichulmate.dto.party.PartyPostResponse;
import com.bu.jichulmate.repository.PartyPostRepository;
import com.bu.jichulmate.repository.PartySellerRepository;
import com.bu.jichulmate.repository.SubscriptionMasterRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class PartyPostService {

    private final PartyPostRepository partyPostRepository;
    private final PartySellerRepository partySellerRepository; // ★ 추가
    // ★ 주의: SubscriptionMasterRepository 파일이 없다면 하나 만들어주셔야 합니다!
    private final SubscriptionMasterRepository subscriptionMasterRepository; // ★ 추가

    @Transactional
    public PartyPostResponse createPost(PartyPostRequest request) {
        // 1. sellerId로 PartySeller 객체를 찾습니다.
        PartySeller seller = partySellerRepository.findByUserId(request.getSellerId())
                .orElseThrow(() -> new RuntimeException("판매자 정보를 찾을 수 없습니다."));

        // 2. 서비스 ID(기존 ottCategory)로 SubscriptionMaster 객체를 찾습니다.
        // (주의: DTO인 PartyPostRequest에 serviceId를 넘겨주도록 변경되어야 합니다)
        SubscriptionMaster service = subscriptionMasterRepository.findById(request.getServiceId())
                .orElseThrow(() -> new RuntimeException("서비스 정보를 찾을 수 없습니다."));

        // 3. 최신 엔티티 구조에 맞춰서 데이터를 조립합니다.
        PartyPost post = PartyPost.builder()
                .seller(seller) // ★ hostUser 대신 seller 객체 세팅
                .service(service) // ★ ottCategory 대신 service 마스터 객체 세팅
                .shareId(request.getShareId())
                .sharePassword(request.getSharePassword())
                .monthlyPrice(request.getMonthlyPrice())
                .description(request.getDescription())
                .status("WAITING") // ★ RECRUITING -> WAITING (엔티티 기본값 맞춤)
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
        // ★ 에러 원인 해결: findByHostUserUserId -> findBySellerUserId 로 호출 변경!
        return partyPostRepository.findBySellerUserId(sellerId)
                .stream()
                .map(PartyPostResponse::new)
                .toList();
    }
}