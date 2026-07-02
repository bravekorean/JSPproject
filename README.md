# JSPproject

README에 노출되어 있던 API 키는 AI 에이전트를 이용해 플레이스홀더로 리팩토링하였고, 문서는 Codex가 작성하였습니다.

공공데이터포털의 문화정보예술 API를 기반으로 전시회, 연극, 뮤지컬 정보를 조회하고 예매 기능을 제공하는 JSP 웹 프로젝트입니다.

## 개발 기간

- 2023.05.05 ~ 2023.06.17

## 주요 기능

- 문화공연/전시 정보 조회
- 전시회, 연극, 뮤지컬 카테고리별 목록 조회
- 공연 상세 정보 및 지도 확인
- 회원가입, 로그인, 로그아웃
- 마이페이지 회원 정보 수정
- 예매 및 결제 정보 저장
- 리뷰 작성, 수정, 삭제, 좋아요
- 관리자 회원/게시글 관리

## 사용 기술

- Java
- JSP
- HTML
- CSS
- JavaScript
- jQuery
- Oracle Database
- Apache Tomcat

## 프로젝트 구조

```text
src/main/java
  common      공통 DB 연결 및 지역 검색 유틸
  membership  회원/관리자 DAO, DTO
  review      리뷰 DAO, DTO
  ticket      예매/결제 DAO, DTO, Servlet
  utils       API 호출, 쿠키, JavaScript 응답 유틸

src/main/webapp
  Main.jsp               메인 화면
  LogIn_LogOut           로그인/로그아웃
  Register               회원가입
  Update                 회원 정보 수정
  Delete                 회원 탈퇴
  mypage                 마이페이지
  admin                  관리자 화면
  board                  공연 목록, 상세, 리뷰, 예매
  WEB-INF/web.xml        웹 애플리케이션 설정
  WEB-INF/lib            외부 라이브러리 JAR
```

## 실행 환경

- Java 8 이상
- Apache Tomcat 9
- Oracle Database
- Eclipse Dynamic Web Project 기준으로 구성

현재 프로젝트는 Maven/Gradle 기반이 아니라 Eclipse 웹 프로젝트 설정 파일을 포함하고 있습니다. Eclipse 없이 실행하려면 별도의 빌드 설정 또는 WAS 배포 설정을 추가로 구성해야 합니다.

## 데이터베이스

`WEB-INF/web.xml`과 `common.JDBCConnect`에 Oracle 연결 정보가 설정되어 있습니다.

기본 설정은 로컬 Oracle XE 기준입니다.

```text
jdbc:oracle:thin:@localhost:1521:xe
```

실행 전 회원, 리뷰, 예매, 결제 관련 테이블과 시퀀스가 필요합니다.

## 참고 사항

- 일부 JSP와 Java 코드에는 외부 서비스 연동을 위한 플레이스홀더 값이 포함되어 있습니다.
- 오래된 프로젝트이므로 실제 실행 전 외부 API, 결제, 지도 연동 값은 현재 서비스 정책에 맞게 다시 설정해야 합니다.
- 비즈니스 로직이 JSP scriptlet에 많이 포함되어 있어 유지보수 시 Servlet/Service/DAO 구조로 분리하는 것이 좋습니다.
- 일부 SQL은 문자열 조합 방식으로 작성되어 있어 PreparedStatement 기반으로 정리하는 것을 권장합니다.
- 회원 비밀번호는 평문 비교 방식으로 구현되어 있어 실제 서비스 용도라면 해시 처리가 필요합니다.

## 팀

- 조장: 황준범
- 조원: 최혜안, Nguyen Xuan Khang
