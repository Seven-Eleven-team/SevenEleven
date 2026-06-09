package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.Account;
import com.bu.jichulmate.domain.PartyPost;
import com.bu.jichulmate.domain.Subscription;
import com.bu.jichulmate.domain.User;
import com.bu.jichulmate.dto.subscription.SubscriptionCreateRequest;
import com.bu.jichulmate.dto.subscription.SubscriptionResponse;
import com.bu.jichulmate.repository.AccountRepository;
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
    private final AccountRepository accountRepository;

    @Transactional
    public void createSubscription(
            Long userId,
            SubscriptionCreateRequest request
    ) {
        if (userId == null) {
            throw new RuntimeException("로그인이 필요합니다.");
        }

        validateCreateRequest(request);

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("회원 정보를 찾을 수 없습니다."));

        Account paymentAccount = resolvePaymentAccount(user, request.getAccountId());

        if (paymentAccount == null) {
            throw new RuntimeException("마이페이지에서 결제 계좌를 먼저 등록해 주세요.");
        }

        PartyPost party = partyPostRepository.findById(request.getPartyId())
                .orElseThrow(() -> new RuntimeException("판매글 정보를 찾을 수 없습니다."));

        validatePartyAvailable(party);

        LocalDate startDate = LocalDate.now();
        LocalDate endDate = startDate.plusMonths(request.getPeriodMonths());

        int monthlyFee = request.getMonthlyFee();
        int periodMonths = request.getPeriodMonths();
        int totalAmount = monthlyFee * periodMonths;

        Subscription subscription = new Subscription();
        subscription.setUser(user);
        subscription.setParty(party);
        subscription.setMonthlyFee(monthlyFee);
        subscription.setTotalAmount(totalAmount);
        subscription.setPeriodMonths(periodMonths);
        subscription.setStartDate(startDate);
        subscription.setEndDate(endDate);
        subscription.setStatus("ACTIVE");
        subscription.setSerialCode(createSerialCode());

        subscriptionRepository.save(subscription);

        int occupiedSlots = party.getOccupiedSlots() == null ? 0 : party.getOccupiedSlots();
        int totalSlots = party.getTotalSlots() == null ? 4 : party.getTotalSlots();

        party.setOccupiedSlots(occupiedSlots + 1);

        if (party.getOccupiedSlots() >= totalSlots) {
            party.setStatus("FULL");
        }

        partyPostRepository.save(party);
    }

    @Transactional(readOnly = true)
    public List<SubscriptionResponse> getMySubscriptions(Long userId) {
        if (userId == null) {
            return new ArrayList<>();
        }

        return subscriptionRepository.findByUserUserId(userId)
                .stream()
                .map(this::toResponse)
                .collect(Collectors.toList());
    }

    @Transactional
    public void cancelSubscription(Long subscriptionId) {
        Subscription subscription = subscriptionRepository.findById(subscriptionId)
                .orElseThrow(() -> new RuntimeException("구독 정보를 찾을 수 없습니다."));

        if ("CANCELLED".equals(subscription.getStatus())) {
            throw new RuntimeException("이미 해지된 구독입니다.");
        }

        subscription.setStatus("CANCELLED");
    }

    @Transactional(readOnly = true)
    public List<SubscriptionResponse> getTop3Subscriptions(Long userId) {
        List<SubscriptionResponse> allSubs = getMySubscriptions(userId);

        if (allSubs == null || allSubs.isEmpty()) {
            return new ArrayList<>();
        }

        return allSubs.stream()
                .sorted((a, b) -> b.getId().compareTo(a.getId()))
                .limit(3)
                .collect(Collectors.toList());
    }

    private void validateCreateRequest(SubscriptionCreateRequest request) {
        if (request == null) {
            throw new RuntimeException("결제 요청 정보가 없습니다.");
        }

        if (request.getPartyId() == null) {
            throw new RuntimeException("판매글 정보가 없습니다.");
        }

        if (request.getMonthlyFee() == null || request.getMonthlyFee() <= 0) {
            throw new RuntimeException("결제 금액 정보가 올바르지 않습니다.");
        }

        if (request.getPeriodMonths() == null || request.getPeriodMonths() <= 0) {
            throw new RuntimeException("구독 기간 정보가 올바르지 않습니다.");
        }
    }

    private Account resolvePaymentAccount(User user, Long accountId) {
        if (accountId != null) {
            return accountRepository.findByIdAndUser(accountId, user)
                    .orElseThrow(() -> new RuntimeException("결제 계좌 정보를 찾을 수 없습니다."));
        }

        return accountRepository.findByUserAndIsPrimary(user, "Y")
                .orElseGet(() -> {
                    List<Account> accounts = accountRepository.findByUserOrderByIsPrimaryDescCreatedAtDesc(user);

                    if (accounts == null || accounts.isEmpty()) {
                        throw new RuntimeException("마이페이지에서 결제 계좌를 먼저 등록해 주세요.");
                    }

                    return accounts.get(0);
                });
    }

    private void validatePartyAvailable(PartyPost party) {
        if (party == null) {
            throw new RuntimeException("판매글 정보를 찾을 수 없습니다.");
        }

        if ("REJECTED".equals(party.getStatus())) {
            throw new RuntimeException("승인되지 않은 판매글입니다.");
        }

        if ("FULL".equals(party.getStatus())) {
            throw new RuntimeException("이미 모집이 완료된 구독입니다.");
        }

        int occupiedSlots = party.getOccupiedSlots() == null ? 0 : party.getOccupiedSlots();
        int totalSlots = party.getTotalSlots() == null ? 4 : party.getTotalSlots();

        if (occupiedSlots >= totalSlots) {
            throw new RuntimeException("이미 모집이 완료된 구독입니다.");
        }
    }

    private String createSerialCode() {
        return "SUB-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }

    private SubscriptionResponse toResponse(Subscription subscription) {
        SubscriptionResponse res = new SubscriptionResponse();

        res.setId(subscription.getId());

        if (subscription.getParty() != null) {
            res.setPartyId(subscription.getParty().getId());

            if (subscription.getParty().getService() != null) {
                res.setServiceName(subscription.getParty().getService().getServiceName());
            }

            res.setSharedId(subscription.getParty().getShareId());
            res.setSharedPwd(subscription.getParty().getSharePassword());
        }

        res.setMonthlyFee((int) subscription.getMonthlyFee());
        res.setTotalAmount((int) subscription.getTotalAmount());
        res.setPeriodMonths(subscription.getPeriodMonths());
        res.setStartDate(subscription.getStartDate());
        res.setEndDate(subscription.getEndDate());
        res.setNextPayDate(null);
        res.setStatus(subscription.getStatus());
        res.setSerialCode(subscription.getSerialCode());

        return res;
    }
}