import SwiftUI
import AnimationView

struct ContentView: View {
    @State
    var contentVisible: Bool = false
    
    @State
    var isShimmering: Bool = false
    
    var body: some View {
        VStack {
            TestSet {
                contentVisible = !contentVisible
            } toggleShimmering: {
                isShimmering = !isShimmering
            }

            Spacer()
            /**
             visible animation
             */
            Text("hello world (visible content)")
                .animateVisible(visible: contentVisible)
            
            /**
             shimmering view
             */
            Text("shimmering")
                .shimmering(active: isShimmering)
            
            Spacer()
        }
    }
}


struct TestSet:View {
    
    let toggleVisible: ()->Void
    
    let toggleShimmering: ()->Void
    
    
    var body: some View {
        HStack {
            Button {
                toggleVisible()
            } label: {
                Text("Visible On/Off")
            }
            Spacer()
            Button {
                toggleShimmering()
            } label: {
                Text("Shimmering On/Off")
            }

        }
    }

}
