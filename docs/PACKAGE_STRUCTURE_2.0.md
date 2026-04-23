src/main/java/com/bu.jichulmate
│
├── 📄 JichulmateApplication.java                  (스프링 부트 실행 파일)
│
├── 📂 config                                      (설정)
│   ├── 📄 WebConfig.java                         (JSP 뷰 리졸버 / 정적 리소스 / 인터셉터 등록)
│   ├── 📄 SecurityConfig.java                    (인증 정책 / 세션 / 권한 처리)
│   ├── 📄 MailConfig.java                        (메일 발송 환경 설정)
│   ├── 📄 OracleConfig.java                      (Oracle DB 관련 설정)
│   ├── 📄 LoginCheckInterceptor.java             (로그인 필요한 URL 접근 제어)
│   └── 📄 AdminCheckInterceptor.java             (관리자 URL 접근 제어)
│
├── 📂 controller                                  (컨트롤러)
│   ├── 📄 HomeController.java                    (메인 페이지 `/` 진입)
│   ├── 📄 AuthController.java                    (로그인 / 회원가입 / 비밀번호 찾기 페이지 라우팅)
│   ├── 📄 AuthApiController.java                 (비동기 로그인 / 인증 / 비밀번호 재설정 API)
│   ├── 📄 UserController.java                    (회원 정보 조회 / 수정 / 탈퇴 처리)
│   ├── 📄 ExpenseController.java                 (지출 등록 / 조회 / 수정 / 삭제)
│   ├── 📄 DashboardController.java               (카테고리 비율 / 월별 지출 변화 / 요약 카드)
│   ├── 📄 GoalController.java                    (절약 목표 등록 / 수정 / 상세)
│   ├── 📄 SubscriptionController.java            (구독 등록 / 목록 / 삭제 / 상세)
│   ├── 📄 PartyController.java                   (구독 파티 모집 게시판)
│   ├── 📄 BoardController.java                   (일반 게시판 / 댓글 / 좋아요)
│   ├── 📄 MyPageController.java                  (마이페이지 / 보안 / 계좌 관리)
│   ├── 📄 SupportController.java                 (고객센터 / 문의 / FAQ / 공지)
│   ├── 📄 ReviewController.java                  (리뷰 작성 / 목록 / 수정)
│   ├── 📄 NotificationController.java            (알림 발송 / 알림 내역 조회)
│   ├── 📄 AdminController.java                   (관리자 대시보드 / 회원 / 게시판 / 신고 / 문의 관리)
│   └── 📄 AiMentorController.java                (AI 소비 분석 / 피드백 / 기회비용 결과 제공)
│
├── 📂 dto                                         (DTO)
│   ├── 📂 auth
│   │   ├── 📄 LoginRequest.java                  (로그인 입력값)
│   │   ├── 📄 SignupRequest.java                 (회원가입 입력값)
│   │   ├── 📄 FindPasswordRequest.java           (비밀번호 찾기 입력값)
│   │   └── 📄 ResetPasswordRequest.java          (비밀번호 재설정 입력값)
│   │
│   ├── 📂 user
│   │   ├── 📄 UserUpdateRequest.java             (회원 정보 수정 입력값)
│   │   ├── 📄 UserProfileResponse.java           (회원 프로필 응답값)
│   │   └── 📄 UserSummaryResponse.java           (회원 요약 정보 응답값)
│   │
│   ├── 📂 expense
│   │   ├── 📄 ExpenseCreateRequest.java          (지출 등록 입력값)
│   │   ├── 📄 ExpenseUpdateRequest.java          (지출 수정 입력값)
│   │   ├── 📄 ExpenseSearchCondition.java        (월별/조건별 검색값)
│   │   └── 📄 ExpenseResponse.java               (지출 목록/상세 응답값)
│   │
│   ├── 📂 dashboard
│   │   ├── 📄 DashboardResponse.java             (대시보드 통합 응답)
│   │   ├── 📄 CategoryRatioResponse.java         (카테고리별 비율 응답)
│   │   ├── 📄 MonthlyExpenseStatResponse.java    (월별 지출 변화 응답)
│   │   └── 📄 GoalAchievementResponse.java       (목표 달성률 응답)
│   │
│   ├── 📂 goal
│   │   ├── 📄 GoalCreateRequest.java             (목표 등록 입력값)
│   │   ├── 📄 GoalUpdateRequest.java             (목표 수정 입력값)
│   │   └── 📄 GoalResponse.java                  (목표 응답값)
│   │
│   ├── 📂 subscription
│   │   ├── 📄 SubscriptionCreateRequest.java     (구독 등록 입력값)
│   │   ├── 📄 SubscriptionUpdateRequest.java     (구독 수정 입력값)
│   │   └── 📄 SubscriptionResponse.java          (구독 응답값)
│   │
│   ├── 📂 party
│   │   ├── 📄 PartyPostRequest.java              (파티 모집 글 작성 입력값)
│   │   └── 📄 PartyDetailResponse.java           (파티 상세 응답값)
│   │
│   ├── 📂 board
│   │   ├── 📄 BoardWriteRequest.java             (게시글 작성 입력값)
│   │   ├── 📄 BoardUpdateRequest.java            (게시글 수정 입력값)
│   │   ├── 📄 CommentWriteRequest.java           (댓글 작성 입력값)
│   │   └── 📄 BoardDetailResponse.java           (게시글 상세 응답값)
│   │
│   ├── 📂 mypage
│   │   ├── 📄 MyPageSummaryResponse.java         (마이페이지 요약 응답)
│   │   ├── 📄 PinUpdateRequest.java              (보안 PIN 변경 입력값)
│   │   ├── 📄 AccountRegisterRequest.java        (계좌 등록 입력값)
│   │   └── 📄 AccountUpdateRequest.java          (계좌 수정 입력값)
│   │
│   ├── 📂 support
│   │   ├── 📄 InquiryCreateRequest.java          (문의 등록 입력값)
│   │   ├── 📄 InquiryUpdateRequest.java          (문의 수정 입력값)
│   │   ├── 📄 InquiryResponse.java               (문의 응답값)
│   │   └── 📄 FaqResponse.java                   (FAQ 응답값)
│   │
│   ├── 📂 review
│   │   ├── 📄 ReviewWriteRequest.java            (리뷰 작성 입력값)
│   │   └── 📄 ReviewResponse.java                (리뷰 응답값)
│   │
│   ├── 📂 notification
│   │   ├── 📄 NotificationSendRequest.java       (알림 발송 입력값)
│   │   └── 📄 NotificationLogResponse.java       (알림 로그 응답값)
│   │
│   ├── 📂 admin
│   │   ├── 📄 UserStatusUpdateRequest.java       (회원 상태 변경 입력값)
│   │   ├── 📄 ReportProcessRequest.java          (신고 처리 입력값)
│   │   ├── 📄 TermsRequest.java                  (약관 관리 입력값 - 추가됨)
│   │   └── 📄 AdminDashboardResponse.java        (관리자 대시보드 응답값)
│   │
│   └── 📂 ai
│       ├── 📄 ConsumptionAnalysisResponse.java   (소비 분석 응답값)
│       ├── 📄 FeedbackResponse.java              (멘토 피드백 응답값)
│       └── 📄 OpportunityCostResponse.java       (기회비용 응답값)
│
├── 📂 service                                     (서비스)
│   ├── 📄 AuthService.java                       (로그인 / 회원가입 / 세션 처리)
│   ├── 📄 CustomOAuth2UserService.java           (소셜 로그인 인증 처리)
│   ├── 📄 PasswordResetService.java              (토큰 발급 / 비밀번호 재설정)
│   ├── 📄 MailService.java                       (비밀번호 재설정 / 알림 메일 발송)
│   ├── 📄 UserService.java                       (회원 정보 수정 / 탈퇴 / 조회)
│   ├── 📄 ExpenseService.java                    (지출 CRUD 처리)
│   ├── 📄 DashboardService.java                  (지출 통계 / 차트 데이터 계산)
│   ├── 📄 GoalService.java                       (절약 목표 관리)
│   ├── 📄 SubscriptionService.java               (구독 관리 / 해지 URL 처리)
│   ├── 📄 PartyService.java                      (파티 모집 / 참여 처리)
│   ├── 📄 BoardService.java                      (게시글 CRUD 처리)
│   ├── 📄 CommentService.java                    (댓글 처리)
│   ├── 📄 MyPageService.java                     (마이페이지 정보 집계)
│   ├── 📄 AccountService.java                    (계좌 등록 / 수정 / 대표계좌 설정)
│   ├── 📄 SupportService.java                    (문의 / FAQ / 공지 처리)
│   ├── 📄 ReviewService.java                     (리뷰 작성 / 수정 / 조회)
│   ├── 📄 NotificationService.java               (알림 발송 / 발송 로그 기록)
│   ├── 📄 AdminService.java                      (관리자 공통 기능 총괄)
│   ├── 📄 AdminUserService.java                  (회원 관리 전용)
│   ├── 📄 AdminBoardService.java                 (게시글 / 댓글 관리 전용)
│   ├── 📄 AdminSupportService.java               (문의 / FAQ / 공지 관리 전용)
│   ├── 📄 AdminNotificationService.java          (알림 관리 전용)
│   ├── 📄 AdminTermsService.java                 (약관 관리 전용 - 추가됨)
│   └── 📄 AiMentorService.java                   (AI 소비 분석 / 피드백 생성)
│
├── 📂 repository                                  (Repository)
│   ├── 📄 UserRepository.java                    (USERS 테이블 접근)
│   ├── 📄 PasswordResetTokenRepository.java      (재설정 토큰 접근)
│   ├── 📄 ExpenseRepository.java                 (EXPENSES 테이블 접근)
│   ├── 📄 CategoryRepository.java                (CATEGORIES 테이블 접근)
│   ├── 📄 GoalRepository.java                    (SAVING_GOALS 테이블 접근)
│   ├── 📄 SubscriptionRepository.java            (SUBSCRIPTIONS 테이블 접근)
│   ├── 📄 PartyRepository.java                   (파티 모집 데이터 접근)
│   ├── 📄 BoardRepository.java                   (BOARDS 테이블 접근)
│   ├── 📄 CommentRepository.java                 (COMMENTS 테이블 접근)
│   ├── 📄 AccountRepository.java                 (계좌 데이터 접근)
│   ├── 📄 InquiryRepository.java                 (INQUIRIES 테이블 접근)
│   ├── 📄 FaqRepository.java                     (FAQ 데이터 접근)
│   ├── 📄 ReviewRepository.java                  (REVIEWS 테이블 접근)
│   ├── 📄 NotificationLogRepository.java         (NOTIFICATION_LOGS 테이블 접근)
│   ├── 📄 ReportRepository.java                  (REPORTS 테이블 접근)
│   ├── 📄 TermsRepository.java                   (TERMS 테이블 접근 - 추가됨)
│   └── 📄 AdminAuditLogRepository.java           (관리자 활동 로그 접근)
│
├── 📂 domain                                      (엔티티 / 도메인)
│   ├── 📄 User.java                              (회원 엔티티)
│   ├── 📄 PasswordResetToken.java                (재설정 토큰 엔티티)
│   ├── 📄 Expense.java                           (지출 엔티티)
│   ├── 📄 Category.java                          (지출 카테고리 엔티티)
│   ├── 📄 SavingGoal.java                        (절약 목표 엔티티)
│   ├── 📄 Subscription.java                      (구독 엔티티)
│   ├── 📄 PartyPost.java                         (구독 파티 모집 엔티티)
│   ├── 📄 Board.java                             (게시글 엔티티)
│   ├── 📄 Comment.java                           (댓글 엔티티)
│   ├── 📄 Account.java                           (계좌 엔티티)
│   ├── 📄 Inquiry.java                           (문의 엔티티)
│   ├── 📄 Faq.java                               (FAQ 엔티티)
│   ├── 📄 Review.java                            (리뷰 엔티티)
│   ├── 📄 NotificationLog.java                   (알림 발송 로그 엔티티)
│   ├── 📄 Report.java                            (신고 엔티티)
│   ├── 📄 Terms.java                             (약관 엔티티 - 추가됨)
│   └── 📄 AdminAuditLog.java                     (관리자 활동 로그 엔티티)
│
├── 📂 exception                                   (예외 전용)
│   ├── 📄 BusinessException.java                 (비즈니스 예외 기본 클래스)
│   ├── 📄 NotFoundException.java                 (데이터 없음 예외)
│   ├── 📄 UnauthorizedException.java             (권한 없음 예외)
│   ├── 📄 ValidationException.java               (입력값 검증 예외)
│   ├── 📄 DuplicateException.java                (중복 데이터 예외)
│   └── 📄 ErrorCode.java                         (에러 코드 enum / 상수)
│
├── 📂 response                                    (공통 응답)
│   ├── 📄 ApiResponse.java                       (성공 응답 공통 구조)
│   └── 📄 ErrorResponse.java                     (실패 응답 공통 구조)
│
└── 📂 util                                        (공통 유틸)
    ├── 📄 DateTimeUtils.java                     (날짜/시간 처리 유틸)
    ├── 📄 PasswordUtils.java                     (비밀번호 해시 / 검증 보조)
    ├── 📄 SessionUtils.java                      (세션 로그인 사용자 처리)
    └── 📄 ValidationUtils.java                   (입력값 검사 보조)