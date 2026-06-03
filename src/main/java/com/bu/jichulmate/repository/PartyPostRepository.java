package com.bu.jichulmate.repository;

import com.bu.jichulmate.domain.PartyPost;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface PartyPostRepository extends JpaRepository<PartyPost, Long> {

    List<PartyPost> findBySellerUserId(Long userId);

    @Query(value = "SELECT SEQ_PARTY_POSTS.NEXTVAL FROM DUAL", nativeQuery = true)
    Long getNextSequenceValue();

    @Modifying
    @Query(value = """
        INSERT INTO PARTY_POSTS (
            PARTY_ID, SELLER_ID, SERVICE_ID, SHARE_ID, SHARE_PASSWORD,
            MONTHLY_PRICE, TOTAL_SLOTS, OCCUPIED_SLOTS, STATUS,
            CREATED_AT, DESCRIPTION
        ) VALUES (
            :partyId, :sellerId, :serviceId, :shareId, :sharePassword,
            :monthlyPrice, 4, 0, 'WAITING',
            :createdAt, :description
        )
    """, nativeQuery = true)
    void insertDirect(
            @Param("partyId") Long partyId,
            @Param("sellerId") Long sellerId,
            @Param("serviceId") Long serviceId,
            @Param("shareId") String shareId,
            @Param("sharePassword") String sharePassword,
            @Param("monthlyPrice") Integer monthlyPrice,
            @Param("createdAt") LocalDateTime createdAt,
            @Param("description") String description
    );
}