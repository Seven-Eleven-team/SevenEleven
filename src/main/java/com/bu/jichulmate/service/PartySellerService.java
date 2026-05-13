package com.bu.jichulmate.service;

import com.bu.jichulmate.dto.party.SellerRequest;
import com.bu.jichulmate.dto.party.SellerResponse;
import com.bu.jichulmate.domain.PartySeller;
import com.bu.jichulmate.repository.PartySellerRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PartySellerService {

    private final PartySellerRepository partySellerRepository;

    public PartySellerService(PartySellerRepository partySellerRepository) {
        this.partySellerRepository = partySellerRepository;
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
}