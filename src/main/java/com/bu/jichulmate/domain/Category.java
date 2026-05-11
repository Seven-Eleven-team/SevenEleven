package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "CATEGORIES")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Category {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "cat_seq")
    @SequenceGenerator(name = "cat_seq", sequenceName = "SEQ_CATEGORIES", allocationSize = 1)
    @Column(name = "CATEGORY_ID")
    private Long id;


    @Column(name = "NAME", nullable = false, length = 50)
    private String name;

    @Column(name = "IS_ACTIVE", nullable = false, length = 1)
    private String isActive = "Y";

    @Builder
    public Category(String name, String isActive) {
        this.name = name;
        this.isActive = isActive;
    }
}