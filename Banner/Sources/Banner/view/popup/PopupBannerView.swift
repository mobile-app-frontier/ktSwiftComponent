//
//  PopupBannerView.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/12.
//

import SwiftUI

/// PopupBannerView. 
///
/// Content 높이에 따라서 View 를 보여줌.
/// 
/// - Important: 실제 bottom sheet 처럼 보여주기 위해서는 해당 View 를 present 할 때 UIViewController 의 배경색을 투명하게 혹은 dim 처리된 색상으로 변경하고, UIModalPresentationStyle 을 .overCurrentContext 로 지정해주어야 함.
public struct PopupBannerView: View {
    /// 기본 Initializer
    /// - Parameter banner: View 에서 보여줄 `PopupBanner` 정보
    public init(banner: PopupBannerPolicyItem) {
        self.banner = banner
    }
    
    let banner: PopupBannerPolicyItem
    
    @State
    private var offsetY: CGFloat = -20
    
    @State
    private var height: CGFloat = 0
    
    private let topSafeArea: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    private let bottomSafeArea: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    private let leftSafeArea: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.left ?? 0
    private let rightSafeArea: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.right ?? 0
    
    private let animationDuration = 0.4
    
    private var safeWidth: CGFloat {
        UIScreen.main.bounds.width - leftSafeArea - rightSafeArea 
    }
    
    private var systemHeight: CGFloat {
        UIScreen.main.bounds.height - bottomSafeArea - topSafeArea - 100
    }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            Color.black
                .opacity(0.01)
                .onTapGesture {
                    hide()
                }
                .onAnimationCompleted(for: offsetY) {
                    if offsetY == height {
                        if case .closeOnly = banner.closeType {
                            BannerManager.instance.dismissAndPresentPopup(
                                id: banner.id,
                                notShowedDate: banner.closeType.notShowedDate
                            )
                        } else {
                            BannerManager.instance.dismissAndPresentPopup()
                        }
                    }
                }
            VStack(spacing: 10) {
                /// content
                PopupContentBannerView(banner: banner)
                    .onTapGesture {
                        BannerManager.instance.send(landingType: banner.landingType)
                        // inApp landing 일 경우, sheet 를 닫음.
                        if case .inApp(_) = banner.landingType {
                            hide()
                            BannerManager.instance.clearWillShowBanner()
                        }
                    }
            }
                .overlay(GeometryReader {
                    Color.clear.preference(
                        key: ContentSizeKey.self,
                        value: $0.size
                    )
                })
                .onPreferenceChange(ContentSizeKey.self) { size in
                    height = size.height
                    offsetY = height
                    withAnimation(.easeInOut(duration: animationDuration)) {
                        offsetY = 0
                    }
                }
                .background(Color.white.edgesIgnoringSafeArea(.all))
                .cornerRadius(10, corners: [.topLeft, .topRight])
                .shadow(radius: 10)
                .offset(y: offsetY)
        }
        .ignoresSafeArea()
    }
    
    private func hide() {
        withAnimation(.easeInOut(duration: animationDuration)) {
            offsetY = height
        }
    }
}


struct PopupBannerView_Previews: PreviewProvider {
    static var previews: some View {
        PopupBannerView(banner: PopupBannerPolicyItem(id: "1",
                                                      priority: 1,
                                                      targetAppversion: nil,
                                                      landingType: .none,
                                                      content:
//                .html("<h1>Hello, <strong>World!</strong></h1>"),
                .text("blablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablablabla"),
//                .image(url: "https://fastly.picsum.photos/id/565/1000/600.jpg?hmac=oJQa8_RLVzpyhJggqcyNnMUelPH8nqYUaqj65ws0p5c"),
//            .text("test"),
                                                      closeType: .closeOnly))
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

private struct ContentSizeKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

// https://www.avanderlee.com/swiftui/withanimation-completion-callback/
/// An animatable modifier that is used for observing animations for a given animatable value.
struct AnimationCompletionObserverModifier<Value>: AnimatableModifier where Value: VectorArithmetic {

    /// While animating, SwiftUI changes the old input value to the new target value using this property. This value is set to the old value until the animation completes.
    var animatableData: Value {
        didSet {
            notifyCompletionIfFinished()
        }
    }

    /// The target value for which we're observing. This value is directly set once the animation starts. During animation, `animatableData` will hold the oldValue and is only updated to the target value once the animation completes.
    private var targetValue: Value

    /// The completion callback which is called once the animation completes.
    private var completion: () -> Void

    init(observedValue: Value, completion: @escaping () -> Void) {
        self.completion = completion
        self.animatableData = observedValue
        targetValue = observedValue
    }

    /// Verifies whether the current animation is finished and calls the completion callback if true.
    private func notifyCompletionIfFinished() {
        guard animatableData == targetValue else { return }

        /// Dispatching is needed to take the next runloop for the completion callback.
        /// This prevents errors like "Modifying state during view update, this will cause undefined behavior."
        DispatchQueue.main.async {
            self.completion()
        }
    }

    func body(content: Content) -> some View {
        /// We're not really modifying the view so we can directly return the original input value.
        return content
    }
}

extension View {

    /// Calls the completion handler whenever an animation on the given value completes.
    /// - Parameters:
    ///   - value: The value to observe for animations.
    ///   - completion: The completion callback to call once the animation completes.
    /// - Returns: A modified `View` instance with the observer attached.
    func onAnimationCompleted<Value: VectorArithmetic>(for value: Value, completion: @escaping () -> Void) -> ModifiedContent<Self, AnimationCompletionObserverModifier<Value>> {
        return modifier(AnimationCompletionObserverModifier(observedValue: value, completion: completion))
    }
}
