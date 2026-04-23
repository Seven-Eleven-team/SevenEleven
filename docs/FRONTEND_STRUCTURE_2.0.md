src/main/webapp/WEB-INF/views
│
├── 📄 index.jsp                                (메인 페이지 / 서비스 첫 화면)
│
├── 📂 common                                   (공통 화면 조각)
│   ├── 📂 layout
│   │   ├── 📄 header.jspf                     (공통 헤더 / 로고 / 네비게이션)
│   │   ├── 📄 footer.jspf                     (공통 푸터)
│   │   └── 📄 sidebar.jspf                    (공통 사이드바, 필요 화면에서 include)
│   │
│   ├── 📂 include
│   │   ├── 📄 head.jspf                       (공통 meta / css 링크 / favicon)
│   │   ├── 📄 scripts.jspf                    (공통 js 로드)
│   │   └── 📄 flash-message.jspf              (서버 메시지 / 알림 출력)
│   │
│   ├── 📂 modal
│   │   ├── 📄 authModal.jspf                  (로그인/회원가입 모달 프레임)
│   │   ├── 📄 loginModal.jspf                 (로그인 입력 모달)
│   │   ├── 📄 signupModal.jspf                (회원가입 입력 모달)
│   │   ├── 📄 findPasswordModal.jspf          (비밀번호 찾기 모달)
│   │   └── 📄 loginRequiredModal.jspf         (로그인 필요 안내 모달)
│   │
│   └── 📂 error
│       ├── 📄 404.jsp                         (페이지 없음)
│       ├── 📄 500.jsp                         (서버 오류)
│       └── 📄 access-denied.jsp               (권한 없음)
│
├── 📂 auth                                     (인증 관련 페이지)
│   ├── 📄 login.jsp                             (로그인 페이지)
│   ├── 📄 register.jsp                          (회원가입 페이지)
│   ├── 📄 find-password.jsp                   (비밀번호 찾기 페이지)
│   ├── 📄 reset-password.jsp                  (비밀번호 재설정 페이지)
│   └── 📄 reset-password-invalid.jsp          (유효하지 않은 토큰 안내)
│
├── 📂 expense                                  (지출 관리 화면)
│   ├── 📄 list.jsp                            (지출 목록 / 월별 조회)
│   ├── 📄 form.jsp                            (지출 등록 / 수정 폼)
│   └── 📄 detail.jsp                          (지출 상세)
│
├── 📂 dashboard                                (통계 / 대시보드)
│   └── 📄 dashboard.jsp                       (카테고리 비율 / 월별 변화 / 요약 카드)
│
├── 📂 ai                                       (AI 금융멘토 화면 - 요구사항 D 반영)
│   └── 📄 mentor.jsp                          (AI 멘토링 / 소비 분석 및 기회비용 화면)
│
├── 📂 goal                                     (절약 목표)
│   ├── 📄 form.jsp                            (목표 등록 / 수정)
│   └── 📄 detail.jsp                          (목표 상세 / 달성률 표시)
│
├── 📂 subscription                             (구독 관리)
│   ├── 📄 list.jsp                            (구독 목록)
│   ├── 📄 form.jsp                            (구독 등록 / 수정)
│   └── 📄 detail.jsp                          (구독 상세 / 해지 URL)
│
├── 📂 party                                    (구독 파티 모집)
│   ├── 📄 list.jsp                            (파티 모집 글 목록)
│   ├── 📄 form.jsp                            (모집 글 작성)
│   └── 📄 detail.jsp                          (모집 글 상세 / 참여)
│
├── 📂 board                                    (일반 게시판)
│   ├── 📄 list.jsp                            (게시글 목록)
│   ├── 📄 write.jsp                           (게시글 작성)
│   ├── 📄 edit.jsp                            (게시글 수정)
│   └── 📄 detail.jsp                          (게시글 상세 / 댓글 / 좋아요)
│
├── 📂 members
│   └── 📂 mypage                              (마이페이지)
│       ├── 📄 mypage.jsp                      (마이페이지 메인)
│       ├── 📄 profile.jsp                     (회원 정보 수정)
│       ├── 📄 security.jsp                    (PIN / 보안 설정)
│       ├── 📄 accounts.jsp                    (계좌 목록)
│       └── 📄 account-form.jsp                (계좌 등록 / 수정)
│
├── 📂 support                                  (고객센터)
│   ├── 📄 support.jsp                         (고객센터 메인 허브)
│   ├── 📄 notice.jsp                          (공지사항 목록)
│   ├── 📄 noticeDetail.jsp                    (공지 상세)
│   ├── 📄 faq.jsp                             (FAQ 목록)
│   ├── 📄 faqDetail.jsp                       (FAQ 상세)
│   ├── 📄 qna.jsp                             (문의 목록)
│   ├── 📄 qnaDetail.jsp                       (문의 상세)
│   ├── 📄 qnaForm.jsp                         (문의 작성)
│   ├── 📄 qnaEdit.jsp                         (문의 수정)
│   └── 📄 _sidebar.jspf                       (고객센터 공통 사이드바)
│
├── 📂 review                                   (리뷰)
│   ├── 📄 myReview.jsp                        (내가 쓴 리뷰 목록)
│   ├── 📄 write.jsp                           (리뷰 작성)
│   └── 📄 edit.jsp                            (리뷰 수정)
│
└── 📂 admin                                    (관리자 화면)
    ├── 📄 admin_index.jsp                     (관리자 대시보드)
    ├── 📄 admin_users.jsp                     (회원 관리)
    ├── 📄 admin_board.jsp                     (게시판 관리)
    ├── 📄 admin_report.jsp                    (신고 관리)
    ├── 📄 admin_service.jsp                   (구독 서비스 마스터 관리)
    ├── 📄 admin_notification.jsp              (알림 발송 / 로그 관리)
    ├── 📄 admin_inquiries.jsp                 (문의 관리)
    ├── 📄 admin_faq.jsp                       (FAQ 관리)
    ├── 📄 admin_terms.jsp                     (약관 관리)
    ├── 📄 admin_audit.jsp                     (활동 로그 조회)
    └── 📄 admin_sidebar.jspf                  (관리자 공통 사이드바)