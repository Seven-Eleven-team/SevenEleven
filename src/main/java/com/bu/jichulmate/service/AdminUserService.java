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
    private final AdminAuditService adminAuditService; // ★ 로그 서비스 주입 추가

    @Transactional(readOnly = true)
    public List<AdminUserResponse> getAllUsers() {
        return userRepository.findAll().stream()
                .map(AdminUserResponse::fromEntity)
                .collect(Collectors.toList());
    }

    // ★ 관리자(admin)와 접속 IP(ipAddress) 파라미터 추가
    @Transactional
    public void updateUserStatus(Long userId, String newStatus, User admin, String ipAddress) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("해당 회원을 찾을 수 없습니다. ID: " + userId));

        user.setAccountStatus(newStatus);
        log.info("[AdminUserService] 회원 상태 변경 완료 - 회원 ID: {}, 변경된 상태: {}", userId, newStatus);

        // ★ 비즈니스 로직(상태 변경)이 성공적으로 끝나면 로그 기록
        if (admin != null) {
            adminAuditService.recordLog(admin, "USER_STATUS_UPDATE", "USERS", userId, ipAddress);
        } else {
            log.warn("관리자 정보가 없어 로그를 남길 수 없습니다.");
        }
    }

    @Transactional(readOnly = true)
    public AdminUserResponse getUserById(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("해당 회원을 찾을 수 없습니다. ID: " + userId));
        return AdminUserResponse.fromEntity(user);
    }
}