src/main/resources/static
│
├── 📂 css                                      (화면별 스타일 / 공통 UI 스타일 관리)
│   ├── 📄 home.css                            (메인 홈 화면 스타일)
│   ├── 📄 dashboard.css                       (대시보드 화면 스타일)
│   ├── 📄 expense.css                         (지출 내역 조회 / 등록 / 수정 화면 스타일)
│   ├── 📄 goal.css                            (예산 목표 / 절약 목표 화면 스타일)
│   ├── 📄 subscription.css                    (정기결제 / 구독 관리 화면 스타일)
│   ├── 📄 party.css                           (공동 지출 / 모임 정산 화면 스타일)
│   ├── 📄 board.css                           (게시판 목록 / 상세 / 작성 화면 스타일)
│   ├── 📄 review.css                          (리뷰 / 후기 게시판 화면 스타일)
│   ├── 📄 mypage.css                          (마이페이지 화면 스타일)
│   ├── 📄 support-hub.css                     (고객지원 메인 화면 스타일)
│   ├── 📄 support-console.css                 (문의 접수 / 상담 관리 화면 스타일)
│   ├── 📄 faq.css                             (자주 묻는 질문 화면 스타일)
│   ├── 📄 login.css                           (로그인 화면 스타일)
│   ├── 📄 signup.css                          (회원가입 화면 스타일)
│   ├── 📄 auth-modal.css                      (로그인 / 회원가입 / 인증 모달 스타일)
│   ├── 📄 ui-toast.css                        (토스트 알림 UI 스타일)
│   ├── 📄 admin-theme.css                     (관리자 페이지 전용 테마 / 색상 스타일)
│   ├── 📄 admin-components.css                (관리자 공통 버튼 / 테이블 / 카드 컴포넌트 스타일)
│   └── 📄 admin-console.css                   (관리자 콘솔 메인 화면 스타일)
│
├── 📂 img                                      (프로젝트 공통 이미지 / 배경 이미지 / 빈 상태 이미지 관리)
│   ├── 📄 logo.png                            (서비스 대표 로고 이미지)
│   ├── 📄 hero.jpg                            (메인 화면 대표 배너 이미지)
│   ├── 📄 main_dark.jpg                       (다크 테마 메인 배경 이미지)     🗑️
│   ├── 📄 main_light.jpg                      (라이트 테마 메인 배경 이미지)   🗑️
│   ├── 📄 expense-empty.png                   (지출 내역이 없을 때 표시할 빈 상태 이미지)
│   ├── 📄 subscription-empty.png              (구독 내역이 없을 때 표시할 빈 상태 이미지)
│   ├── 📄 review-empty.png                    (리뷰 / 후기 데이터가 없을 때 표시할 빈 상태 이미지)
│   │
│   └── 📂 theme                               (테마 모드 전용 이미지)🗑️
│       ├── 📄 day-bg.png                     (주간 테마 배경 이미지)🗑️
│       └── 📄 night-bg.png                   (야간 테마 배경 이미지)🗑️
│
└── 📂 js                                       (공통 동작 스크립트 / 페이지별 스크립트 / 외부 라이브러리 관리)
│   ├── 📄 theme-init.js                       (페이지 로드 시 저장된 테마를 먼저 적용하는 초기화 스크립트)🗑️
│   ├── 📄 theme.js                            (다크 / 라이트 모드 전환 스크립트)🗑️
│   ├── 📄 nav-wave.js                         (네비게이션 버튼 효과 / 인터랙션 스크립트)
│   ├── 📄 scrollbar-auto.js                   (스크롤 영역 자동 보정 / 높이 계산 스크립트)
│   ├── 📄 ui-toast.js                         (토스트 알림 메시지 출력 스크립트)
│   ├── 📄 auth-guard.js                       (비로그인 사용자 접근 제한 / 인증 체크 스크립트)
│   ├── 📄 auth-modal.js                       (로그인 / 회원가입 / 인증 모달 제어 스크립트)
│   ├── 📄 alert.js                            (커스텀 경고창 / 안내창 공통 스크립트)
│
├── 📂 pages                               (각 화면 전용 스크립트 분리 관리)
│   ├── 📄 index.js                        (메인 페이지 전용 스크립트)
│   ├── 📄 dashboard.js                    (대시보드 화면 전용 스크립트)
│   ├── 📄 expense-list.js                 (지출 내역 목록 조회 / 필터 / 정렬 스크립트)
│   ├── 📄 expense-form.js                 (지출 등록 / 수정 입력 처리 스크립트)
│   ├── 📄 subscription.js                 (구독 관리 화면 전용 스크립트)
│   ├── 📄 board-detail.js                 (게시글 상세 보기 / 댓글 / 좋아요 처리 스크립트)
│   ├── 📄 mypage.js                       (마이페이지 정보 수정 / 상태 제어 스크립트)
│   ├── 📄 support.js                      (고객지원 화면 전용 스크립트)
│   ├── 📄 faq.js                          (FAQ 펼침 / 닫힘 처리 스크립트)
│   ├── 📄 ai-mentor.js                    (AI 소비 분석 및 멘토 피드백 제어 스크립트 - 추가됨)
│   ├── 📄 admin-dashboard.js              (관리자 대시보드 전용 스크립트)
│   ├── 📄 admin-terms.js                  (관리자 약관 관리 스크립트 - 추가됨)
│   ├── 📄 admin-audit.js                  (관리자 로그 조회 스크립트 - 추가됨)
│   ├── 📄 login-page.js                   (로그인 페이지 입력 검증 / 이벤트 처리 스크립트)
│   └── 📄 register-page.js                (회원가입 페이지 입력 검증 / 이벤트 처리 스크립트)
│
└── 📂 vendor                              (외부 라이브러리 파일 관리)
    └── 📄 chart.min.js                    (통계 차트 출력용 외부 라이브러리)