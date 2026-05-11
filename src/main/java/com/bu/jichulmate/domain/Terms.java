package com.bu.jichulmate.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Lob;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Table(name = "TERMS")
public class Terms {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "termsSeq")
    @SequenceGenerator(
            name = "termsSeq",
            sequenceName = "SEQ_TERMS",
            allocationSize = 1
    )
    @Column(name = "TERM_ID")
    private Long termId;

    @Enumerated(EnumType.STRING)
    @Column(name = "TERM_TYPE", nullable = false, length = 50)
    private TermsType termType;

    @Column(name = "VERSION", nullable = false, length = 20)
    private String version;

    @Lob
    @Column(name = "CONTENT", nullable = false)
    private String content;

    @Column(name = "IS_REQUIRED", nullable = false, length = 1)
    private String isRequired = "Y";

    @Column(name = "APPLY_DATE", nullable = false)
    private LocalDateTime applyDate;

    @Column(name = "CREATED_AT", insertable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "UPDATED_AT")
    private LocalDateTime updatedAt;

    @PrePersist
    public void prePersist() {
        if (applyDate == null) {
            applyDate = LocalDateTime.now();
        }

        if (isRequired == null || isRequired.isBlank()) {
            isRequired = termType != null && termType.isRequiredByDefault() ? "Y" : "N";
        }
    }

    @PreUpdate
    public void preUpdate() {
        updatedAt = LocalDateTime.now();
    }

    public boolean required() {
        return "Y".equalsIgnoreCase(isRequired);
    }
}
