//
//  PopupHtmlContentBannerView.swift
//  GeniePhone
//
//  Created by 이소정 on 2023/04/13.
//

import SwiftUI
import WebKit

// html Type 의 popupBanner View.
internal struct PopupHtmlContentBannerView: View {
    let htmlString: String
    let id: String
    let closeType: BannerCloseType
    
    @State
    var height: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 10) {
            HtmlContentView(htmlString: htmlString, height: $height)
                .frame(height: height)
            
            if (height != 0) {
                /// button
                PopupButtonBannerView(bannerId: id,
                                      closeType: closeType)
                    .buttonStyle(.plain)
            }
        }
    }
    
}

private struct HtmlContentView: UIViewRepresentable {
    let htmlString: String
    
    @Binding
    var height: CGFloat

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.navigationDelegate = context.coordinator
        uiView.loadHTMLString(htmlString, baseURL: nil)
        
//        uiView.scrollView.bounces = false
//        uiView.scrollView.isScrollEnabled = false
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(webViewHeight: $height)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        @Binding var webViewHeight: CGFloat

        init(webViewHeight: Binding<CGFloat>) {
            _webViewHeight = webViewHeight
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//            webView.evaluateJavaScript("document.body.scrollHeight") { (result, error) in
//                if let height = result as? CGFloat {
//                    self.webViewHeight = height
//                }
//            }
            
            webView.evaluateJavaScript("document.readyState",
                                       completionHandler: { (complete, error) in
                    if complete != nil {
                        webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { (height, error) in
                            
                            if let height = height as? CGFloat, self.webViewHeight == 0 {
                                
                                withAnimation(.linear(duration: 0.3)) {
                                    self.webViewHeight = height
                                }
                                
                            }
                        })
                    }

                    })
        }
    }
}

struct PopupHtmlContentBannerView_Previews: PreviewProvider {
    static var previews: some View {
        PopupHtmlContentBannerView(htmlString: "<h1>Hello, <strong>World!</strong></h1>", id: "2", closeType: .closeOnly)
    }
}
