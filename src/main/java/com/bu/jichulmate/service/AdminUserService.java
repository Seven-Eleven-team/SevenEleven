package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.User;
import com.bu.jichulmate.dto.admin.AdminUserResponse;
import com.bu.jichulmate.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class AdminUserService {

    private final UserRepository userRepository;

    // 1. 전체 회원 목록 조회 (Entity -> DTO 안전 변환)
    @Transactional(readOnly = true)
    public List<AdminUserResponse> getAllUsers() {
        return userRepository.findAll().stream()
                .map(AdminUserResponse::fromEntity)
                .collect(Collectors.toList());
    }

    // 2. 특정 회원 상태 변경 (정지, 활성화 등)
    @Transactional
    public void updateUserStatus(Long userId, String newStatus) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("해당 회원을 찾을 수 없습니다. ID: " + userId));

        // JPA의 더티 체킹(Dirty Checking)으로 save() 없이 상태 즉시 변경
        user.setAccountStatus(newStatus);

        log.info("[AdminUserService] 회원 상태 변경 완료 - 회원 ID: {}, 변경된 상태: {}", userId, newStatus);
    }

    // 3. 특정 회원 단건 조회
    @Transactional(readOnly = true)
    public AdminUserResponse getUserById(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("해당 회원을 찾을 수 없습니다. ID: " + userId));
        return AdminUserResponse.fromEntity(user);
    }
}