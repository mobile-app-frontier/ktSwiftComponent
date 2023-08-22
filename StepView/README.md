# StepView

온보딩 등 화면이 순서를 갖고 이동할 때 사용되는 View다.

- [example](#example)
- [구성](#구성)

## example

``` Swift 
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

```


## 구성
1. StepView
2. StepController
3. StepViewState
4. StepContent

### StepView : View
Step의 순서에 맞게 화면을 노축 시켜주는 View

#### initialize
- Parameters:
 - controller: Step Controller
 - useAnimation: content변경시 animation을 사용할 지 말 지 에 대한 요소
 
init(controller: StepController<T>, useAnimation: Bool = true) 

### StepController : ObservableObject

StepView의 어떤 Content 를 노출 시킬지 제어 하는 class

#### initialize
- Parameters:
 - contents: StepView에서 제어할 StepContent List 
 - initialIndex: 초기 노출 시킬 index
 - config: controller option으로 내부 동작을 정의해 줄 수 있다.
 
init(contents: [StepContent<T>], initialIndex: Int, config: StepControllerOptions = StepControllerOptions.defaultOption )

*
StepControllerOptions: StepController의 옵션으로 내부 동작을 정의해 줄 수 있다
제공 기능
cycleBehavior: 끝에 도달했을 시 자동으로 처음으로 인덱스를 변경해주는 기능.
*

#### functions

- getContentIndex(content: StepContent<T>): Int?
descrption
특정 StepContent의 index를 return하는 function

param: 
- content: 조회할 content의 index
return: content의 index (list에 content가 없다면, nil을 return)

- appendContent(content: StepContent<T>)
descrption
초기화에 설정된 StepContent가 아닌 신규 StepContent를 추가 하는 기능으로, 추가시 맨 마지막에 추가가 된다.

param: 
- content: 신규로 추가 할 StepContent

- nextContent()
descrption
이전 Content 노출

- prevContent()
descrption
다음 Content 노출

### StepViewState

StepView 의 상태로
start : 시작상태
inprogress: 동작중인 상태
complete: 마지막 content 에서 다음 Content로 이동 요청시
exit : 처음 Content에서 이전 content로 이동 요청시


### StepContent
StepView에서 Content의 구분을 위한 객체
