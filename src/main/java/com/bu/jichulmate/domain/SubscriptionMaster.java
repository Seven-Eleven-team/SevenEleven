package com.bu.jichulmate.domain;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "SUBSCRIPTION_MASTER")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class SubscriptionMaster {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_sub_master_gen")
    @SequenceGenerator(name = "seq_sub_master_gen", sequenceName = "SEQ_SUBSCRIPTION_MASTER", allocationSize = 1)
    @Column(name = "SERVICE_ID")
    private Long id;

    @Column(name = "SERVICE_CATEGORY", nullable = false, length = 50)
    private String serviceCategory; // OTT, AI 등

    @Column(name = "SERVICE_NAME", nullable = false, length = 100)
    private String serviceName; // 넷플릭스, 유튜브 등

    @Column(name = "ICON_URL", length = 500)
    private String iconUrl;

    @Column(name = "LOGIN_URL", nullable = false, length = 500)
    private String loginUrl;

    @Column(name = "CANCEL_PATH", nullable = false, length = 500)
    private String cancelPath;
}