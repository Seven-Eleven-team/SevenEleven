package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.PartySeller;
import com.bu.jichulmate.domain.User;
import com.bu.jichulmate.dto.party.SellerRequest;
import com.bu.jichulmate.dto.party.SellerResponse;
import com.bu.jichulmate.repository.PartyPostRepository;
import com.bu.jichulmate.repository.PartySellerRepository;
import com.bu.jichulmate.repository.SubscriptionRepository;
import com.bu.jichulmate.repository.UserRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class PartySellerService {

    private final PartySellerRepository partySellerRepository;
    private final UserRepository userRepository;
    private final SubscriptionRepository subscriptionRepository;
    private final PartyPostRepository partyPostRepository;
    private final PasswordEncoder passwordEncoder;

    public PartySellerService(PartySellerRepository partySellerRepository,
                              UserRepository userRepository,
                              SubscriptionRepository subscriptionRepository,
                              PartyPostRepository partyPostRepository,
                              PasswordEncoder passwordEncoder) {
        this.partySellerRepository = partySellerRepository;
        this.userRepository = userRepository;
        this.subscriptionRepository = subscriptionRepository;
        this.partyPostRepository = partyPostRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Transactional
    public SellerResponse registerSeller(SellerRequest request) {
        PartySeller seller = new PartySeller();
        seller.update(request.getUserId(), request.getName(), request.getBirthDate(),
                request.getPhone(), request.getZipCode(), request.getAddress(),
                request.getBankName(), request.getAccountNumber(), request.getHasExperience());
        return new SellerResponse(partySellerRepository.save(seller));
    }

    public SellerResponse getSeller(Long userId) {
        PartySeller seller = partySellerRepository.findByUserId(userId)
                .orElseThrow(() -> new RuntimeException("판매자를 찾을 수 없습니다."));
        return new SellerResponse(seller);
    }

    public List<SellerResponse> getAllSellers() {
        return partySellerRepository.findAll()
                .stream()
                .map(SellerResponse::new)
                .toList();
    }

    // 비밀번호 2차 인증
    public boolean verifyPassword(Long userId, String rawPassword) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("사용자를 찾을 수 없습니다."));
        return passwordEncoder.matches(rawPassword, user.getPassword());
    }

    // 판매자 프로필 조회
    public Map<String, Object> getSellerProfile(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("사용자를 찾을 수 없습니다."));

        // 사용했던 OTT 내역
        List<Map<String, String>> usedOttList = subscriptionRepository.findByUserUserId(userId)
                .stream()
                .map(sub -> {
                    Map<String, String> map = new HashMap<>();
                    map.put("serviceName", sub.getParty().getService().getServiceName());
                    map.put("iconUrl", sub.getParty().getService().getIconUrl());
                    return map;
                })
                .toList();

        // 판매했던 OTT 내역
        List<Map<String, String>> soldOttList = partyPostRepository.findBySellerUserId(userId)
                .stream()
                .map(post -> {
                    Map<String, String> map = new HashMap<>();
                    map.put("serviceName", post.getService().getServiceName());
                    map.put("iconUrl", post.getService().getIconUrl());
                    return map;
                })
                .toList();

        Map<String, Object> result = new HashMap<>();
        result.put("nickname", user.getNickname());
        result.put("usedOttList", usedOttList);
        result.put("soldOttList", soldOttList);
        return result;
    }
}