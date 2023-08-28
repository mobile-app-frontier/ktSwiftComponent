//
//  DefaultBannerView.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/11.
//

import SwiftUI
import Kingfisher
import Utils

// https://www.youtube.com/watch?v=uo8gj7RT3H8
/// [DefaultBannerPolicyItem] 을 Image Slider 형식으로 만들어 주는 View.
/// - Important: 같은 카테고리의 배너들은 같은 이미지 비율을 가져야 함.
public struct DefaultBannerView: View {
    let defaultBanners: [DefaultBannerPolicyItem]
    
    @State
    private var height: CGFloat? = nil
    
    // offset
    @State
    private var offset: CGFloat = 0
    
    public var body: some View {
        GeometryReader { geometry in
            TabView {
                ForEach(defaultBanners.indices, id: \.self) { index in
                    // offset 계산
                    if index == 0 {
                        ImageView(banner: defaultBanners[index],
                                  width: geometry.size.width,
                                  height: $height)
                        .overlay(
                            // geometry Reader for getting offset
                            GeometryReader { proxy -> Color in
                                let minX = proxy.frame(in: .global).minX
                                
                                Task {
                                    await MainActor.run {
                                        withAnimation(.default) {
                                            self.offset = -minX
                                        }
                                    }
                                }
                                return Color.clear
                            }
                                .frame(width: 0, height: 0)
                            , alignment: .leading
                        )
                    }
                    else {
                        ImageView(banner: defaultBanners[index],
                                  width: geometry.size.width,
                                  height: $height)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
        }
        .frame(height: height)
        .cornerRadius(10)
        .overlay (
            // Animated Indicators
            HStack(spacing: 10) {
                ForEach(defaultBanners.indices, id: \.self) { index in
                    Capsule()
                        .fill(Color.white)
                        .frame(width: getIndex() == index ? 20 : 7, height: 7)
                }
            }
                .padding(.bottom, 10)
            , alignment: .bottom
        )
    }
    
    // getting Index
    private func getIndex() -> Int {
        let index = Int(round(Double(offset / getWidth())))
        
        return index
    }
}

fileprivate extension View {
    func getWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
}

private struct ImageView: View {
    let banner: DefaultBannerPolicyItem
    
    let width: CGFloat
    
    @State
    private var heightRatio: CGFloat = 1
    
    @Binding
    var height: CGFloat?
    
    var body: some View {
        KFImage.url(banner.content.url)
            .loadDiskFileSynchronously()
        //            .fade(duration: 0.25)
            .onProgress { receivedSize, totalSize in
                
            }
            .onSuccess { result in
                let imageSize = result.image.size
                heightRatio = imageSize.height / imageSize.width
            }
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width)
            .onTapGesture {
                BannerManager.instance.send(landingType: banner.landingType)
            }
            .onChange(of: width) { newValue in
                height = newValue * heightRatio
            }
            .onChange(of: heightRatio) { newValue in
                height = width * newValue
            }
    }
}

struct DefaultBannerView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultBannerView(defaultBanners: [
            DefaultBannerPolicyItem(id: "1111", priority: 1, targetAppversion: Version("1.0.0"), landingType: .none, content: .image(url: "https://fastly.picsum.photos/id/668/500/100.jpg?hmac=_H_udLJmfNoUADzswUtbwREyM_Gi8FhAfJam4K4eeBs"), category: "test"),
            DefaultBannerPolicyItem(id: "2222", priority: 1, targetAppversion: Version("1.0.0"), landingType: .none, content: .image(url: "https://fastly.picsum.photos/id/668/500/100.jpg?hmac=_H_udLJmfNoUADzswUtbwREyM_Gi8FhAfJam4K4eeBs"), category: "test"),
            DefaultBannerPolicyItem(id: "3", priority: 1, targetAppversion: Version("1.0.0"), landingType: .none, content: .image(url: "https://fastly.picsum.photos/id/668/500/100.jpg?hmac=_H_udLJmfNoUADzswUtbwREyM_Gi8FhAfJam4K4eeBs"), category: "test")
        ])
    }
}


