package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.Board;
import com.bu.jichulmate.repository.BoardRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class BoardService {

    private final BoardRepository boardRepository;

    /**
     * 내 게시글 목록 조회 (페이징 처리)
     * @param userId 로그인한 사용자 ID
     * @param page 요청 페이지 번호 (0부터 시작)
     */
    public Page<Board> getMyPosts(Long userId, int page) {
        // 한 페이지에 10개씩 조회
        Pageable pageable = PageRequest.of(page, 10);
        // Repository의 findByUserIdOrderByCreatedAtDesc 메서드 호출
        return boardRepository.findByUserIdOrderByCreatedAtDesc(userId, pageable);
    }

    /**
     * 게시글 삭제
     * @param boardId 삭제할 게시글 ID
     * @param loginUserId 삭제를 요청한 사용자의 ID
     */
    @Transactional
    public void deleteBoard(Long boardId, Long loginUserId) {
        Board board = boardRepository.findById(boardId)
                .orElseThrow(() -> new RuntimeException("삭제할 게시글을 찾을 수 없습니다."));

        // Board 엔티티에 구현된 isOwner 메서드를 사용하여 권한 확인
        if (!board.isOwner(loginUserId)) {
            throw new RuntimeException("해당 게시글의 삭제 권한이 없습니다.");
        }

        boardRepository.delete(board);
    }
}
