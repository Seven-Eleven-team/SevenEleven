# 지출메이트 (SpendMate) — 개인 지출·구독 관리 웹서비스

지출 내역과 소비 통계, 구독 서비스를 한곳에서 관리하고, 구독 파티 모집과 AI 소비 피드백까지 제공하는 웹서비스입니다.

## 프로젝트 정보

| 구분 | 내용 |
|---|---|
| 과정 | K-Digital Training 단기 과정 「스프링Boot & AWS 클라우드 활용 금융서비스 솔루션 백엔드 아키텍쳐 개발 프로젝트」 |
| 기간 | 2026.03 ~ 2026.06 |
| 팀 | 세븐일레븐 (7명) |
| 노션 | [팀 노션](https://www.notion.so/337c6c4cb51580eca9cadcc9efd87728) |

## 주요 기능

| 영역 | 기능 |
|---|---|
| 회원 | 회원가입(약관 동의), 로그인 모달, 소셜 로그인(OAuth2), 이메일 링크 비밀번호 재설정, 회원정보 수정·탈퇴 |
| 지출 관리 | 지출 등록·조회·수정·삭제, 절약 목표 설정 |
| 대시보드 | 카테고리별 지출 비율, 월별 지출 변화, 요약 카드 |
| 구독 관리 | 구독 등록·목록·상세, OTT 구독 구매, 구독 일정 스케줄러 |
| 구독 파티 | 파티 모집 게시판, 판매자 등록·본인 확인·프로필 |
| AI 멘토 | Gemini API를 이용한 소비 분석·피드백 |
| 커뮤니티 | 게시글 작성·수정·삭제, 첨부파일, 댓글, 내가 쓴 글, 익명 작성, 나이대별 접근 제한 |
| 고객센터 | FAQ, 1:1 문의 작성·수정 |
| 마이페이지 | 내 정보, 알림, 내 글, 문의 내역, 신고 내역, 판매 내역, 구독 내역 |
| 관리자 | 회원·약관·문의·알림·FAQ 관리, OTT 판매자·구매 내역 관리, 감사 로그 |

## 기술 스택

| 구분 | 내용 |
|---|---|
| Backend | Java 21, Spring Boot 4.0.5, Spring Security, Spring Data JPA, OAuth2 Client, Spring Mail |
| Frontend | JSP, JSTL, JavaScript, CSS |
| Database | Oracle (Docker 컨테이너로 팀 공동 개발 환경 구성) |
| 외부 API | Google Gemini API |
| 도구 | IntelliJ IDEA, Gradle, Git, GitHub, Notion |

## 폴더 구조

```text
src/main/java/com/bu/jichulmate/
  config/        Security, 로그인·관리자 접근 인터셉터, 메일, DB 설정
  controller/    화면·API 컨트롤러 (회원, 지출, 대시보드, 구독, 파티, 커뮤니티, 고객센터, 관리자, AI 멘토)
  service/       비즈니스 로직
  repository/    JPA 리포지토리
  domain/        엔티티
  dto/           요청·응답 객체
  scheduler/     구독 일정 처리
src/main/webapp/WEB-INF/views/   JSP 화면 (auth, community, dashboard, expense, members, party, subscription, support, admin)
docs/            패키지·프론트엔드·정적 리소스 구조 문서
```

자세한 구조는 [패키지 구조](docs/PACKAGE_STRUCTURE_2.1.md), [프론트엔드 구조](docs/FRONTEND_STRUCTURE_2.1.md) 문서에 있습니다.

## 실행 방법

1. Docker로 Oracle XE를 실행합니다. 기본 설정은 `localhost:1522/XEPDB1`입니다.
2. `src/main/resources/application.properties`에 DB 계정, Gemini API 키, 메일 계정을 설정합니다. 비밀번호와 API 키는 환경 변수나 별도 설정 파일로 분리하고 저장소에 올리지 않습니다.
3. `./gradlew bootRun`으로 실행한 뒤 http://localhost:8081 에 접속합니다.

## 팀 구성

| 이름 | GitHub | 역할 |
|---|---|---|
| 강호영 | [hoyoung6604](https://github.com/hoyoung6604) | 팀장, 기술리더, 데이터베이스 관리 |
| 이은아 | [euna0428](https://github.com/euna0428) | 프로젝트 매니저(PM), 프론트엔드, 발표 |
| 최시현 | [choisihyeon](https://github.com/choisihyeon) | Git 관리 |
| 윤혁재 | [YOONHyukjae](https://github.com/YOONHyukjae) | UI/UX 디자인 |
| 정진우 | [balgeom](https://github.com/balgeom) | 백엔드 |
| 김하영 | [happang0815](https://github.com/happang0815) | 문서 관리 |
| 유다연 | [20222267-stack](https://github.com/20222267-stack) | 오락부장 |

## 관련 문서

- [기존 README](README1.md)
