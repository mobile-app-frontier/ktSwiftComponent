import SwiftUI
import PermissionManager

struct ContentView: View {
    var body: some View {
        VStack {
            Button {
                Task {
                    let result = await PermissionManager.instance.currentPermissionCondition(.camera)
                }
            } label: {
                Text("CheckPermission")
            }
            
            Button {
                Task {
                    await PermissionManager.instance.requestPermission(.camera)
                }
            } label: {
                Text("RequestPermission")
            }
        }
    }
}
