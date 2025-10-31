 # BookLibrary

  BookLibrary는 카카오 책 검색 API를 이용해 원하는 책을 찾아보고 세부 정보를 확인하며, 서재에 책을 저장할 수 있는 iOS 앱입니다. 
  클린 아키텍처 기반으로 레이어를 분리했고 MVVM과 RxSwift를 함께 사용했습니다. Core Data를 통해 사용자 저장 데이터를 관리합니다.

  ## 주요 기능

  - 카카오 책 검색 API 연동, 페이지네이션을 포함한 검색 결과 조회
  - 하단 시트 형태의 도서 상세 정보 뷰 제공
  - 관심 도서를 Core Data에 저장하여 서재 관리
  - 최근에 본 책 최대 5권 자동 저장 및 빠른 접근 기능

  ## 기술 스택

  - Swift / UIKit
  - RxSwift, RxCocoa 
  - SnapKit 
  - Alamofire 
  - Core Data 

  ## 아키텍처

  레이어를 `Presentation`, `Domain`, `Data`로 분리했습니다.

  - **Presentation:** UIKit 기반 화면과 커스텀 뷰를 MVVM 구조로 작성
  RxSwift를 사용해 뷰모델과 UI를 바인딩하고, 페이징・선택 이벤트 등을 처리합니다.
  - **Domain:** 순수 Swift 모델과 레포지토리/유스케이스 프로토콜 정
  의. 유스케이스는 고수준 로직을 담당하며 플랫폼에 의존하지 않습니다.
  - **Data:** 원격 API 및 Core Data를 다루는 구체 구현. 카카오 응답 DTO를 도메인 모델로 변환하고, `CoreDataManager`가 Persistence 스택을 설정합니다.

  ## 디렉터리 구조

```bash
BookLibrary/
├── App/                     # AppDelegate, SceneDelegate, LaunchScreen
├── Base.lproj/              # 기본 로컬라이즈 리소스
├── Config/                  # 빌드 설정 (Config.xcconfig, Kakao API 키)
├── Data/
│   ├── Entity/              # Kakao API DTO 및 Core Data 변환
│   ├── Persistence/         # CoreDataManager
│   └── Repository/          # 데이터 레포지토리 구현
├── Domain/
│   ├── Model/               # 도메인 모델
│   ├── Repository/          # 레포지토리 프로토콜
│   └── UseCase/             # Use Case 정의
├── NetworkManager/          # Alamofire 기반 API 클라이언트와 엔드포인트
├── Presentation/
│   ├── Detail/              # 상세 화면 
│   ├── Save/                # 저장된 도서 화면
│   └── Search/              # 검색 화면
└── Resources/
    ├── Assets.xcassets          # 이미지, 컬러 에셋
    └── BookLibrary.xcdatamodeld # Core Data 엔티티 (BookEntity, RecentBookEntity)
```

  ## 네트워킹
  
  - `BookAPI` enum이 요청을 구성하고 `APIClient`(Alamofire `Session`)가 처리합니다.
  - DTO → 도메인 모델 변환을 통해 UI에 필요한 필드만 노출합니다.

  ## CoreData

  - `BookEntity`: 저장한 도서
  - `RecentBookEntity`: 최근에 본 도서 최대 5권, `RecentBookRepository`가 관리
  - 두 엔티티는 `BookLibrary.xcdatamodeld`에 정의되어 있고 `CoreDataManager`가 `NSPersistentContainer`를 관리합니다.

  ## RxSwift

  - 뷰모델은 `Driver`, `Observable`, `Relay`로 상태를 노출합니다.
  - 검색어 입력은 디바운스 처리 후 API 호출, 스크롤 이벤트로 무한 스크롤 처리.
  - 저장된 도서/최근 도서 목록은 Rx 바인딩으로 UI와 빈 상태 표시를 자동 갱신합니다.

  ## 블로그 작성
  [뷰모델 transform 패턴으로 만들기](https://0minnie0.tistory.com/93)


