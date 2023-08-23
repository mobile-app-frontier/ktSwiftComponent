# KtSwiftPackage

Swift 재사용 컴포넌트 package

## Install

### Swift Package Manager
The [Swift Package Manager](https://www.swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the swift compiler.

Once you have your Swift package set up, adding KtSwiftPackage as a dependency is as easy as adding it to the dependencies value of your Package.swift.

dependencies: [
    .package(url: "https://github.com/mobile-app-frontier/ktSwiftComponent.git")
]

> **NOTE** \
어플리케이션 프로젝트 추가 방법 \
project > package dependecies > + add \
입력창에 https://github.com/mobile-app-frontier/ktSwiftComponent.git 입력 \
dependency rule 설정 \
add Package \
사용 할 module 추가

## KT SwiftPackage Module

- [AnimationView](/AnimationView)
- [Banner](/Banner)
- [CryptoUtils](/CryptoUtils)
- [IndexedScrollView](/IndexedScrollView)
- [InifiteScrollModifier](/InifiteScrollModifier)
- [Log](/Log)
- [ModalManager](/ModalManager)
- [NavRouter](/NavRouter)
- [PermissionManager](/PermissionManager)
- [PollingCenter](/PollingCenter)
- [StepView](/StepView)

> **NOTE:**
> 1. 각 항목에 More는 api documentation입니다.
> 2. 각 모듈은 Example  directory에 샘플 코드가 있습니다.
