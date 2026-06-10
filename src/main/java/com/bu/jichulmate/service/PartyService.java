package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.PartyPost;
import com.bu.jichulmate.domain.PartySeller;
import com.bu.jichulmate.domain.SubscriptionMaster;
import com.bu.jichulmate.dto.party.PartyPostRequest;
import com.bu.jichulmate.repository.PartyPostRepository;
import com.bu.jichulmate.repository.PartySellerRepository;
import com.bu.jichulmate.repository.SubscriptionMasterRepository;
import com.bu.jichulmate.dto.party.PartyDetailResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import java.util.ArrayList;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class PartyService {

    private final PartyPostRepository partyPostRepository;
    private final PartySellerRepository partySellerRepository;
    private final SubscriptionMasterRepository subscriptionMasterRepository;

    @Transactional
    public PartyDetailResponse createPost(PartyPostRequest request) {
        List<PartySeller> sellers = partySellerRepository.findByUserId(request.getSellerId());
        if (sellers.isEmpty()) {
            throw new RuntimeException("판매자 정보를 찾을 수 없습니다.");
        }
        PartySeller seller = sellers.get(0);

        subscriptionMasterRepository.findById(request.getServiceId())
                .orElseThrow(() -> new RuntimeException("서비스 정보를 찾을 수 없습니다."));

        Long partyId = partyPostRepository.getNextSequenceValue();

        partyPostRepository.insertDirect(
                partyId,
                seller.getId(),
                request.getServiceId(),
                request.getShareId(),
                request.getSharePassword(),
                request.getMonthlyPrice(),
                LocalDateTime.now(),
                request.getDescription()
        );

        PartyPost saved = partyPostRepository.findById(partyId)
                .orElseThrow(() -> new RuntimeException("등록 실패"));
        return toResponse(saved);
    }

    // 메인 게시판용: 반려된 건 다른 사람들에게 보이면 안 되므로 필터 유지
    public List<PartyDetailResponse> getAllPosts() {
        return partyPostRepository.findAll()
                .stream()
                .filter(post -> !"REJECTED".equals(post.getStatus()))
                .map(this::toResponse)
                .toList();
    }

    // 내 판매 목록용: 반려된 항목도 내가 볼 수 있도록 필터(.filter) 삭제! ★
    // 반환 타입이 List -> Page 로 바뀌었고, 파라미터에 Pageable이 추가되었습니다!
    public Page<PartyDetailResponse> getPostsBySeller(Long sellerId, Pageable pageable) {

        // 1. 내 판매글을 모두 가져와서 최신순으로 정렬합니다.
        List<PartyDetailResponse> allList = partyPostRepository.findBySellerUserId(sellerId)
                .stream()
                .map(this::toResponse)
                .sorted((a, b) -> b.getCreatedAt().compareTo(a.getCreatedAt()))
                .toList();

        // 2. 페이지 설정(10개씩)에 맞게 데이터를 자릅니다.
        int start = (int) pageable.getOffset();
        int end = Math.min((start + pageable.getPageSize()), allList.size());

        List<PartyDetailResponse> pageContent = new ArrayList<>();
        if (start <= end) {
            pageContent = allList.subList(start, end);
        }

        // 3. 자른 데이터와 페이지 번호를 포장해서 반환합니다.
        return new PageImpl<>(pageContent, pageable, allList.size());
    }

    public List<SubscriptionMaster> getAllServices() {
        return subscriptionMasterRepository.findAll();
    }

    // 엔티티 -> DTO 변환 로직
    private PartyDetailResponse toResponse(PartyPost post) {
        PartyDetailResponse response = new PartyDetailResponse();
        response.setId(post.getId());
        response.setSellerId(post.getSeller().getUserId());
        response.setServiceName(
                post.getService() != null
                        ? post.getService().getServiceName()
                        : null
        );
        response.setShareId(post.getShareId());
        response.setSharePassword(post.getSharePassword());
        response.setMonthlyPrice(post.getMonthlyPrice());
        response.setDescription(post.getDescription());
        response.setStatus(post.getStatus());
        response.setCreatedAt(post.getCreatedAt());

        // ★ 에러 원인 완벽 해결: DB의 거절 사유를 팝업창으로 넘겨주기 위해 필수 추가!
        response.setRejectReason(post.getRejectReason());

        return response;
    }
}