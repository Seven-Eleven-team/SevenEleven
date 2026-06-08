package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.User;
import com.bu.jichulmate.dto.user.UserUpdateRequest;
import com.bu.jichulmate.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Transactional
    public User updateProfile(Long userId, UserUpdateRequest request) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("해당 사용자를 찾을 수 없습니다."));

        if (!passwordEncoder.matches(request.getCurrentPassword(), user.getPassword())) {
            throw new IllegalArgumentException("현재 비밀번호가 일치하지 않습니다.");
        }

        if (request.getNewEmail() != null && !request.getNewEmail().isBlank()) {
            if (userRepository.existsByLoginIdAndUserIdNot(request.getNewEmail(), userId)) {
                throw new IllegalArgumentException("이미 사용 중인 이메일 주소입니다.");
            }
            user.setLoginId(request.getNewEmail());
        }

        if (request.getNickname() != null && !request.getNickname().isBlank()) {
            if (userRepository.existsByNicknameAndUserIdNot(request.getNickname(), userId)) {
                throw new IllegalArgumentException("이미 사용 중인 닉네임입니다.");
            }
            user.setNickname(request.getNickname());
        }

        if (request.getNewPassword() != null && !request.getNewPassword().isBlank()) {
            if (!request.getNewPassword().equals(request.getConfirmPassword())) {
                throw new IllegalArgumentException("새 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
            }
            user.setPassword(passwordEncoder.encode(request.getNewPassword()));
        }

        if (request.getMentorTone() != null && !request.getMentorTone().isBlank()) {
            user.setMentorTone(request.getMentorTone());
        }

        return userRepository.save(user);
    }

    // ★ 회원 탈퇴 (Soft Delete) 메서드 추가
    @Transactional
    public void withdrawUser(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("해당 사용자를 찾을 수 없습니다."));

        // DB에서 즉시 삭제하지 않고, 기획(30일 보관)에 맞춰 상태만 변경합니다.
        user.setAccountStatus("WITHDRAWN");
    }
}
