# StepView

A description of this package.

## example

enum StepType {
    case userInfo
    case smsOtp
    case password
    
    static func stepSequence () -> [StepType]{
        return [
            StepType.userInfo,
            StepType.smsOtp,
            StepType.password
        ]
    }
}

//MARK: - SubscribeStep+SubscribeStatusBarView
extension StepType {
    func title () -> String {
        switch (self) {
        case .userInfo:
            fallthrough
        case .smsOtp:
            return "회원가입"
        case .password:
            return "간편비밀번호 설정"
        }
    }
}


//MARK: - SubscribeStep+StepView
extension StepType {
    func toStepContent()-> StepContent<StepType>  {
        switch (self) {
        case .userInfo:
            return StepContent(step: .userInfo) {
                SubscribeUserInfoView().toAnyView()
            }
        case .smsOtp:
            return StepContent(step: .smsOtp) {
                SubscribeSmsAuthView().toAnyView()
            }
        case .password:
            return StepContent(step: .password) {
                ConveniencePasswordSettingView().toAnyView()
            }
        }
    }
}

struct Screen {
    @State
    var controller = StepController<SubscribeStep>(
        contents: SubscribeStep.stepSequence()
            .map({ step in
                step.toStepContent()
            }),
        initialIndex: 0)
    
}


extension Screen: View {
    var body: some View {
        VStack {
            SubscribeStatusBarView()
                .environmentObject(controller)
            StepView(controller: controller)
        }
    }
}
