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
import com.bu.jichulmate.domain.Attachment;
import com.bu.jichulmate.service.FileService;

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
    private final FileService fileService;

    public PartySellerService(PartySellerRepository partySellerRepository,
                              UserRepository userRepository,
                              SubscriptionRepository subscriptionRepository,
                              PartyPostRepository partyPostRepository,
                              PasswordEncoder passwordEncoder,
                              FileService fileService) {
        this.partySellerRepository = partySellerRepository;
        this.userRepository = userRepository;
        this.subscriptionRepository = subscriptionRepository;
        this.partyPostRepository = partyPostRepository;
        this.passwordEncoder = passwordEncoder;
        this.fileService = fileService;
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
        List<PartySeller> sellers = partySellerRepository.findByUserId(userId);
        if (sellers.isEmpty()) {
            throw new RuntimeException("판매자를 찾을 수 없습니다.");
        }
        return new SellerResponse(sellers.get(0));
    }

    public List<SellerResponse> getAllSellers() {
        return partySellerRepository.findAll()
                .stream()
                .map(SellerResponse::new)
                .toList();
    }

    public boolean verifyPassword(Long userId, String rawPassword) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("사용자를 찾을 수 없습니다."));
        return passwordEncoder.matches(rawPassword, user.getPassword());
    }

    public Map<String, Object> getSellerProfile(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("사용자를 찾을 수 없습니다."));

        String profileImageUrl = null;

        List<Attachment> attachments = fileService.findFiles("USERS", userId);

        if (attachments != null && !attachments.isEmpty()) {
            profileImageUrl = attachments.get(attachments.size() - 1).getFilePath();
        }

        List<Map<String, Object>> usedOttList = subscriptionRepository.findByUserUserId(userId)
                .stream()
                .map(sub -> {
                    Map<String, Object> map = new HashMap<>();
                    map.put("serviceId", sub.getParty().getService().getId());
                    map.put("serviceName", sub.getParty().getService().getServiceName());
                    map.put("iconUrl", sub.getParty().getService().getIconUrl());
                    return map;
                })
                .toList();

        List<Map<String, Object>> soldOttList = partyPostRepository.findBySellerUserId(userId)
                .stream()
                .filter(post -> !"CANCELED".equalsIgnoreCase(post.getStatus()))
                .map(post -> {
                    Map<String, Object> map = new HashMap<>();
                    map.put("serviceId", post.getService().getId());
                    map.put("serviceName", post.getService().getServiceName());
                    map.put("iconUrl", post.getService().getIconUrl());
                    return map;
                })
                .toList();

        Map<String, Object> result = new HashMap<>();
        result.put("nickname", user.getNickname());
        result.put("profileImageUrl", profileImageUrl);
        result.put("usedOttList", usedOttList);
        result.put("soldOttList", soldOttList);

        return result;
    }
}