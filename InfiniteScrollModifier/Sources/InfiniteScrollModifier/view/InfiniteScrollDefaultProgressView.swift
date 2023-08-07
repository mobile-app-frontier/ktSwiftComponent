//
//  InfiniteScrollDefaultProgressView.swift
//  GeniePhone
//
//  Created by kimrlyunah on 2023/04/18.
//

import SwiftUI

struct InfiniteScrollDefaultProgressView: View {
    @State private var isProgress = false
    var body: some View {
        HStack{
             ForEach(0...4, id: \.self){index in
                  Circle()
                        .frame(width:10,height:10)
                        .foregroundColor(.red)
                        .scaleEffect(self.isProgress ? 1:0.01)
                        .animation(self.isProgress ? Animation.linear(duration:0.6).repeatForever().delay(0.2*Double(index)) :
                             .default
                        , value: isProgress)
             }
        }
        .onAppear { isProgress = true }
        .padding()
    }
}
