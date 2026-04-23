src/main/webapp/WEB-INF/views
│
├── 📄 index.jsp                              (메인 페이지)
│
├── 📂 common                                 (공통 화면 조각)
│   ├── 📂 layout
│   │   ├── 📄 header.jspf                   (공통 헤더)
│   │   ├── 📄 footer.jspf                   (공통 푸터)
│   │   └── 📄 sidebar.jspf                  (공통 사이드바)
│   │
│   ├── 📂 include
│   │   ├── 📄 head.jspf                     (공통 meta / css / favicon)
│   │   ├── 📄 scripts.jspf                  (공통 js include)
│   │   └── 📄 flash-message.jspf            (서버 메시지 출력)
│   │
│   ├── 📂 modal
│   │   ├── 📄 authModal.jspf                (인증 모달 프레임)
│   │   ├── 📄 loginModal.jspf               (로그인 모달)
│   │   ├── 📄 signupModal.jspf              (회원가입 모달)
│   │   ├── 📄 findPasswordModal.jspf        (비밀번호 찾기 모달)
│   │   └── 📄 loginRequiredModal.jspf       (로그인 필요 모달)
│   │
│   └── 📂 error
│       ├── 📄 404.jsp
│       ├── 📄 500.jsp
│       └── 📄 access-denied.jsp
│
├── 📂 auth
│   ├── 📄 login.jsp
│   ├── 📄 signup.jsp
│   ├── 📄 find-password.jsp
│   ├── 📄 reset-password.jsp
│   └── 📄 reset-password-invalid.jsp
│
├── 📂 expense
│   ├── 📄 list.jsp
│   ├── 📄 form.jsp
│   └── 📄 detail.jsp
│
├── 📂 dashboard
│   └── 📄 dashboard.jsp
│
├── 📂 goal
│   ├── 📄 form.jsp
│   └── 📄 detail.jsp
│
├── 📂 subscription
│   ├── 📄 list.jsp
│   ├── 📄 form.jsp
│   └── 📄 detail.jsp
│
├── 📂 party
│   ├── 📄 list.jsp
│   ├── 📄 form.jsp
│   └── 📄 detail.jsp
│
├── 📂 board
│   ├── 📄 list.jsp
│   ├── 📄 write.jsp
│   ├── 📄 edit.jsp
│   └── 📄 detail.jsp
│
├── 📂 members
│   └── 📂 mypage
│       ├── 📄 mypage.jsp
│       ├── 📄 profile.jsp
│       ├── 📄 security.jsp
│       ├── 📄 accounts.jsp
│       └── 📄 account-form.jsp
│
├── 📂 support
│   ├── 📄 support.jsp
│   ├── 📄 qna.jsp
│   ├── 📄 qnaDetail.jsp
│   ├── 📄 qnaForm.jsp
│   ├── 📄 notice.jsp
│   ├── 📄 noticeDetail.jsp
│   ├── 📄 faq.jsp
│   ├── 📄 faqDetail.jsp
│   └── 📄 _sidebar.jspf
│
├── 📂 review
│   ├── 📄 myReview.jsp
│   ├── 📄 write.jsp
│   └── 📄 edit.jsp
│
└── 📂 admin
    ├── 📄 admin_index.jsp
    ├── 📄 admin_users.jsp
    ├── 📄 admin_board.jsp
    ├── 📄 admin_report.jsp
    ├── 📄 admin_service.jsp
    ├── 📄 admin_notification.jsp
    ├── 📄 admin_inquiries.jsp
    ├── 📄 admin_faq.jsp
    └── 📄 admin_sidebar.jspf