# 🧭 Time Ledger

> **"A compass for time management, not an engine."**
>
> Time Ledger는 단순히 시간을 기록하는 도구가 아니라, 당신의 시간이 어디로 흐르고 있는지 명확하게 보여주는 나침반입니다.

<br/>

## 📱 프로젝트 소개

Time Ledger는 사용자가 하루를 어떻게 보냈는지 직관적으로 기록하고 분석할 수 있는 시간 관리 애플리케이션입니다. 
복잡한 입력 없이 생산적(Productive), 소모적(Waste) 등의 카테고리로 시간을 분류하고, 캘린더와 통계 기능을 통해 자신의 생활 패턴을 시각적으로 파악할 수 있습니다.

📢 현재 미완성된 프로젝트로, 기능 중 일부만 동작할 수 있습니다.

<br/>

## 🛠 기술 스택 (Tech Stack)

### **Core**
- ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white) **Flutter 3.x**
- ![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white) **Dart**

### **State Management & Architecture**
- **Riverpod (2.0+):** `flutter_riverpod`, `riverpod_annotation`, `riverpod_generator`를 활용한 상태 관리.
- **Clean Architecture:** `Presentation` - `Domain` - `Data` 계층 분리 패턴 적용.

### **Local Database**
- **Drift (SQLite):** 로컬 데이터 영속성 관리.
- **Freezed:** 불변 객체(Immutable Object) 및 데이터 클래스 생성.

### **UI & Styling**
- **Slivers:** 복잡한 스크롤 인터랙션 구현 (`CustomScrollView`, `SliverPersistentHeader`).
- **Lucide Icons:** 모던하고 일관된 아이콘 팩 사용.

<br/>

## 📂 프로젝트 구조

```
lib/
├── core/            # 앱 전반에서 사용되는 상수, 테마, 유틸리티
│   ├── theme/       # 디자인 시스템 토큰 및 스타일 정의
│   └── utils/       # 공통 유틸리티 함수
├── data/            # 데이터 계층 (리포지토리 구현, 데이터 소스)
│   ├── data_sources/# 로컬 데이터베이스 (Drift) 정의
│   └── repositories/# Domain 리포지토리 인터페이스의 구현체
├── domain/          # 도메인 계층 (비즈니스 로직, 엔티티)
│   ├── model/       # 앱의 핵심 데이터 모델
│   └── repository/  # 데이터 접근을 위한 인터페이스 정의
├── presentation/    # UI 계층 (화면, 위젯, 상태 관리)
│   ├── common/      # 재사용 가능한 공통 위젯
│   ├── components/  # 기능별 컴포넌트 묶음 (캘린더 등)
│   └── screens/     # 주요 화면 (Home, Analysis 등)
└── main.dart        # 앱 진입점
```

<br/>

## 🚀 시작하기 (Getting Started)

### **선행 조건**
- Flutter SDK 설치 (3.2.0 이상)
- Android Studio 또는 VS Code
- iOS Simulator 또는 Android Emulator

### **설치 및 실행**

1. **레포지토리 클론**
   ```bash
   git clone https://github.com/hbhhb/time-ledger.git
   ```

2. **의존성 설치**
   ```bash
   flutter pub get
   ```

3. **코드 생성 (Code Generation)**
   Drift, Riverpod, Freezed 등을 사용하므로 빌드 러너 실행이 필요합니다.
   ```bash
   dart run build_runner build -d
   ```

4. **앱 실행**
   ```bash
   flutter run
   ```
