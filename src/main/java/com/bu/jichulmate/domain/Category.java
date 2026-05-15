package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "CATEGORIES")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor @Builder
public class Category {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_categories_gen")
    @SequenceGenerator(name = "seq_categories_gen", sequenceName = "SEQ_CATEGORIES", allocationSize = 1)
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