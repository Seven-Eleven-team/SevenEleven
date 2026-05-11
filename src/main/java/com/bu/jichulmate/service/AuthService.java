package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.User;
import com.bu.jichulmate.dto.auth.SignupRequest;
import com.bu.jichulmate.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public User register(SignupRequest request) {
        String email = trim(request.getMEmail());
        String nickname = trim(request.getMNickname());
        String password = trim(request.getMPw());
        String gender = trim(request.getMGender());

        if (email == null || email.isEmpty()) {
            throw new IllegalArgumentException("이메일을 입력해 주세요.");
        }

        if (nickname == null || nickname.isEmpty()) {
            throw new IllegalArgumentException("닉네임을 입력해 주세요.");
        }

        if (password == null || password.isEmpty()) {
            throw new IllegalArgumentException("비밀번호를 입력해 주세요.");
        }

        if (gender == null || gender.isEmpty()) {
            throw new IllegalArgumentException("성별을 선택해 주세요.");
        }

        if (request.getMBirthDate() == null) {
            throw new IllegalArgumentException("생년월일을 입력해 주세요.");
        }

        if (userRepository.existsByLoginId(email)) {
            throw new IllegalArgumentException("이미 사용 중인 이메일입니다.");
        }

        if (userRepository.existsByNickname(nickname)) {
            throw new IllegalArgumentException("이미 사용 중인 닉네임입니다.");
        }

        User user = new User();
        user.setLoginId(email);
        user.setNickname(nickname);
        user.setPassword(passwordEncoder.encode(password));
        user.setGender(gender);
        user.setBirthDate(request.getMBirthDate());
        user.setRole("USER");
        user.setMentorTone("MILD");

        return userRepository.save(user);
    }

    public Optional<User> login(String loginId, String rawPassword) {
        return userRepository.findByLoginId(loginId)
                .filter(user -> passwordEncoder.matches(rawPassword, user.getPassword()));
    }

    public boolean existsByLoginId(String loginId) {
        return userRepository.existsByLoginId(loginId);
    }

    public boolean existsByEmail(String email) {
        return userRepository.existsByLoginId(email);
    }

    public boolean existsByNickname(String nickname) {
        return userRepository.existsByNickname(nickname);
    }

    private String trim(String value) {
        return value == null ? null : value.trim();
    }
}