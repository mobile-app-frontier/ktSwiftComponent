import SwiftUI
import ModalManager

struct ExampleModalManagerView: View {
    
    var body: some View {
        VStack(
        ) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Button("다이얼로그 예시") {
                ModalManager.getInstance(
                    modalStyle: CoverModalStyle()
                ).show(
                    modalWindowStyle: CoverModalWindowStyle(), modalContent: {
                        VStack {
                            Button {
                                triggerRelayDialog()
                            } label: {
                                Text("모달 위에 모달 띄우기")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            Button {
                                ModalManager.getInstance().dismissModal()
                            } label: {
                                Text("버튼을 눌러 모달 닫기")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.indigo)
    }
}

@MainActor func triggerRelayDialog() {
//    Task{
//        try await Task.sleep(nanoseconds:1_000_000_000)
        ModalManager.getInstance().show(
            modalWindowStyle: ResizableModalWindowStyle(),
            modalContent: {
                VStack {
                    Text("다이얼로그 제목")
                    Button {
                        ModalManager.getInstance().dismissModal()
                        
                    } label: {
                        Text("닫기")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
        )
 //   }
}
