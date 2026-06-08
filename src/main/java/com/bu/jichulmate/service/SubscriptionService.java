package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.PartyPost;
import com.bu.jichulmate.domain.Subscription;
import com.bu.jichulmate.domain.User;
import com.bu.jichulmate.dto.subscription.SubscriptionCreateRequest;
import com.bu.jichulmate.dto.subscription.SubscriptionResponse;
import com.bu.jichulmate.repository.PartyPostRepository;
import com.bu.jichulmate.repository.SubscriptionRepository;
import com.bu.jichulmate.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class SubscriptionService {

    private final SubscriptionRepository subscriptionRepository;
    private final UserRepository userRepository;
    private final PartyPostRepository partyPostRepository;

    // 구독 등록
    @Transactional
    public void createSubscription(
            Long userId,
            SubscriptionCreateRequest request
    ) {

        // 회원 조회
        User user = userRepository.findById(userId)
                .orElseThrow(() ->
                        new RuntimeException("회원 없음"));

        // 파티 조회
        PartyPost party = partyPostRepository.findById(
                request.getPartyId()
        ).orElseThrow(() ->
                new RuntimeException("파티 없음"));

        // 시작일
        LocalDate startDate = LocalDate.now();

        // 종료일 계산
        LocalDate endDate =
                startDate.plusMonths(
                        request.getPeriodMonths()
                );

        // 총 결제 금액 계산
        Integer totalAmount =
                request.getMonthlyFee()
                        * request.getPeriodMonths();

        // 구독 객체 생성
        Subscription subscription = new Subscription();

        // 회원 저장
        subscription.setUser(user);

        // 파티 저장
        subscription.setParty(party);

        // 월 요금
        subscription.setMonthlyFee(
                request.getMonthlyFee()
        );

        // 총 결제 금액
        subscription.setTotalAmount(
                totalAmount
        );

        // 구독 개월 수
        subscription.setPeriodMonths(
                request.getPeriodMonths()
        );

        // 시작일
        subscription.setStartDate(
                startDate
        );

        // 종료일
        subscription.setEndDate(
                endDate
        );

        // ★ 수정됨: 삭제된 nextPayDate 로직 제거 및 필수값인 serialCode 생성 추가
        // 주문 고유 시리얼 넘버 생성 (예: ORD-168439201)
        String serialCode = "ORD-" + System.currentTimeMillis();
        subscription.setSerialCode(serialCode);

        // 상태
        subscription.setStatus(
                "ACTIVE"
        );

        subscription.setSerialCode(
                "SUB-" + System.currentTimeMillis()
        );

        // 저장
        subscriptionRepository.save(subscription);

        party.setOccupiedSlots(
                party.getOccupiedSlots() + 1
        );
        if (party.getOccupiedSlots() >= party.getTotalSlots()) {
            party.setStatus("FULL");
        }
    }


    // 내 구독 목록 조회
    @Transactional(readOnly = true)
    public List<SubscriptionResponse> getMySubscriptions(
            Long userId
    ) {

        return subscriptionRepository
                // 필드명이 user의 userId라면 userRepository 메서드명 확인 필요 (보통 findByUserId 또는 findByUser_UserId)
                // 만약 에러나면 findByUserId(userId) 로 수정해주세요.
                .findByUserUserId(userId)
                .stream()
                .map(subscription -> {

                    SubscriptionResponse res =
                            new SubscriptionResponse();

                    // 구독 ID
                    res.setId(
                            subscription.getId()
                    );

                    // 파티 ID
                    res.setPartyId(
                            subscription.getParty().getId()
                    );

                    // OTT 서비스 이름
                    res.setServiceName(
                            subscription.getParty()
                                    .getService()
                                    .getServiceName()
                    );

                    // 월 요금
                    res.setMonthlyFee(
                            (int) subscription.getMonthlyFee()
                    );

                    // 총 결제 금액
                    res.setTotalAmount(
                            (int) subscription.getTotalAmount()
                    );

                    // 구독 개월 수
                    res.setPeriodMonths(
                            subscription.getPeriodMonths()
                    );

                    // 시작일
                    res.setStartDate(
                            subscription.getStartDate()
                    );

                    // 종료일
                    res.setEndDate(
                            subscription.getEndDate()
                    );

                    // ★ 수정됨: 삭제된 nextPayDate 로직 제거
                    // res.setNextPayDate(...) 삭제 완료

                    // 상태
                    res.setStatus(
                            subscription.getStatus()
                    );

                    res.setSerialCode(subscription.getSerialCode());

                    res.setSharedId(subscription.getParty().getShareId());
                    res.setSharedPwd(subscription.getParty().getSharePassword());

                    return res;
                })
                .collect(Collectors.toList());
    }

    @Transactional
    public void cancelSubscription(Long subscriptionId) {
        Subscription subscription = subscriptionRepository.findById(subscriptionId)
                .orElseThrow(() -> new RuntimeException("구독 없음"));

        subscription.setStatus("CANCELLED");
        // save() 안해도 됨 — @Transactional이라 자동 반영
    }
    // 💡 [여기에 추가] 내 정보 메인 화면용: 최신 구독 내역 최대 3개만 잘라서 가져오기
    @Transactional(readOnly = true)
    public List<SubscriptionResponse> getTop3Subscriptions(Long userId) {
        // 1. 기존 메서드로 전체 구독을 긁어옵니다.
        List<SubscriptionResponse> allSubs = getMySubscriptions(userId);

        // 2. 만약 전체 목록이 null이거나 비어있으면 안전하게 바로 빈 리스트 반환
        if (allSubs == null || allSubs.isEmpty()) {
            System.out.println("⚠️ [서비스 로그] 유저 " + userId + "번의 구독 데이터가 DB에 없거나 null입니다.");
            return new ArrayList<>();
        }

        // 3. 최신순 정렬을 보장하기 위해 ID 역순(최신순) 정렬 후 최대 3개 컷팅
        return allSubs.stream()
                .sorted((a, b) -> b.getId().compareTo(a.getId())) // 최신 구독이 위로 오게 정렬
                .limit(3)
                .collect(Collectors.toList());
    }
} // <--- 클래스가 끝나는 맨 마지막 중괄호 바로 위에 넣으셔야 합니다!
