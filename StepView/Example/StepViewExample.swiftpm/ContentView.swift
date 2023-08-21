import SwiftUI
import StepView

struct ContentView: View {
    
    @State
    var controller = StepController<ExampleStepType>(
        contents: ExampleStepType.stepSequence()
            .map({ step in
                step.toStepContent()
            }),
        initialIndex: 0)
        .willStepSwitchProcess { current, next in
            print("current \(current) -> next \(next)")
        }
    
    
    var body: some View {
        StepView(controller: controller)
            .onReceive(controller.$stepState) { state in
                if case .complete = state {
                    print("step view is finished")
                }
            }
    }
}



//MARK: - ExampleStepType
enum ExampleStepType {
    case screen1
    case screen2
    case screen3
    
    static func stepSequence () -> [ExampleStepType]{
        return [
            ExampleStepType.screen1,
            ExampleStepType.screen2,
            ExampleStepType.screen3
        ]
    }
}



//MARK: - ExampleStepType+StepView
extension ExampleStepType {
    func toStepContent()-> StepContent<ExampleStepType>  {
        switch (self) {
        case .screen1:
            return StepContent(step: .screen1) {
                Screen1().toAnyView()
            }
        case .screen2:
            return StepContent(step: .screen2) {
                Screen2().toAnyView()
            }
        case .screen3:
            return StepContent(step: .screen3) {
                Screen3().toAnyView()
            }
        }
    }
}


//MARK: - Example Screen



struct Screen1: View {
    @EnvironmentObject
    var controller: StepController<ExampleStepType>
    
    var body: some View {
        VStack {
            Text("Screen 1 Content")
            Spacer()
            Button {
                controller.nextContent()
            } label: {
                Text("Next Content")
            }
            Spacer()
        }
    }
}



struct Screen2: View {
    @EnvironmentObject
    var controller: StepController<ExampleStepType>
    
    
    var body: some View {
        VStack {
            Text("Screen 2 Content")
            Spacer()
            Button {
                controller.nextContent()
            } label: {
                Text("Next Content")
            }
            Spacer()
        }
    }
}


struct Screen3: View {
    @EnvironmentObject
    var controller: StepController<ExampleStepType>
    
    var body: some View {
        VStack {
            Text("Screen 3 Content")
            Spacer()
            Button {
                controller.nextContent()
            } label: {
                Text("Next Content")
            }
            Spacer()
        }
    }
}
