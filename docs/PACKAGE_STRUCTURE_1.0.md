src/main/java/com/jichulmate
│
├── 📄 JichulmateApplication.java                 (스프링 부트 실행 파일)
│
├── 📂 common                                     (공통 영역)
│   ├── 📂 config                                 (전역 설정)
│   │   ├── 📄 WebConfig.java                    (인터셉터 / 정적 리소스 / JSP 뷰 매핑)
│   │   ├── 📄 SecurityConfig.java               (인증 정책 / 세션 / 권한 정책)
│   │   ├── 📄 MailConfig.java                   (이메일 발송 설정)
│   │   └── 📄 OracleConfig.java                 (Oracle 관련 설정)
│   │
│   ├── 📂 exception                              (공통 예외 처리)
│   │   ├── 📄 BusinessException.java
│   │   ├── 📄 ErrorCode.java
│   │   └── 📄 GlobalExceptionHandler.java
│   │
│   ├── 📂 response                               (공통 응답 구조)
│   │   ├── 📄 ApiResponse.java
│   │   └── 📄 ErrorResponse.java
│   │
│   ├── 📂 util                                   (공통 유틸)
│   │   ├── 📄 DateTimeUtils.java
│   │   ├── 📄 PasswordUtils.java
│   │   ├── 📄 SessionUtils.java
│   │   └── 📄 ValidationUtils.java
│   │
│   └── 📂 interceptor                            (인터셉터)
│       ├── 📄 LoginCheckInterceptor.java
│       └── 📄 AdminCheckInterceptor.java
│
├── 📂 auth                                       (인증)
│   ├── 📂 controller
│   │   ├── 📄 AuthController.java               (로그인/회원가입/비밀번호 찾기 페이지 라우팅)
│   │   └── 📄 AuthApiController.java            (비동기 인증 API)
│   ├── 📂 dto
│   │   ├── 📄 LoginRequest.java
│   │   ├── 📄 SignupRequest.java
│   │   ├── 📄 FindPasswordRequest.java
│   │   └── 📄 ResetPasswordRequest.java
│   ├── 📂 service
│   │   ├── 📄 AuthService.java                  (로그인 / 로그아웃 / 회원가입 처리)
│   │   ├── 📄 PasswordResetService.java         (비밀번호 재설정 처리)
│   │   └── 📄 MailService.java                  (비밀번호 재설정 메일 발송)
│   ├── 📂 validator
│   │   └── 📄 AuthValidator.java
│   ├── 📂 entity
│   │   └── 📄 PasswordResetToken.java
│   └── 📂 repository
│       └── 📄 PasswordResetTokenRepository.java
│
├── 📂 user                                       (회원)
│   ├── 📂 controller
│   │   └── 📄 UserController.java               (회원 조회 / 수정 / 탈퇴)
│   ├── 📂 dto
│   │   ├── 📄 UserUpdateRequest.java
│   │   ├── 📄 UserProfileResponse.java
│   │   └── 📄 UserSummaryResponse.java
│   ├── 📂 service
│   │   └── 📄 UserService.java
│   ├── 📂 repository
│   │   └── 📄 UserRepository.java
│   └── 📂 entity
│       └── 📄 User.java                         (USERS 테이블 매핑)
│
├── 📂 expense                                    (지출)
│   ├── 📂 controller
│   │   └── 📄 ExpenseController.java            (지출 등록 / 목록 / 수정 / 삭제)
│   ├── 📂 dto
│   │   ├── 📄 ExpenseCreateRequest.java
│   │   ├── 📄 ExpenseUpdateRequest.java
│   │   ├── 📄 ExpenseResponse.java
│   │   └── 📄 ExpenseSearchCondition.java
│   ├── 📂 service
│   │   └── 📄 ExpenseService.java
│   ├── 📂 repository
│   │   ├── 📄 ExpenseRepository.java
│   │   └── 📄 CategoryRepository.java
│   └── 📂 entity
│       ├── 📄 Expense.java                      (EXPENSES 테이블)
│       └── 📄 Category.java                     (CATEGORIES 테이블)
│
├── 📂 dashboard                                  (지출 통계 / 대시보드)
│   ├── 📂 controller
│   │   └── 📄 DashboardController.java
│   ├── 📂 dto
│   │   ├── 📄 DashboardResponse.java
│   │   ├── 📄 CategoryRatioResponse.java
│   │   ├── 📄 MonthlyExpenseStatResponse.java
│   │   └── 📄 GoalAchievementResponse.java
│   └── 📂 service
│       └── 📄 DashboardService.java
│
├── 📂 goal                                       (절약 목표)
│   ├── 📂 controller
│   │   └── 📄 GoalController.java
│   ├── 📂 dto
│   │   ├── 📄 GoalCreateRequest.java
│   │   ├── 📄 GoalUpdateRequest.java
│   │   └── 📄 GoalResponse.java
│   ├── 📂 service
│   │   └── 📄 GoalService.java
│   ├── 📂 repository
│   │   └── 📄 GoalRepository.java
│   └── 📂 entity
│       └── 📄 SavingGoal.java                   (SAVING_GOALS 테이블)
│
├── 📂 subscription                               (구독 관리)
│   ├── 📂 controller
│   │   └── 📄 SubscriptionController.java
│   ├── 📂 dto
│   │   ├── 📄 SubscriptionCreateRequest.java
│   │   ├── 📄 SubscriptionUpdateRequest.java
│   │   └── 📄 SubscriptionResponse.java
│   ├── 📂 service
│   │   └── 📄 SubscriptionService.java
│   ├── 📂 repository
│   │   └── 📄 SubscriptionRepository.java
│   └── 📂 entity
│       └── 📄 Subscription.java                 (SUBSCRIPTIONS 테이블)
│
├── 📂 party                                      (구독 파티 모집)
│   ├── 📂 controller
│   │   └── 📄 PartyController.java
│   ├── 📂 dto
│   │   ├── 📄 PartyPostRequest.java
│   │   └── 📄 PartyDetailResponse.java
│   ├── 📂 service
│   │   └── 📄 PartyService.java
│   ├── 📂 repository
│   │   └── 📄 PartyRepository.java
│   └── 📂 entity
│       └── 📄 PartyPost.java
│
├── 📂 board                                      (일반 게시판)
│   ├── 📂 controller
│   │   └── 📄 BoardController.java
│   ├── 📂 dto
│   │   ├── 📄 BoardWriteRequest.java
│   │   ├── 📄 BoardUpdateRequest.java
│   │   ├── 📄 CommentWriteRequest.java
│   │   └── 📄 BoardDetailResponse.java
│   ├── 📂 service
│   │   ├── 📄 BoardService.java
│   │   └── 📄 CommentService.java
│   ├── 📂 repository
│   │   ├── 📄 BoardRepository.java
│   │   └── 📄 CommentRepository.java
│   └── 📂 entity
│       ├── 📄 Board.java                        (BOARDS 테이블)
│       └── 📄 Comment.java                      (COMMENTS 테이블)
│
├── 📂 mypage                                     (마이페이지 / 보안 / 계좌)
│   ├── 📂 controller
│   │   └── 📄 MyPageController.java
│   ├── 📂 dto
│   │   ├── 📄 MyPageSummaryResponse.java
│   │   ├── 📄 PinUpdateRequest.java
│   │   ├── 📄 AccountRegisterRequest.java
│   │   └── 📄 AccountUpdateRequest.java
│   ├── 📂 service
│   │   ├── 📄 MyPageService.java
│   │   └── 📄 AccountService.java
│   ├── 📂 repository
│   │   └── 📄 AccountRepository.java
│   └── 📂 entity
│       └── 📄 Account.java
│
├── 📂 support                                    (고객센터 / 문의)
│   ├── 📂 controller
│   │   └── 📄 SupportController.java
│   ├── 📂 dto
│   │   ├── 📄 InquiryCreateRequest.java
│   │   ├── 📄 InquiryUpdateRequest.java
│   │   └── 📄 InquiryResponse.java
│   ├── 📂 service
│   │   └── 📄 SupportService.java
│   ├── 📂 repository
│   │   └── 📄 InquiryRepository.java
│   └── 📂 entity
│       └── 📄 Inquiry.java                      (INQUIRIES 테이블)
│
├── 📂 faq                                        (FAQ)
│   ├── 📂 controller
│   │   └── 📄 FaqController.java
│   ├── 📂 dto
│   │   ├── 📄 FaqCreateRequest.java
│   │   ├── 📄 FaqUpdateRequest.java
│   │   └── 📄 FaqResponse.java
│   ├── 📂 service
│   │   └── 📄 FaqService.java
│   ├── 📂 repository
│   │   └── 📄 FaqRepository.java
│   └── 📂 entity
│       └── 📄 Faq.java
│
├── 📂 notification                               (알림 / 발송 로그)
│   ├── 📂 controller
│   │   └── 📄 NotificationController.java
│   ├── 📂 dto
│   │   ├── 📄 NotificationSendRequest.java
│   │   └── 📄 NotificationLogResponse.java
│   ├── 📂 service
│   │   └── 📄 NotificationService.java
│   ├── 📂 repository
│   │   └── 📄 NotificationLogRepository.java
│   └── 📂 entity
│       └── 📄 NotificationLog.java              (NOTIFICATION_LOGS 테이블)
│
├── 📂 review                                     (리뷰)
│   ├── 📂 controller
│   │   └── 📄 ReviewController.java
│   ├── 📂 dto
│   │   ├── 📄 ReviewWriteRequest.java
│   │   └── 📄 ReviewResponse.java
│   ├── 📂 service
│   │   └── 📄 ReviewService.java
│   ├── 📂 repository
│   │   └── 📄 ReviewRepository.java
│   └── 📂 entity
│       └── 📄 Review.java                       (REVIEWS 테이블)
│
├── 📂 admin                                      (관리자)
│   ├── 📂 controller
│   │   └── 📄 AdminController.java
│   ├── 📂 dto
│   │   ├── 📄 UserStatusUpdateRequest.java
│   │   ├── 📄 ReportProcessRequest.java
│   │   └── 📄 AdminDashboardResponse.java
│   ├── 📂 service
│   │   ├── 📄 AdminService.java
│   │   ├── 📄 AdminUserService.java
│   │   ├── 📄 AdminBoardService.java
│   │   ├── 📄 AdminSupportService.java
│   │   └── 📄 AdminNotificationService.java
│   ├── 📂 repository
│   │   ├── 📄 ReportRepository.java
│   │   └── 📄 AdminAuditLogRepository.java
│   ├── 📂 facade
│   │   └── 📄 AdminFacade.java
│   └── 📂 entity
│       ├── 📄 Report.java
│       └── 📄 AdminAuditLog.java
│
└── 📂 ai                                         (AI 금융멘토)
├── 📂 controller
│   └── 📄 AiMentorController.java
├── 📂 dto
│   ├── 📄 ConsumptionAnalysisResponse.java
│   ├── 📄 FeedbackResponse.java
│   └── 📄 OpportunityCostResponse.java
└── 📂 service
    └── 📄 AiMentorService.java