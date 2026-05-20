package com.bu.jichulmate.service;

import com.bu.jichulmate.domain.Attachment;
import com.bu.jichulmate.domain.Board;
import com.bu.jichulmate.repository.CommunityBoardRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class CommunityService {

    private static final String ATTACH_REF_TABLE = "BOARDS";

    private static final String CATEGORY_FREE = "FREE";
    private static final String CATEGORY_SECRET = "SECRET";
    private static final String CATEGORY_TEENS = "TEENS";
    private static final String CATEGORY_TWENTIES = "TWENTIES";
    private static final String CATEGORY_THIRTIES = "THIRTIES";
    private static final String CATEGORY_FORTIES = "FORTIES";
    private static final String CATEGORY_FIFTIES = "FIFTIES";

    private static final Set<String> COMMUNITY_CATEGORIES = Set.of(
            CATEGORY_FREE,
            CATEGORY_SECRET,
            CATEGORY_TEENS,
            CATEGORY_TWENTIES,
            CATEGORY_THIRTIES,
            CATEGORY_FORTIES,
            CATEGORY_FIFTIES
    );

    private final CommunityBoardRepository communityBoardRepository;
    private final FileService fileService;

    @Transactional(readOnly = true)
    public Page<Board> findCommunityPosts(
            String category,
            String keyword,
            String sort,
            Pageable pageable
    ) {
        String normalizedCategory = normalizeCategory(category);
        String normalizedSort = sort == null ? "latest" : sort.trim().toLowerCase();

        if ("popular".equals(normalizedSort)) {
            return communityBoardRepository.findCategoryPopular(normalizedCategory, keyword, pageable);
        }

        return communityBoardRepository.findCategoryLatest(normalizedCategory, keyword, pageable);
    }

    @Transactional(readOnly = true)
    public Page<Board> findMyCommunityPosts(Long userId, Pageable pageable) {
        return communityBoardRepository.findMyCommunityPosts(userId, COMMUNITY_CATEGORIES, pageable);
    }

    @Transactional(readOnly = true)
    public Board findCommunityPost(Long boardId) {
        Board board = communityBoardRepository.findCommunityPost(boardId, COMMUNITY_CATEGORIES);

        if (board == null) {
            throw new IllegalArgumentException("게시글을 찾을 수 없습니다.");
        }

        return board;
    }

    @Transactional(readOnly = true)
    public List<Attachment> findAttachments(Long boardId) {
        return fileService.findFiles(ATTACH_REF_TABLE, boardId);
    }

    @Transactional
    public void increaseViewCount(Long boardId) {
        communityBoardRepository.increaseViewCount(boardId, COMMUNITY_CATEGORIES);
    }

    @Transactional
    public Board createPost(
            Long userId,
            String category,
            String title,
            String content,
            MultipartFile[] photos
    ) throws Exception {
        String normalizedCategory = normalizeCategory(category);

        validate(title, content);

        Board board = Board.builder()
                .userId(userId)
                .boardType(normalizedCategory)
                .title(title.trim())
                .content(content.trim())
                .viewsCount(0L)
                .likesCount(0L)
                .isDeleted("N")
                .build();

        Board savedBoard = communityBoardRepository.save(board);

        fileService.uploadFiles(photos, ATTACH_REF_TABLE, savedBoard.getBoardId());

        return savedBoard;
    }

    @Transactional
    public Board updatePost(
            Long boardId,
            Long loginUserId,
            String category,
            String title,
            String content,
            MultipartFile[] photos
    ) throws Exception {
        validate(title, content);

        Board board = findCommunityPost(boardId);

        if (!board.isOwner(loginUserId)) {
            throw new IllegalStateException("수정 권한이 없습니다.");
        }

        if (category != null && !category.trim().isEmpty()) {
            board.setBoardType(normalizeCategory(category));
        }

        board.setTitle(title.trim());
        board.setContent(content.trim());

        Board updatedBoard = communityBoardRepository.save(board);

        fileService.uploadFiles(photos, ATTACH_REF_TABLE, updatedBoard.getBoardId());

        return updatedBoard;
    }

    @Transactional
    public void deletePost(Long boardId, Long loginUserId) {
        Board board = findCommunityPost(boardId);

        if (!board.isOwner(loginUserId)) {
            throw new IllegalStateException("삭제 권한이 없습니다.");
        }

        board.setIsDeleted("Y");
        communityBoardRepository.save(board);

        fileService.deleteFilesWithPhysicalFile(ATTACH_REF_TABLE, boardId);
    }

    public String normalizeCategory(String category) {
        if (category == null || category.trim().isEmpty()) {
            return CATEGORY_FREE;
        }

        String normalized = category.trim().toUpperCase();

        if (!COMMUNITY_CATEGORIES.contains(normalized)) {
            return CATEGORY_FREE;
        }

        return normalized;
    }

    public String getCategoryLabel(String category) {
        String normalized = normalizeCategory(category);

        return switch (normalized) {
            case CATEGORY_SECRET -> "비밀";
            case CATEGORY_TEENS -> "10대";
            case CATEGORY_TWENTIES -> "20대";
            case CATEGORY_THIRTIES -> "30대";
            case CATEGORY_FORTIES -> "40대";
            case CATEGORY_FIFTIES -> "50대 이상";
            default -> "자유";
        };
    }

    public boolean isSecretCategory(String category) {
        return CATEGORY_SECRET.equals(normalizeCategory(category));
    }

    private void validate(String title, String content) {
        if (title == null || title.trim().isEmpty()) {
            throw new IllegalArgumentException("제목을 입력해 주세요.");
        }

        if (title.trim().length() > 150) {
            throw new IllegalArgumentException("제목은 150자 이하로 입력해 주세요.");
        }

        if (content == null || content.trim().isEmpty()) {
            throw new IllegalArgumentException("내용을 입력해 주세요.");
        }

        if (content.trim().length() > 4000) {
            throw new IllegalArgumentException("내용은 4000자 이하로 입력해 주세요.");
        }
    }
}