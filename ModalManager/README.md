# ModalManager

사용자가 커스터마이징한 뷰를 모달로 올려 표출합니다.

** `모달 매니저 초기화하기`**
ModalManager는 앱 런타임동안 싱글톤으로 동작합니다.
최초 ModalManager 호출 시 3가지를 결정합니다.
- 모달 표출 형식 (전환 효과,  모달 창 외부 배경 색상, 모달 프레젠테이션 형식)
- 모달 표출 순서 (디폴트로 표출 요청이 들어오는 대로 띄워주며, 변경하지 않기를 권장합니다.)
- 모달 표출 옵션 (모달이 화면에 띄워져 있다면, 추가로 표출 요청이 들어와도 무시할 수 있습니다. 무시하지 않는 게 디폴트입니다.)

`getInstance` 메서드에 위의 정보들을 넣어서 최초 설정을 할 수 있습니다.
최초 한번 설정되었다면 변경되지 않습니다.

** `사용자가 만든 뷰를 모달로 띄우기`**
ModalManager는 사용자가 만든 SwiftUI View를 모달로 올려줄 수 있습니다. `show` 메서드를 사용하여 modalContent로 view를 넘겨주면 됩니다.
show는 모달을 커스터마이징할 수 있는 옵션들을 가지고 있습니다.
- modalWindowStyle: show에서 띄우려는 모달의 스타일을 정의할 수 있습니다.
- modalContent: 띄우고자 하는 view를 작성합니다.

** `모달 내리기`**
ModalManager로 띄운 모달을 내리기 위해서 `dismissModal`를 호출합니다.
`dismissModal`를 호출하면 현재 표출 중인 최상단 모달이 내려갑니다.

- [Example](#example)
- [structure](#structure)

## Example
``` Swift
ModalManager.getInstance().show {
    VStack {
        Text("다이얼로그 제목")
         Button {
            ModalManager.getInstance().dismissModal()
         } label: {
            Text("button")
        }
    }
}
```

## [MORE](/Documentation/ModalManager/Home.md)
